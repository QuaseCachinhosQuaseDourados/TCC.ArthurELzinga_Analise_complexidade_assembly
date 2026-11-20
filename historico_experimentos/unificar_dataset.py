"""Junta todos os .s e CSVs num único dataset."""
import os, re, csv, shutil, sys
from collections import Counter

sys.stdout.reconfigure(encoding='utf-8')

DIR_UNIFICADO   = "todos_asm"
CSV_ORIGINAL    = "instrucoes_completo.csv"
CSV_LEETCODE    = "classificar_leetcode/classificacao_leetcode.csv"
CSV_FINAL       = "instrucoes_dataset_final.csv"

PASTAS_ORIGEM = [
    ("codigos_asm",          "gfg_"),
    ("codigos_externos_asm", "ext_"),
    ("codigos_leetcode_asm", ""),
]

COLUNAS_INSTRUCOES = [
    'mov', 'call', 'lea', 'add', 'push', 'pop', 'cmp',
    'sub', 'ret', 'jmp', 'je', 'test', 'movslq', 'jne', 'jle'
]

os.makedirs(DIR_UNIFICADO, exist_ok=True)

copiados = 0
for pasta, prefixo in PASTAS_ORIGEM:
    for f in os.listdir(pasta):
        if not f.endswith('.s'):
            continue
        nome_dest = f if f.startswith(prefixo) or prefixo == "" else prefixo + f
        # Evita sobrescrever se já existir com mesmo nome
        if nome_dest.startswith("ext_ext_"):
            nome_dest = nome_dest[4:]
        src = os.path.join(pasta, f)
        dst = os.path.join(DIR_UNIFICADO, nome_dest)
        shutil.copy2(src, dst)
        copiados += 1

print(f"Copiados {copiados} arquivos .s para {DIR_UNIFICADO}/")
total_unificado = len([f for f in os.listdir(DIR_UNIFICADO) if f.endswith('.s')])
print(f"Total na pasta unificada: {total_unificado}")


# 2a. Ler dados originais + externos (já têm label real)
with open(CSV_ORIGINAL, newline='', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    originais = list(reader)

for row in originais:
    if row['arquivo'].startswith('ext_'):
        row['origem'] = 'geeksforgeeks-c-github'
    else:
        row['origem'] = 'geeksforgeeks-json'

print(f"\nAmostras originais+externas: {len(originais)}")

# 2b. Ler classificações do LeetCode (labels preditos)
with open(CSV_LEETCODE, newline='', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    leetcode_rows = list(reader)

# Mapear classe predita de volta para notação Big-O
CLASSE_PARA_BIGO = {
    "Constante":   "O(1)",
    "Logaritmica": "O(log n)",
    "Linear":      "O(n)",
    "Superlinear": "O(n log n)",
    "Polinomial":  "O(n^2)",
    "Exponencial": "O(2^n)",
}

novos = []
for row in leetcode_rows:
    classe = row.get('classe_predita', '')
    bigo = CLASSE_PARA_BIGO.get(classe, '')
    nova_linha = {
        'arquivo': row['arquivo'],
        'time_complexity': bigo,
        'space_complexity': '',
        'origem': 'leetcode-in-c-predito',
    }
    for col in COLUNAS_INSTRUCOES:
        nova_linha[col] = row.get(col, 0)
    novos.append(nova_linha)

print(f"Amostras LeetCode (preditas): {len(novos)}")

# 2c. Combinar e salvar
todas = originais + novos
cabecalho = ['arquivo'] + COLUNAS_INSTRUCOES + ['time_complexity', 'space_complexity', 'origem']

with open(CSV_FINAL, 'w', newline='', encoding='utf-8') as f:
    writer = csv.DictWriter(f, fieldnames=cabecalho)
    writer.writeheader()
    for row in todas:
        out = {col: row.get(col, '') for col in cabecalho}
        writer.writerow(out)

print(f"\nCSV final salvo em: {CSV_FINAL}")
print(f"Total de amostras: {len(todas)}")

dist = Counter()
dist_origem = {}
for row in todas:
    tc = row.get('time_complexity', '')
    if tc:
        dist[tc] += 1
        orig = row.get('origem', '?')
        if tc not in dist_origem:
            dist_origem[tc] = Counter()
        dist_origem[tc][orig] += 1

print(f"\n{'Classe':<15} {'GFG-JSON':>10} {'GFG-GitHub':>12} {'LeetCode':>10} {'Total':>8}")
print("-" * 60)
for cls in sorted(dist.keys()):
    gfg_json = dist_origem[cls].get('geeksforgeeks-json', 0)
    gfg_gh = dist_origem[cls].get('geeksforgeeks-c-github', 0)
    lc = dist_origem[cls].get('leetcode-in-c-predito', 0)
    print(f"  {cls:<13} {gfg_json:>10} {gfg_gh:>12} {lc:>10} {dist[cls]:>8}")

sem_label = sum(1 for r in todas if not r.get('time_complexity'))
print(f"\n  Sem label: {sem_label}")
print(f"  Com label: {len(todas) - sem_label}")
