"""Classifica os códigos do LeetCode-in-C com o modelo v5."""
import os, re, subprocess, csv, sys

sys.stdout.reconfigure(encoding='utf-8')

LEETCODE_REPO   = r"fontes_externas\LeetCode-in-C\src\main\c"
DIR_C           = r"codigos_leetcode_c"
DIR_ASM         = r"codigos_leetcode_asm"
DIR_RESULTADOS  = r"classificar_leetcode"
MODELO_PATH     = os.path.join(DIR_RESULTADOS, "modelo_v5.pkl")
CSV_RESULTADO   = os.path.join(DIR_RESULTADOS, "classificacao_leetcode.csv")
LOG_FALHAS      = os.path.join(DIR_RESULTADOS, "compilacao_falhas.txt")

# As 15 instruções (mesma ordem do pipeline principal)
COLUNAS_INSTRUCOES = [
    'mov', 'call', 'lea', 'add', 'push', 'pop', 'cmp',
    'sub', 'ret', 'jmp', 'je', 'test', 'movslq', 'jne', 'jle'
]

LEETCODE_PREAMBULO = """\
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <limits.h>
#include <math.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

"""

HEADERS_NECESSARIOS = [
    '<stdio.h>', '<stdlib.h>', '<string.h>',
    '<stdbool.h>', '<limits.h>', '<stddef.h>', '<math.h>',
]

def preparar_codigo(texto: str) -> str:
    """Substitui non-breaking spaces e adiciona headers/structs do LeetCode."""
    texto = texto.replace('\u00a0', ' ')

    preambulo = ""
    for h in HEADERS_NECESSARIOS:
        if h not in texto:
            preambulo += f"#include {h}\n"

    for struct_name in ['struct ListNode', 'struct TreeNode', 'struct Node']:
        if struct_name in texto and f'{struct_name} {{' not in texto:
            pass
        else:
            continue

    # Remove comentários de bloco e linha para checagem de definição
    codigo_sem_comentarios = re.sub(r'/\*.*?\*/', '', texto, flags=re.DOTALL)
    codigo_sem_comentarios = re.sub(r'//.*', '', codigo_sem_comentarios)

    STRUCTS_INDIVIDUAIS = {
        'struct ListNode': "struct ListNode { int val; struct ListNode *next; };\n",
        'struct TreeNode': "struct TreeNode { int val; struct TreeNode *left; struct TreeNode *right; };\n",
        'struct Node':     "struct Node { int val; struct Node *next; struct Node *random; };\n",
    }
    for nome_struct, definicao in STRUCTS_INDIVIDUAIS.items():
        usa = nome_struct in codigo_sem_comentarios
        ja_define = re.search(
            rf'(typedef\s+)?{re.escape(nome_struct)}\s*\{{',
            codigo_sem_comentarios
        ) is not None
        if usa and not ja_define:
            preambulo += definicao

    return preambulo + texto

