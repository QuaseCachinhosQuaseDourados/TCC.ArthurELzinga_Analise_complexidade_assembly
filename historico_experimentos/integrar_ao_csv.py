"""Extrai features dos .s externos e junta ao CSV original."""
import os, re, csv, sys
from collections import Counter

sys.stdout.reconfigure(encoding='utf-8')

CSV_ORIGINAL   = "instrucoes_por_arquivo.csv"
ASM_EXTERNOS   = "codigos_externos_asm"
LOG_COMPLEXIDADE = "complexidades_externas.txt"
CSV_SAIDA      = "instrucoes_completo.csv"

IGNORAR_PREFIXOS = {'.', '#', ';'}

BASE_COM_SUFIXO = {
    'mov', 'add', 'sub', 'and', 'or', 'xor', 'not', 'neg',
    'cmp', 'test', 'imul', 'idiv', 'div', 'mul',
    'push', 'pop', 'lea', 'inc', 'dec',
    'sar', 'shr', 'shl', 'sal', 'ror', 'rol',
    'movs', 'movz', 'movzx', 'movsx', 'cmov',
    'set', 'j',
}
SUFIXO_TAMANHO = re.compile(r'^(.+?)[bwlq]$')

def normalizar(mnem: str) -> str:
    mnem = mnem.lower()
    m = SUFIXO_TAMANHO.match(mnem)
    if m:
        base = m.group(1)
        if base in BASE_COM_SUFIXO:
            return base
    return mnem

def extrair_instrucoes(caminho_asm: str) -> list:
    instrucoes = []
    with open(caminho_asm, "r", encoding="utf-8", errors="replace") as f:
        for linha in f:
            linha_strip = linha.strip()
            if not linha_strip:
                continue
            if linha_strip[0] in IGNORAR_PREFIXOS:
                continue
            if linha_strip.endswith(':'):
                continue
            partes = linha_strip.split()
            if partes:
                mnem = normalizar(partes[0])
                if mnem.startswith('.') or mnem.startswith('#'):
                    continue
                instrucoes.append(mnem)
    return instrucoes

