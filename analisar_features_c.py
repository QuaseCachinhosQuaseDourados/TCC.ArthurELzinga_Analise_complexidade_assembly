"""Extrai features estruturais dos arquivos .c (laços, recursão, ramificações etc.)."""

import os
import re
import csv
import json
from collections import defaultdict

C_DIR    = "dados/codigos_c"
JSON_SRC = "dados/geeks_for_geeks.json"
OUT_CSV  = "dados/features_c_estrutural.csv"

RE_BLOCK  = re.compile(r'/\*.*?\*/', re.DOTALL)
RE_LINE   = re.compile(r'//[^\n]*')
RE_STR    = re.compile(r'"(?:[^"\\]|\\.)*"')
RE_CHAR   = re.compile(r"'(?:[^'\\]|\\.)*'")

def limpar(src: str) -> str:
    src = RE_BLOCK.sub(' ', src)
    src = RE_LINE.sub(' ', src)
    src = RE_STR.sub('""', src)
    src = RE_CHAR.sub("''", src)
    return src


RE_LOOP_KW = re.compile(r'\b(for|while|do)\b')
RE_IF_KW   = re.compile(r'\bif\b')

def analisar_estrutura_loops(src_limpo: str) -> dict:
    """Varre o código caractere a caractere para detectar: - max_loop_depth: máxima profundidade de laços aninhados"""
    tokens = []
    i = 0
    n = len(src_limpo)
    while i < n:
        c = src_limpo[i]
        if c in '{}();':
            tokens.append(c)
            i += 1
        elif c.isalpha() or c == '_':
            j = i
            while j < n and (src_limpo[j].isalnum() or src_limpo[j] == '_'):
                j += 1
            tokens.append(src_limpo[i:j])
            i = j
        else:
            i += 1

    brace_depth = 0
    loop_brace_stack = []
    loop_depth = 0
    max_loop_depth = 0
    nested_loop_count = 0
    loop_count = 0
    if_count = 0

    pending_loop = False

    idx = 0
    total_tokens = len(tokens)
    while idx < total_tokens:
        tok = tokens[idx]

        if tok in ('for', 'while', 'do'):
            loop_count += 1
            if loop_depth > 0:
                nested_loop_count += 1
            loop_depth += 1
            max_loop_depth = max(max_loop_depth, loop_depth)
            pending_loop = True

        elif tok == 'if':
            if_count += 1

        elif tok == '{':
            brace_depth += 1
            if pending_loop:
                loop_brace_stack.append(brace_depth)
                pending_loop = False

        elif tok == '}':
            if loop_brace_stack and loop_brace_stack[-1] == brace_depth:
                loop_brace_stack.pop()
                loop_depth -= 1
            brace_depth -= 1

        elif tok == ';':
            pass

        idx += 1

    return {
        'max_loop_depth':    max_loop_depth,
        'nested_loop_count': nested_loop_count,
        'loop_count':        loop_count,
        'if_count':          if_count,
    }


def contar_linhas(src_limpo: str) -> int:
    return sum(1 for ln in src_limpo.splitlines() if ln.strip())


RE_FUNC_DEF = re.compile(
    r'\b[a-zA-Z_]\w*\s+\**\s*([a-zA-Z_]\w*)\s*\([^;]*\)\s*\{',
    re.MULTILINE
)

def contar_funcoes(src_limpo: str) -> int:
    nomes = set(RE_FUNC_DEF.findall(src_limpo))
    reservadas = {'if', 'for', 'while', 'switch', 'do', 'return'}
    return len(nomes - reservadas)


def analisar_recursao(src_limpo: str) -> dict:
    """Retorna: has_recursion    — 0 ou 1 recursive_calls  — total de chamadas recursivas double_recursion — número de funções com 2+ chamadas recursivas"""
    defs = re.findall(
        r'\b([a-zA-Z_]\w*)\s*\([^)]*\)\s*\{',
        src_limpo
    )
    reservadas = {'if', 'for', 'while', 'switch', 'do', 'return',
                  'main', 'printf', 'scanf', 'malloc', 'free',
                  'calloc', 'realloc', 'sizeof'}

    total_rec = 0
    double_rec = 0

    for nome in set(defs):
        if nome in reservadas:
            continue
        ocorrencias = re.findall(rf'\b{re.escape(nome)}\s*\(', src_limpo)
        chamadas = max(0, len(ocorrencias) - 1)
        if chamadas > 0:
            total_rec += chamadas
            if chamadas >= 2:
                double_rec += 1

    return {
        'has_recursion':   1 if total_rec > 0 else 0,
        'recursive_calls': total_rec,
        'double_recursion': double_rec,
    }


def contar_simples(src_limpo: str) -> dict:
    return {
        'malloc_count': len(re.findall(r'\b(malloc|calloc|realloc)\b', src_limpo)),
        'ptr_ops':      len(re.findall(r'->|(?<![a-zA-Z0-9_])\*(?=[a-zA-Z_(])', src_limpo)),
        'idx_array':    len(re.findall(r'\[', src_limpo)),
        'op_incr':      len(re.findall(r'\+\+|--', src_limpo)),
    }


