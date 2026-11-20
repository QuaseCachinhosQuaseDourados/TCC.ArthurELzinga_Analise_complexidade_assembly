"""Integra códigos C de fontes externas ao pipeline."""
import os, re, shutil, subprocess, sys

sys.stdout.reconfigure(encoding='utf-8')

BASE_REPO  = r"fontes_externas\geeksForGeeks-C"
DIR_SAIDA  = r"codigos_externos_c"
DIR_ASM    = r"codigos_externos_asm"
LOG_FALHAS = r"compilacao_externos_falhas.txt"

os.makedirs(DIR_SAIDA, exist_ok=True)
os.makedirs(DIR_ASM,   exist_ok=True)

MAPA = {
    ("Backtracking", "*"): "O(2^n)",

    ("Divide_And_Conquer", "*"): "O(n log n)",

    ("Dynamic_Programming", "*"): "O(n^2)",

    ("Pattern_Generation", "*"): "O(n^2)",

    ("Pattern_Searching", "*"): "O(n*m)",

    ("Searching_And_Sorting/Sorting", "bubble_sort"):    "O(n^2)",
    ("Searching_And_Sorting/Sorting", "insertion_sort"): "O(n^2)",
    ("Searching_And_Sorting/Sorting", "selection_sort"): "O(n^2)",
    ("Searching_And_Sorting/Sorting", "merge_sort"):     "O(n log n)",
    ("Searching_And_Sorting/Sorting", "quick_sort"):     "O(n log n)",
    ("Searching_And_Sorting/Sorting", "comb_sort"):      "O(n log n)",
    ("Searching_And_Sorting/Sorting", "shell_sort"):     "O(n log n)",
    ("Searching_And_Sorting/Sorting", "counting_sort"):  "O(n)",
    ("Searching_And_Sorting/Sorting", "radix_sort"):     "O(n)",

    ("Searching_And_Sorting/Searching", "binary_search"):        "O(log n)",
    ("Searching_And_Sorting/Searching", "linear_search"):        "O(n)",
    ("Searching_And_Sorting/Searching", "exponential_search"):   "O(log n)",
    ("Searching_And_Sorting/Searching", "interpolation_search"): "O(log n)",
    ("Searching_And_Sorting/Searching", "ternary_search"):       "O(log n)",
    ("Searching_And_Sorting/Searching", "jump_search"):          "O(sqrt(n))",

    ("Searching_And_Sorting/Miscellaneous", "almost_sorted_search"):    "O(log n)",
    ("Searching_And_Sorting/Miscellaneous", "closest_sum_pair"):        "O(n log n)",
    ("Searching_And_Sorting/Miscellaneous", "count_bool_array"):        "O(n)",
    ("Searching_And_Sorting/Miscellaneous", "iterative_quick_sort"):    "O(n log n)",
    ("Searching_And_Sorting/Miscellaneous", "k_closest"):               "O(n log n)",
    ("Searching_And_Sorting/Miscellaneous", "linked_list_merge_sort"):  "O(n log n)",
    ("Searching_And_Sorting/Miscellaneous", "ranged_to_n_sort"):        "O(n)",
    ("Searching_And_Sorting/Miscellaneous", "sub_to_sort"):             "O(n log n)",
    ("Searching_And_Sorting/Miscellaneous", "sum_pair_single_array"):   "O(n)",
    ("Searching_And_Sorting/Miscellaneous", "three_array_intersection"): "O(n log n)",
    ("Searching_And_Sorting/Miscellaneous", "wave_sort"):               "O(n log n)",

    ("Mathematical_Algorithms", "eratosthenes_sieve"): "O(n log n)",
    ("Mathematical_Algorithms", "pascal_triangle"):    "O(n^2)",
    ("Mathematical_Algorithms", "prime_check"):        "O(sqrt(n))",
    ("Mathematical_Algorithms", "harshad_number"):     "O(log n)",
    ("Mathematical_Algorithms", "babylonian_root"):    "O(log n)",
    ("Mathematical_Algorithms", "bitwise_multiplication"): "O(log n)",
    ("Mathematical_Algorithms", "stream_average"):     "O(n)",

    ("Greedy_Algorithms", "activity_selection"): "O(n log n)",
    ("Greedy_Algorithms", "job_scheduling"):     "O(n log n)",
    ("Greedy_Algorithms", "kruskal_mst"):        "O(n log n)",
    ("Greedy_Algorithms", "minimum_coins"):      "O(n)",
}

