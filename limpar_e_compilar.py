"""Corrige os artefatos de scraping dos .c e compila para assembly com o GCC."""

import os
import re
import subprocess
import shutil

SRC_DIR      = "dados/codigos_c"
CLEAN_DIR    = "dados/codigos_c_limpos"
ASM_DIR      = "dados/codigos_asm"
LOG_FALHAS   = "dados/compilacao_falhas.txt"

# Palavras-chave C que o scraper colou com o token seguinte
C_KEYWORDS = [
    "unsigned", "register", "volatile", "typedef", "default",
    "continue", "restrict", "double", "extern", "return", "static",
    "struct", "switch", "float", "break", "const", "short", "union",
    "while", "case", "char", "else", "enum", "goto", "long", "void",
    "auto", "for", "int", "do", "if",
]

# Ordena do mais longo para o mais curto para evitar substituições parciais
C_KEYWORDS.sort(key=len, reverse=True)
KEYWORD_PATTERN = re.compile(
    r'\b(' + '|'.join(re.escape(k) for k in C_KEYWORDS) + r')([A-Za-z_0-9])'
)

def limpar_codigo(texto: str) -> str:
    # 1. Substitui \u00a0 (non-breaking space) por espaço normal
    texto = texto.replace('\u00a0', ' ')

    while True:
        novo = KEYWORD_PATTERN.sub(r'\1 \2', texto)
        if novo == texto:
            break
        texto = novo

    # 3. Insere espaço entre keyword e número literal colado (ex: "return0")
    texto = re.sub(
        r'\b(' + '|'.join(re.escape(k) for k in C_KEYWORDS) + r')([0-9])',
        r'\1 \2',
        texto
    )

    return texto


def compilar_para_asm(src: str, dst: str) -> tuple[bool, str]:
    """Compila src.c -> dst.s via GCC. Retorna (sucesso, mensagem_erro)."""
    resultado = subprocess.run(
        ["gcc", "-S", "-O1", "-w", "-x", "c", src, "-o", dst],
        capture_output=True, text=True
    )
    if resultado.returncode != 0:
        return False, resultado.stderr.strip()
    return True, ""


def main():
    os.makedirs(CLEAN_DIR, exist_ok=True)
    os.makedirs(ASM_DIR,   exist_ok=True)

    arquivos = sorted(f for f in os.listdir(SRC_DIR) if f.endswith(".c"))

    ok = 0
    falhou = 0
    falhas = []

    print(f"Processando {len(arquivos)} arquivos...\n")

    for nome in arquivos:
        caminho_src  = os.path.join(SRC_DIR,   nome)
        caminho_limpo = os.path.join(CLEAN_DIR, nome)
        nome_asm     = nome.replace(".c", ".s")
        caminho_asm  = os.path.join(ASM_DIR,   nome_asm)

        # --- limpeza ---
        with open(caminho_src, "r", encoding="utf-8", errors="replace") as f:
            conteudo = f.read()
        conteudo_limpo = limpar_codigo(conteudo)
        with open(caminho_limpo, "w", encoding="utf-8") as f:
            f.write(conteudo_limpo)

        # --- compilação ---
        sucesso, erro = compilar_para_asm(caminho_limpo, caminho_asm)
        if sucesso:
            ok += 1
        else:
            falhou += 1
            falhas.append((nome, erro))
            if os.path.exists(caminho_asm):
                os.remove(caminho_asm)

    # Relatório
    with open(LOG_FALHAS, "w", encoding="utf-8") as f:
        for nome, erro in falhas:
            f.write(f"=== {nome} ===\n{erro}\n\n")

    print("=" * 50)
    print(f"Compilados com sucesso : {ok}")
    print(f"Falhas de compilacao   : {falhou}")
    print(f"Assemblies em          : {os.path.abspath(ASM_DIR)}/")
    print(f"Log de falhas          : {LOG_FALHAS}")

if __name__ == "__main__":
    main()