def extrair_features(caminho: str) -> dict:
    with open(caminho, 'r', encoding='utf-8', errors='replace') as f:
        src = f.read()

    src_l = limpar(src)

    total_lines = contar_linhas(src_l)
    num_functions = contar_funcoes(src_l)
    loop_info = analisar_estrutura_loops(src_l)
    rec_info = analisar_recursao(src_l)
    simples = contar_simples(src_l)

    loop_count = loop_info['loop_count']
    if_count   = loop_info['if_count']
    tl = max(1, total_lines)

    feats = {
        'total_lines':        total_lines,
        'num_functions':      num_functions,
        'loop_count':         loop_count,
        'if_count':           if_count,
        'max_loop_depth':     loop_info['max_loop_depth'],
        'nested_loop_count':  loop_info['nested_loop_count'],
        'has_recursion':      rec_info['has_recursion'],
        'recursive_calls':    rec_info['recursive_calls'],
        'double_recursion':   rec_info['double_recursion'],
        'branch_ratio':       round(if_count / tl, 4),
        'loop_ratio':         round(loop_count / tl, 4),
        **simples,
    }
    return feats


RE_NOESCAPE = re.compile(r'[\\/*?:"<>|]')
RE_SPACES   = re.compile(r'\s+')
RE_UNDERS   = re.compile(r'_+')

def normalizar_complexidade(expr: str) -> str:
    if not expr:
        return ""
    s = re.sub(r'\s+', '', expr.strip().lower())
    if re.fullmatch(r'o\(1\)', s):                                   return "O(1)"
    if re.fullmatch(r'o\(h\)', s):                                   return "O(log n)"
    if re.search(r'log', s) and not re.search(r'n.*log.*n|nlog', s): return "O(log n)"
    if re.fullmatch(r'o\(n\)', s):                                   return "O(n)"
    if re.search(r'nlog|n\*log|nlogn|n\*logn|nlog\(', s):           return "O(n log n)"
    if re.search(r'log.*n.*n|n.*log', s) and not re.search(r'n2|n\^2|n\*n', s): return "O(n log n)"
    if re.fullmatch(r'o\(n2\)', s) or re.fullmatch(r'o\(n\^2\)', s): return "O(n^2)"
    if re.search(r'n2\)', s) or re.search(r'n\^2', s) or re.search(r'n\*n', s): return "O(n^2)"
    if re.search(r'n3\)', s) or re.search(r'n\^3', s):              return "O(n^3)"
    if re.search(r'2n\)|2\^n|exponential', s):                      return "O(2^n)"
    if re.search(r'[mn]\*[nm]|[mn]x[nm]', s):                       return "O(n*m)"
    if re.search(r'n1/2|sqrt', s):                                   return "O(sqrt(n))"
    return ""


def carregar_metadados() -> dict:
    with open(JSON_SRC, 'r', encoding='utf-8') as f:
        dados = json.load(f)
    mapa = {}
    contadores: dict = {}
    for e in dados:
        if not e.get('codes', {}).get('C', {}).get('code', '').strip():
            continue
        nome_raw = e.get('name', 'sem_nome').strip()
        nb = RE_NOESCAPE.sub('', nome_raw)
        nb = RE_SPACES.sub('_', nb)
        nb = RE_UNDERS.sub('_', nb).strip('_')[:100] or 'sem_nome'
        contadores[nb] = contadores.get(nb, 0) + 1
        cnt = contadores[nb]
        chave = nb if cnt == 1 else f'{nb}_{cnt}'
        mapa[chave + '.c'] = {
            'time_complexity':  e.get('time_complexity', ''),
            'space_complexity': e.get('space_complexity', ''),
        }
    return mapa


def main():
    arquivos = sorted(f for f in os.listdir(C_DIR) if f.endswith('.c'))
    print(f"Extraindo features estruturais de {len(arquivos)} arquivos C...")

    meta = carregar_metadados()
    resultados = []

    for nome in arquivos:
        feats = extrair_features(os.path.join(C_DIR, nome))
        info  = meta.get(nome, {})
        feats['arquivo']          = nome
        feats['time_complexity']  = normalizar_complexidade(info.get('time_complexity', ''))
        feats['space_complexity'] = normalizar_complexidade(info.get('space_complexity', ''))
        resultados.append(feats)

    colunas = [
        'arquivo',
        'total_lines', 'num_functions',
        'loop_count', 'if_count',
        'max_loop_depth', 'nested_loop_count',
        'has_recursion', 'recursive_calls', 'double_recursion',
        'branch_ratio', 'loop_ratio',
        'malloc_count', 'ptr_ops', 'idx_array', 'op_incr',
        'time_complexity', 'space_complexity',
    ]

    with open(OUT_CSV, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=colunas)
        writer.writeheader()
        writer.writerows(resultados)

    print(f"CSV salvo em: {OUT_CSV}")
    print(f"Features: {', '.join(colunas[1:-2])}")

    # Resumo estatístico das features mais importantes
    import statistics
    print("\nEstatísticas das features de loop (primeiras 5 linhas):")
    print(f"{'Arquivo':<55} {'max_depth':>9} {'nested':>7} {'loops':>6} {'rec':>4} {'d_rec':>5}")
    print("-" * 90)
    for r in resultados[:10]:
        print(f"{r['arquivo']:<55} {r['max_loop_depth']:>9} {r['nested_loop_count']:>7} "
              f"{r['loop_count']:>6} {r['has_recursion']:>4} {r['double_recursion']:>5}")


if __name__ == '__main__':
    main()