with open(CSV_ORIGINAL, newline='', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    cabecalho_original = reader.fieldnames
    linhas_originais = list(reader)

# Identifica as 15 colunas de instrução (entre 'arquivo' e 'time_complexity')
idx_tc = cabecalho_original.index("time_complexity")
colunas_instrucoes = cabecalho_original[1:idx_tc]
print(f"Colunas de instrução no CSV original: {colunas_instrucoes}")
print(f"Linhas originais: {len(linhas_originais)}")


MAPA = {
    "Backtracking":                                        "O(2^n)",
    "Divide_And_Conquer":                                  "O(n log n)",
    "Dynamic_Programming":                                 "O(n^2)",
    "Pattern_Generation":                                  "O(n^2)",
    "Pattern_Searching":                                   "O(n*m)",
    "Searching_And_Sorting_Sorting__bubble_sort":          "O(n^2)",
    "Searching_And_Sorting_Sorting__insertion_sort":       "O(n^2)",
    "Searching_And_Sorting_Sorting__selection_sort":       "O(n^2)",
    "Searching_And_Sorting_Sorting__merge_sort":           "O(n log n)",
    "Searching_And_Sorting_Sorting__quick_sort":           "O(n log n)",
    "Searching_And_Sorting_Sorting__comb_sort":            "O(n log n)",
    "Searching_And_Sorting_Sorting__shell_sort":           "O(n log n)",
    "Searching_And_Sorting_Sorting__counting_sort":        "O(n)",
    "Searching_And_Sorting_Sorting__radix_sort":           "O(n)",
    "Searching_And_Sorting_Searching__binary_search":      "O(log n)",
    "Searching_And_Sorting_Searching__linear_search":      "O(n)",
    "Searching_And_Sorting_Searching__exponential_search": "O(log n)",
    "Searching_And_Sorting_Searching__interpolation_search": "O(log n)",
    "Searching_And_Sorting_Searching__ternary_search":     "O(log n)",
    "Searching_And_Sorting_Searching__jump_search":        "O(sqrt(n))",
    "Searching_And_Sorting_Miscellaneous__almost_sorted_search":     "O(log n)",
    "Searching_And_Sorting_Miscellaneous__closest_sum_pair":         "O(n log n)",
    "Searching_And_Sorting_Miscellaneous__count_bool_array":         "O(n)",
    "Searching_And_Sorting_Miscellaneous__iterative_quick_sort":     "O(n log n)",
    "Searching_And_Sorting_Miscellaneous__k_closest":                "O(n log n)",
    "Searching_And_Sorting_Miscellaneous__linked_list_merge_sort":   "O(n log n)",
    "Searching_And_Sorting_Miscellaneous__ranged_to_n_sort":         "O(n)",
    "Searching_And_Sorting_Miscellaneous__sub_to_sort":              "O(n log n)",
    "Searching_And_Sorting_Miscellaneous__sum_pair_single_array":    "O(n)",
    "Searching_And_Sorting_Miscellaneous__three_array_intersection": "O(n log n)",
    "Searching_And_Sorting_Miscellaneous__wave_sort":                "O(n log n)",
    "Mathematical_Algorithms__eratosthenes_sieve":    "O(n log n)",
    "Mathematical_Algorithms__pascal_triangle":       "O(n^2)",
    "Mathematical_Algorithms__prime_check":           "O(sqrt(n))",
    "Mathematical_Algorithms__harshad_number":        "O(log n)",
    "Mathematical_Algorithms__babylonian_root":       "O(log n)",
    "Mathematical_Algorithms__bitwise_multiplication": "O(log n)",
    "Mathematical_Algorithms__stream_average":        "O(n)",
    "Greedy_Algorithms__activity_selection":          "O(n log n)",
    "Greedy_Algorithms__job_scheduling":              "O(n log n)",
    "Greedy_Algorithms__kruskal_mst":                 "O(n log n)",
    "Greedy_Algorithms__minimum_coins":               "O(n)",
}

def complexidade_do_nome(nome_s: str) -> str | None:
    """Ex: ext_Backtracking__n_queens_problem.s → chave candidata 'Backtracking'  (glob) ou específica"""
    # nome_s = ext_<cat_flat>__<algo>.s  (sem ext)
    nome_sem_ext = nome_s.replace('.s', '')
    # remove prefixo 'ext_'
    sem_ext_prefix = nome_sem_ext[4:] if nome_sem_ext.startswith('ext_') else nome_sem_ext

    # Tenta chave exata
    if sem_ext_prefix in MAPA:
        return MAPA[sem_ext_prefix]

    # Tenta prefixo de categoria
    for cat_prefix in ["Backtracking", "Divide_And_Conquer", "Dynamic_Programming",
                        "Pattern_Generation", "Pattern_Searching"]:
        if sem_ext_prefix.startswith(cat_prefix + "__"):
            return MAPA[cat_prefix]

    return None

novas_linhas = []
nao_mapeados = []

arquivos_externos = sorted(f for f in os.listdir(ASM_EXTERNOS) if f.endswith('.s'))
print(f"\nArquivos externos .s: {len(arquivos_externos)}")

for nome_s in arquivos_externos:
    complexidade = complexidade_do_nome(nome_s)
    if complexidade is None:
        nao_mapeados.append(nome_s)
        continue

    caminho_s = os.path.join(ASM_EXTERNOS, nome_s)
    instrucoes = extrair_instrucoes(caminho_s)
    contador = Counter(instrucoes)

    linha = {"arquivo": nome_s, "time_complexity": complexidade, "space_complexity": ""}
    for col in colunas_instrucoes:
        linha[col] = contador.get(col, 0)
    novas_linhas.append(linha)

print(f"Novas linhas adicionadas: {len(novas_linhas)}")
if nao_mapeados:
    print(f"Não mapeados: {nao_mapeados}")

todas_linhas = linhas_originais + novas_linhas

with open(CSV_SAIDA, 'w', newline='', encoding='utf-8') as f:
    writer = csv.DictWriter(f, fieldnames=cabecalho_original)
    writer.writeheader()
    writer.writerows(todas_linhas)

print(f"\nCSV completo salvo em: {CSV_SAIDA}")
print(f"Total de amostras: {len(todas_linhas)}")

from collections import Counter as Cnt
dist_orig = Cnt(l['time_complexity'] for l in linhas_originais if l['time_complexity'])
dist_novo = Cnt(l['time_complexity'] for l in novas_linhas)

print("\n=== Distribuição de classes ===")
print(f"{'Classe':<15} {'Original':>10} {'Novos':>8} {'Total':>8}")
print("-" * 45)
todas_classes = sorted(set(list(dist_orig.keys()) + list(dist_novo.keys())))
for cls in todas_classes:
    orig = dist_orig.get(cls, 0)
    novo = dist_novo.get(cls, 0)
    print(f"  {cls:<13} {orig:>10} {novo:>8} {orig+novo:>8}")