IGNORAR_PREFIXOS = {'.', '#', ';'}
BASE_COM_SUFIXO = {
    'mov', 'add', 'sub', 'and', 'or', 'xor', 'not', 'neg',
    'cmp', 'test', 'imul', 'idiv', 'div', 'mul',
    'push', 'pop', 'lea', 'inc', 'dec',
    'sar', 'shr', 'shl', 'sal', 'ror', 'rol',
    'movs', 'movz', 'movzx', 'movsx', 'cmov', 'set', 'j',
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

def coletar_arquivos_leetcode():
    """Retorna lista de (caminho_origem, nome_saida)."""
    coletados = []
    for root, dirs, files in os.walk(LEETCODE_REPO):
        dirs[:] = [d for d in dirs if d != '.git']
        for f in files:
            if not f.endswith('.c'):
                continue
            caminho = os.path.join(root, f)
            # nome único: pasta pai (ex: s0001_two_sum) → leetcode_s0001_two_sum.c
            pasta = os.path.basename(root)
            nome_saida = f"leetcode_{pasta}.c"
            coletados.append((caminho, nome_saida))
    return coletados

def main():
    os.makedirs(DIR_C, exist_ok=True)
    os.makedirs(DIR_ASM, exist_ok=True)
    os.makedirs(DIR_RESULTADOS, exist_ok=True)

    print("=== Coletando arquivos .c do LeetCode-in-C ===")
    coletados = coletar_arquivos_leetcode()
    print(f"Encontrados: {len(coletados)} arquivos")

    # 1. Copia e prepara .c (adiciona headers/structs do ambiente LeetCode)
    for caminho_orig, nome_saida in coletados:
        saida = os.path.join(DIR_C, nome_saida)
        with open(caminho_orig, encoding='utf-8', errors='replace') as fin:
            codigo = fin.read()
        with open(saida, 'w', encoding='utf-8') as fout:
            fout.write(preparar_codigo(codigo))

    # 2. Compila para assembly
    print("\n=== Compilando para assembly ===")
    sucesso = []
    falhas = []
    for caminho_orig, nome_saida in coletados:
        nome_base = nome_saida[:-2]
        caminho_c = os.path.join(DIR_C, nome_saida)
        caminho_s = os.path.join(DIR_ASM, nome_base + ".s")
        res = subprocess.run(
            ["gcc", "-S", "-O1", "-w", "-x", "c", caminho_c, "-o", caminho_s],
            capture_output=True, text=True
        )
        if res.returncode == 0 and os.path.exists(caminho_s):
            sucesso.append((nome_base + ".s", os.path.basename(os.path.dirname(caminho_orig))))
        else:
            falhas.append((nome_saida, res.stderr.strip()))
            if os.path.exists(caminho_s):
                os.remove(caminho_s)

    print(f"Compilados: {len(sucesso)} | Falhas: {len(falhas)}")

    with open(LOG_FALHAS, 'w', encoding='utf-8') as f:
        for arq, err in falhas:
            f.write(f"FALHA: {arq}\n{err}\n\n")

    if not sucesso:
        print("Nenhum arquivo compilou. Encerrando.")
        return

    # 3. Extrai features
    print("\n=== Extraindo features de assembly ===")
    from collections import Counter
    dados = []
    for nome_s, problema in sucesso:
        caminho_s = os.path.join(DIR_ASM, nome_s)
        instrucoes = extrair_instrucoes(caminho_s)
        contador = Counter(instrucoes)
        linha = {"arquivo": nome_s, "problema": problema}
        for col in COLUNAS_INSTRUCOES:
            linha[col] = contador.get(col, 0)
        dados.append(linha)

    # 4. Treina ou carrega modelo, classifica
    print("\n=== Classificando com modelo v5 (Random Forest) ===")
    import pandas as pd
    import joblib

    df_feat = pd.DataFrame(dados)
    X = df_feat[COLUNAS_INSTRUCOES].values

    if os.path.exists(MODELO_PATH):
        print(f"Carregando modelo de {MODELO_PATH}")
        clf = joblib.load(MODELO_PATH)
    else:
        print("Modelo não encontrado. Treinando a partir de instrucoes_completo.csv...")
        from sklearn.ensemble import RandomForestClassifier
        MAPA = {
            "O(1)": "Constante", "O(log n)": "Logaritmica", "O(sqrt(n))": "Logaritmica",
            "O(n)": "Linear", "O(n log n)": "Superlinear", "O(n*m)": "Superlinear",
            "O(n^2)": "Polinomial", "O(n^3)": "Polinomial", "O(2^n)": "Exponencial",
        }
        df_treino = pd.read_csv("instrucoes_completo.csv")
        df_treino = df_treino[df_treino["time_complexity"].notna() & (df_treino["time_complexity"] != "")]
        df_treino["classe"] = df_treino["time_complexity"].map(MAPA)
        df_treino = df_treino.dropna(subset=["classe"])
        contagem = df_treino["classe"].value_counts()
        classes_ok = contagem[contagem >= 3].index
        df_treino = df_treino[df_treino["classe"].isin(classes_ok)]
        X_tr = df_treino[COLUNAS_INSTRUCOES].values
        y_tr = df_treino["classe"].values
        clf = RandomForestClassifier(n_estimators=200, random_state=42, n_jobs=-1)
        clf.fit(X_tr, y_tr)
        joblib.dump(clf, MODELO_PATH)
        print(f"Modelo salvo em {MODELO_PATH}")

    predicoes = clf.predict(X)
    df_feat["classe_predita"] = predicoes

    # 5. Salva resultado
    with open(CSV_RESULTADO, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=["arquivo", "problema", "classe_predita"] + COLUNAS_INSTRUCOES)
        writer.writeheader()
        for _, row in df_feat.iterrows():
            writer.writerow(row.to_dict())

    print(f"\nResultado salvo em: {CSV_RESULTADO}")
    print("\nDistribuição das classes preditas:")
    from collections import Counter as Cnt
    for cls, qtd in Cnt(predicoes).most_common():
        print(f"  {cls}: {qtd}")

if __name__ == "__main__":
    main()
