"""Conta construtos sintáticos nos arquivos .c e gera ranking e CSV."""

import os
import re
import csv
import json
from collections import Counter

C_DIR    = "codigos_c"
JSON_SRC = "geeks_for_geeks.json"
OUT_RANK = "instrucoes_c_top_global.txt"
OUT_CSV  = "instrucoes_c_por_arquivo.csv"

TOP_N = 20

CONSTRUTOS: list[tuple[str, str]] = [
    # Operadores compostos (antes de operadores simples)
    ("op_incr",    r'\+\+'),
    ("op_decr",    r'--'),
    ("op_flechas", r'->'),
    ("op_and_log", r'&&'),
    ("op_or_log",  r'\|\|'),
    ("op_eq",      r'=='),
    ("op_neq",     r'!='),
    ("op_leq",     r'<='),
    ("op_geq",     r'>='),
    # Palavras-chave de fluxo
    ("for",        r'\bfor\b'),
    ("while",      r'\bwhile\b'),
    ("do",         r'\bdo\b'),
    ("if",         r'\bif\b'),
    ("else",       r'\belse\b'),
    ("switch",     r'\bswitch\b'),
    ("case",       r'\bcase\b'),
    ("return",     r'\breturn\b'),
    ("break",      r'\bbreak\b'),
    ("continue",   r'\bcontinue\b'),
    ("goto",       r'\bgoto\b'),
    # Tipos / estrutura
    ("struct",     r'\bstruct\b'),
    ("typedef",    r'\btypedef\b'),
    ("enum",       r'\benum\b'),
    # Alocação dinâmica
    ("malloc",     r'\bmalloc\b'),
    ("calloc",     r'\bcalloc\b'),
    ("realloc",    r'\brealloc\b'),
    ("free",       r'\bfree\b'),
    # I/O padrão
    ("printf",     r'\bprintf\b'),
    ("scanf",      r'\bscanf\b'),
    # Indexação de array
    ("idx_array",  r'\['),
    ("deref_ptr",  r'(?<![a-zA-Z0-9_])\*(?=[a-zA-Z_(])'),
]

RE_COMMENT_BLOCK  = re.compile(r'/\*.*?\*/', re.DOTALL)
RE_COMMENT_LINE   = re.compile(r'//[^\n]*')
RE_STRING_LITERAL = re.compile(r'"(?:[^"\\]|\\.)*"')
RE_CHAR_LITERAL   = re.compile(r"'(?:[^'\\]|\\.)*'")

CONSTRUTOS_RE = [(nome, re.compile(pat)) for nome, pat in CONSTRUTOS]


def limpar_codigo(fonte: str) -> str:
    """Remove comentários e strings literais para evitar falsos positivos."""
    fonte = RE_COMMENT_BLOCK.sub(' ', fonte)
    fonte = RE_COMMENT_LINE.sub(' ', fonte)
    fonte = RE_STRING_LITERAL.sub('""', fonte)
    fonte = RE_CHAR_LITERAL.sub("''", fonte)
    return fonte


def detectar_recursao(fonte_limpa: str) -> int:
    """Conta quantas vezes alguma função definida no arquivo chama a si mesma."""
    # Identifica definições de funções: qualquer `nome(` precedido de tipo
    defs = re.findall(
        r'\b([a-zA-Z_]\w*)\s*\([^)]*\)\s*\{',
        fonte_limpa
    )
    total = 0
    for nome_fn in set(defs):
        if nome_fn in {'if', 'for', 'while', 'switch', 'main'}:
            continue
        # Conta chamadas: nome_fn( no corpo (além da própria definição)
        ocorrencias = re.findall(rf'\b{re.escape(nome_fn)}\s*\(', fonte_limpa)
        chamadas = max(0, len(ocorrencias) - 1)
        total += chamadas
    return total


def extrair_construtos(caminho_c: str) -> Counter:
    """Lê um arquivo .c e retorna a contagem de cada construto."""
    with open(caminho_c, 'r', encoding='utf-8', errors='replace') as f:
        fonte = f.read()

    fonte_limpa = limpar_codigo(fonte)
    contador: Counter = Counter()

    for nome, regex in CONSTRUTOS_RE:
        contador[nome] = len(regex.findall(fonte_limpa))

    # Recursão como construto extra
    contador['recursao'] = detectar_recursao(fonte_limpa)

    return contador