def resolucao_complexidade(rel_pasta: str, nome_sem_ext: str) -> str | None:
    """Retorna a complexidade mapeada ou None se não mapeado."""
    rel_unix = rel_pasta.replace("\\", "/")
    chave_exata = (rel_unix, nome_sem_ext)
    if chave_exata in MAPA:
        return MAPA[chave_exata]
    chave_glob = (rel_unix, "*")
    if chave_glob in MAPA:
        return MAPA[chave_glob]
    return None

# Limpeza básica (mesma do pipeline principal)
C_KEYWORDS = [
    "unsigned","register","volatile","typedef","default","continue",
    "restrict","double","extern","return","static","struct","switch",
    "float","break","const","short","union","while","case","char",
    "else","enum","goto","long","void","auto","for","int","do","if",
]
KW_PAT = re.compile(r'\b(' + '|'.join(re.escape(k) for k in C_KEYWORDS) + r')([A-Za-z_0-9])')

def limpar(texto: str) -> str:
    texto = texto.replace('\u00a0', ' ')
    while True:
        novo = KW_PAT.sub(r'\1 \2', texto)
        if novo == texto: break
        texto = novo
    return texto

# Percorre o repositório
coletados = []

for root, dirs, files in os.walk(BASE_REPO):
    # ignora .git
    dirs[:] = [d for d in dirs if d != '.git']

    for fname in files:
        if not fname.endswith('.c'):
            continue

        rel_pasta = os.path.relpath(root, BASE_REPO)
        nome_sem_ext = fname[:-2]
        complexidade = resolucao_complexidade(rel_pasta, nome_sem_ext)
        if complexidade is None:
            continue

        # nome de saída único: categoria__arquivo.c
        cat_flat = rel_pasta.replace("\\", "_").replace("/", "_").replace(".", "")
        nome_saida = f"ext_{cat_flat}__{nome_sem_ext}.c"
        caminho_entrada = os.path.join(root, fname)
        caminho_saida   = os.path.join(DIR_SAIDA, nome_saida)

        codigo = open(caminho_entrada, encoding='utf-8', errors='replace').read()
        codigo_limpo = limpar(codigo)
        with open(caminho_saida, 'w', encoding='utf-8') as f:
            f.write(codigo_limpo)

        coletados.append((caminho_saida, complexidade, nome_saida[:-2]))

print(f"Coletados para compilação: {len(coletados)} arquivos")

# Compila para assembly
falhas = []
sucessos = []

for caminho_c, complexidade, nome_base in coletados:
    arquivo_s = os.path.join(DIR_ASM, nome_base + ".s")
    resultado = subprocess.run(
        ["gcc", "-S", "-O1", "-w", "-x", "c", caminho_c, "-o", arquivo_s],
        capture_output=True, text=True
    )
    if resultado.returncode == 0 and os.path.exists(arquivo_s):
        sucessos.append((arquivo_s, complexidade, nome_base))
    else:
        falhas.append((caminho_c, resultado.stderr.strip()))
        if os.path.exists(arquivo_s):
            os.remove(arquivo_s)

print(f"Compilados com sucesso: {len(sucessos)}")
print(f"Falhas de compilação:   {len(falhas)}")

with open(LOG_FALHAS, 'w', encoding='utf-8') as f:
    for caminho, err in falhas:
        f.write(f"FALHA: {caminho}\n{err}\n\n")

# Mostra distribuição
from collections import Counter
dist = Counter(c for _, c, _ in sucessos)
print("\nDistribuição por complexidade:")
for classe, qtd in sorted(dist.items()):
    print(f"  {classe}: {qtd}")

print(f"\nArquivos .s em: {DIR_ASM}/")
print("Próximo passo: rodar 'integrar_ao_csv.py'")
