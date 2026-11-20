import json
import os
import re

INPUT_JSON = "dados/geeks_for_geeks.json"
OUTPUT_DIR = "dados/codigos_c"

def sanitizar_nome(nome: str) -> str:
    nome = nome.strip()
    nome = re.sub(r'[\\/*?:"<>|]', '', nome)
    nome = re.sub(r'\s+', '_', nome)
    nome = re.sub(r'_+', '_', nome)
    nome = nome.strip('_')
    return nome[:100]

def extrair_codigos_c():
    with open(INPUT_JSON, "r", encoding="utf-8") as f:
        dados = json.load(f)

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    contadores_nome: dict[str, int] = {}
    extraidos = 0
    sem_c = 0

    for entrada in dados:
        codes = entrada.get("codes", {})
        c_info = codes.get("C")

        if not c_info or not c_info.get("code", "").strip():
            sem_c += 1
            continue

        nome_base = sanitizar_nome(entrada.get("name", "sem_nome"))
        if not nome_base:
            nome_base = "sem_nome"

        contadores_nome[nome_base] = contadores_nome.get(nome_base, 0) + 1
        contagem = contadores_nome[nome_base]

        if contagem == 1:
            nome_arquivo = f"{nome_base}.c"
        else:
            nome_arquivo = f"{nome_base}_{contagem}.c"

        caminho = os.path.join(OUTPUT_DIR, nome_arquivo)

        time_complexity = entrada.get("time_complexity", "N/A")
        space_complexity = entrada.get("space_complexity", "N/A")
        url = entrada.get("url", "N/A")
        codigo = c_info["code"]

        cabecalho = (
            f"/* Problema: {entrada.get('name', '').strip()}\n"
            f" * Complexidade de Tempo: {time_complexity}\n"
            f" * Complexidade de Espaco: {space_complexity}\n"
            f" * Fonte: {url}\n"
            f" */\n\n"
        )

        with open(caminho, "w", encoding="utf-8") as f_out:
            f_out.write(cabecalho + codigo)

        extraidos += 1

    print(f"\nConcluido!")
    print(f"  Codigos C extraidos : {extraidos}")
    print(f"  Entradas sem codigo C: {sem_c}")
    print(f"  Arquivos salvos em  : {os.path.abspath(OUTPUT_DIR)}/")

if __name__ == "__main__":
    extrair_codigos_c()