def normalizar_complexidade(expr: str) -> str:
    """Mapeia variações de escrita para classe canônica (igual ao script assembly)."""
    if not expr:
        return ""
    s = re.sub(r'\s+', '', expr.strip().lower())

    if re.fullmatch(r'o\(1\)', s):
        return "O(1)"
    if re.fullmatch(r'o\(h\)', s):
        return "O(log n)"
    if re.search(r'log', s) and not re.search(r'n.*log.*n|nlog', s):
        return "O(log n)"
    if re.fullmatch(r'o\(n\)', s):
        return "O(n)"
    if re.search(r'nlog|n\*log|nlogn|n\*logn|nlog\(', s):
        return "O(n log n)"
    if re.search(r'log.*n.*n|n.*log', s) and not re.search(r'n2|n\^2|n\*n', s):
        return "O(n log n)"
    if re.fullmatch(r'o\(n2\)', s) or re.fullmatch(r'o\(n\^2\)', s):
        return "O(n^2)"
    if re.search(r'n2\)', s) or re.search(r'n\^2', s) or re.search(r'n\*n', s):
        return "O(n^2)"
    if re.search(r'n3\)', s) or re.search(r'n\^3', s):
        return "O(n^3)"
    if re.search(r'2n\)|2\^n|exponential', s):
        return "O(2^n)"
    if re.search(r'[mn]\*[nm]|[mn]x[nm]|\[mn\]\*|\[nm\]\*', s):
        return "O(n*m)"
    if re.search(r'n1/2|sqrt', s):
        return "O(sqrt(n))"
    return ""


def carregar_metadados_json() -> dict[str, dict]:
    """Constrói mapa nome_arquivo.c -> {time_complexity, space_complexity}."""
    with open(JSON_SRC, 'r', encoding='utf-8') as f:
        dados = json.load(f)

    mapa: dict[str, dict] = {}
    contadores: dict[str, int] = {}

    for entrada in dados:
        if not entrada.get('codes', {}).get('C', {}).get('code', '').strip():
            continue

        nome_raw = entrada.get('name', 'sem_nome').strip()
        nome_base = re.sub(r'[\\/*?:"<>|]', '', nome_raw)
        nome_base = re.sub(r'\s+', '_', nome_base)
        nome_base = re.sub(r'_+', '_', nome_base).strip('_')[:100]
        if not nome_base:
            nome_base = 'sem_nome'

        contadores[nome_base] = contadores.get(nome_base, 0) + 1
        cnt = contadores[nome_base]
        chave = nome_base if cnt == 1 else f'{nome_base}_{cnt}'

        mapa[chave + '.c'] = {
            'time_complexity':  entrada.get('time_complexity', ''),
            'space_complexity': entrada.get('space_complexity', ''),
            'url':              entrada.get('url', ''),
        }
    return mapa


def main():
    arquivos_c = sorted(f for f in os.listdir(C_DIR) if f.endswith('.c'))
    if not arquivos_c:
        print('Nenhum arquivo .c encontrado em', C_DIR)
        return

    print(f'Analisando {len(arquivos_c)} arquivos C...\n')

    contagem_global: Counter = Counter()
    contagem_por_arquivo: dict[str, Counter] = {}

    for nome in arquivos_c:
        caminho = os.path.join(C_DIR, nome)
        contador = extrair_construtos(caminho)
        contagem_por_arquivo[nome] = contador
        contagem_global.update(contador)

    top_construtos = [c for c, _ in contagem_global.most_common(TOP_N)]

    print(f'Top {TOP_N} construtos mais frequentes (global):')
    print('-' * 45)
    for rank, (c, total) in enumerate(contagem_global.most_common(TOP_N), 1):
        print(f'  {rank:>2}. {c:<15}  {total:>8} ocorrências')
    print()

    with open(OUT_RANK, 'w', encoding='utf-8') as f:
        f.write(f'Rank | Construto       | Total ocorrências\n')
        f.write('-' * 45 + '\n')
        for rank, (c, total) in enumerate(contagem_global.most_common(TOP_N), 1):
            f.write(f'  {rank:>2} | {c:<15} | {total}\n')
    print(f'Ranking salvo em: {OUT_RANK}')

    meta = carregar_metadados_json()

    cabecalho = ['arquivo'] + top_construtos + ['time_complexity', 'space_complexity']

    with open(OUT_CSV, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(cabecalho)

        for nome in arquivos_c:
            contador = contagem_por_arquivo[nome]
            info = meta.get(nome, {})
            linha = (
                [nome]
                + [contador.get(c, 0) for c in top_construtos]
                + [
                    normalizar_complexidade(info.get('time_complexity', '')),
                    normalizar_complexidade(info.get('space_complexity', '')),
                ]
            )
            writer.writerow(linha)

    print(f'CSV salvo em    : {OUT_CSV}')
    print(f'Colunas: arquivo | {" | ".join(top_construtos)} | time_complexity | space_complexity')
    print(f'\nTotal arquivos processados : {len(arquivos_c)}')
    print(f'Com metadados no JSON      : {sum(1 for n in arquivos_c if n in meta)}')


if __name__ == '__main__':
    main()
