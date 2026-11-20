"""Conta as instruções dos arquivos .s e gera o ranking global e o CSV das 15 mais frequentes."""

import os
import re
import csv
import json
from collections import Counter, defaultdict

ASM_DIR    = "dados/codigos_asm"
JSON_SRC   = "dados/geeks_for_geeks.json"
OUT_RANK   = "dados/instrucoes_top15_global.txt"
OUT_CSV    = "dados/instrucoes_por_arquivo.csv"

# Diretivas e pseudo-instruções que devemos ignorar
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
    """Converte para minúsculas e, se o mnemônico for uma instrução conhecida com sufixo de tamanho AT&T, remove o sufixo."""
    mnem = mnem.lower()
    m = SUFIXO_TAMANHO.match(mnem)
    if m:
        base = m.group(1)
        if base in BASE_COM_SUFIXO:
            return base
    return mnem


def extrair_instrucoes(caminho_asm: str) -> list[str]:
    """Lê um arquivo .s e retorna a lista de mnemônicos (sem diretivas/labels)."""
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


def normalizar_complexidade(expr: str) -> str:
    """Mapeia as variações de escrita do dataset para uma classe canônica."""
    if not expr:
        return ""
    s = expr.strip().lower()
    s = re.sub(r'\s+', '', s)

    # O(1)
    if re.fullmatch(r'o\(1\)', s):
        return "O(1)"

    # O(log n)
    if re.fullmatch(r'o\(h\)', s):
        return "O(log n)"
    if re.search(r'log', s) and not re.search(r'n.*log.*n|nlog', s):
        return "O(log n)"

    # O(n)
    if re.fullmatch(r'o\(n\)', s):
        return "O(n)"

    # O(n log n)
    if re.search(r'nlog|n\*log|nlogn|n\*logn|nlog\(', s):
        return "O(n log n)"
    if re.search(r'log.*n.*n|n.*log', s) and not re.search(r'n2|n\^2|n\*n', s):
        return "O(n log n)"

    # O(n²)
    if re.fullmatch(r'o\(n2\)', s) or re.fullmatch(r'o\(n\^2\)', s):
        return "O(n^2)"
    if re.search(r'n2\)', s) or re.search(r'n\^2', s) or re.search(r'n\*n', s):
        return "O(n^2)"

    # O(n³)
    if re.search(r'n3\)', s) or re.search(r'n\^3', s):
        return "O(n^3)"

    # O(2^n)  — exponencial
    if re.search(r'2n\)|2\^n|exponential', s):
        return "O(2^n)"

    # O(n * m)  ou  O(m * n)
    if re.search(r'[mn]\*[nm]|[mn]x[nm]|\[mn\]\*|\[nm\]\*', s):
        return "O(n*m)"

    # O(√n)
    if re.search(r'n1/2|sqrt', s):
        return "O(sqrt(n))"

    return ""


def carregar_metadados_json() -> dict[str, dict]:
    """Constrói um mapa nome_arquivo -> {time_complexity, space_complexity} usando o nome do problema do JSON original."""
    with open(JSON_SRC, "r", encoding="utf-8") as f:
        dados = json.load(f)

    mapa = {}
    contadores: dict[str, int] = {}

    for entrada in dados:
        if not entrada.get("codes", {}).get("C", {}).get("code", "").strip():
            continue

        nome_raw = entrada.get("name", "sem_nome").strip()
        nome_base = re.sub(r'[\\/*?:"<>|]', '', nome_raw)
        nome_base = re.sub(r'\s+', '_', nome_base)
        nome_base = re.sub(r'_+', '_', nome_base).strip('_')[:100]
        if not nome_base:
            nome_base = "sem_nome"

        contadores[nome_base] = contadores.get(nome_base, 0) + 1
        cnt = contadores[nome_base]
        chave = nome_base if cnt == 1 else f"{nome_base}_{cnt}"

        mapa[chave + ".s"] = {
            "time_complexity":  entrada.get("time_complexity", ""),
            "space_complexity": entrada.get("space_complexity", ""),
            "url":              entrada.get("url", ""),
        }
    return mapa


def main():
    arquivos_asm = sorted(
        f for f in os.listdir(ASM_DIR) if f.endswith(".s")
    )
    if not arquivos_asm:
        print("Nenhum arquivo .s encontrado em", ASM_DIR)
        return

    print(f"Analisando {len(arquivos_asm)} arquivos assembly...\n")

    contagem_global: Counter = Counter()
    contagem_por_arquivo: dict[str, Counter] = {}

    for nome in arquivos_asm:
        caminho = os.path.join(ASM_DIR, nome)
        instrucoes = extrair_instrucoes(caminho)
        contador = Counter(instrucoes)
        contagem_por_arquivo[nome] = contador
        contagem_global.update(contador)

    top15 = [instr for instr, _ in contagem_global.most_common(15)]

    print("Top 15 instruções mais frequentes (global):")
    print("-" * 40)
    for rank, (instr, total) in enumerate(contagem_global.most_common(15), 1):
        print(f"  {rank:>2}. {instr:<12}  {total:>8} ocorrências")
    print()

    with open(OUT_RANK, "w", encoding="utf-8") as f:
        f.write("Rank | Instrução    | Total ocorrências\n")
        f.write("-" * 40 + "\n")
        for rank, (instr, total) in enumerate(contagem_global.most_common(15), 1):
            f.write(f"  {rank:>2} | {instr:<12} | {total}\n")
    print(f"Ranking salvo em: {OUT_RANK}")

    meta = carregar_metadados_json()

    # Colunas: arquivo | <instrução_1> | ... | <instrução_15> | time_complexity | space_complexity
    cabecalho = ["arquivo"] + top15 + ["time_complexity", "space_complexity"]

    with open(OUT_CSV, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(cabecalho)

        for nome in arquivos_asm:
            contador = contagem_por_arquivo[nome]
            info = meta.get(nome, {})
            linha = (
                [nome]
                + [contador.get(instr, 0) for instr in top15]
                + [
                    normalizar_complexidade(info.get("time_complexity",  "")),
                    normalizar_complexidade(info.get("space_complexity", "")),
                  ]
            )
            writer.writerow(linha)

    print(f"CSV salvo em    : {OUT_CSV}")
    print(f"\nColunas do CSV  : arquivo | {' | '.join(top15)} | time_complexity | space_complexity")


if __name__ == "__main__":
    main()
