"""Extrai as features estruturais dos arquivos .s e gera os CSVs de treino."""

import os
import re
import csv
import sys
from collections import Counter, defaultdict

sys.stdout.reconfigure(encoding='utf-8')

ASM_DIR      = "dados/codigos_asm"
CSV_ORIGINAL = "dados/instrucoes_por_arquivo.csv"
CSV_SAIDA    = "dados/features_asm_estrutural.csv"
CSV_SAIDA_V2 = "dados/features_asm_v2.csv"

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

TOP15 = [
    'mov', 'call', 'lea', 'add', 'push', 'pop', 'cmp',
    'sub', 'ret', 'jmp', 'je', 'test', 'movslq', 'jne', 'jle',
]

# Mnemônicos de salto (checados ANTES da normalização para evitar jl→j)
JUMP_RE = re.compile(r'^j[a-z]*$')


def normalizar(mnem: str) -> str:
    mnem = mnem.lower()
    m = SUFIXO_TAMANHO.match(mnem)
    if m and m.group(1) in BASE_COM_SUFIXO:
        return m.group(1)
    return mnem


def eh_jump(mnem_raw: str) -> bool:
    """Verifica se o mnemônico bruto é uma instrução de salto."""
    return bool(JUMP_RE.match(mnem_raw.lower()))


def extrair_features(caminho_asm: str) -> dict:
    """Extrai features de contagem + estruturais de um arquivo .s."""

    with open(caminho_asm, "r", encoding="utf-8", errors="replace") as f:
        linhas = f.readlines()

    contagem = Counter()
    instrucoes_total = 0

    labels_posicao = {}

    globl_names = set()
    current_func = None
    func_calls = defaultdict(list)
    func_count = 0

    jump_records = []

    max_stack_frame = 0

    imul_count = 0
    sar_count  = 0
    shr_count  = 0
    cmov_count = 0
    jg_jge_count = 0

    for i, linha in enumerate(linhas):
        stripped = linha.strip()
        if not stripped:
            continue

        if stripped.startswith('.globl'):
            parts = stripped.split()
            if len(parts) >= 2:
                globl_names.add(parts[1].strip())
            continue

        if stripped.endswith(':') and not stripped.startswith('.'):
            label = stripped[:-1].strip()
            labels_posicao[label] = i
            if label in globl_names:
                current_func = label
                func_count += 1
            continue

        if stripped.endswith(':') and stripped.startswith('.L'):
            label = stripped[:-1].strip()
            labels_posicao[label] = i
            continue

        if stripped[0] in IGNORAR_PREFIXOS:
            continue

        partes = stripped.split()
        if not partes:
            continue

        mnem_raw = partes[0]
        mnem = normalizar(mnem_raw)

        if mnem.startswith('.') or mnem.startswith('#'):
            continue

        instrucoes_total += 1
        contagem[mnem] += 1

        if mnem == 'sub' and '%rsp' in stripped:
            match = re.search(r'\$(\d+)', stripped)
            if match:
                frame = int(match.group(1))
                if frame > max_stack_frame:
                    max_stack_frame = frame

        # imul: multiplicação inteira (polinomial → nested index calc)
        if mnem == 'imul':
            imul_count += 1

        # sar/shr: shift direita aritmético/lógico (O(log n) halving)
        if mnem == 'sar':
            sar_count += 1
        if mnem == 'shr':
            shr_count += 1

        # cmov: movimentos condicionais sem branch (típico em árvores / O(log n))
        if mnem == 'cmov':
            cmov_count += 1

        # jg/jge: saltos "maior / maior-igual" (sorting: O(n log n))
        if mnem_raw.lower() in ('jg', 'jge', 'jnle', 'jnl'):
            jg_jge_count += 1

        if eh_jump(mnem_raw):
            for p in partes[1:]:
                target = p.strip().rstrip(',')
                if target.startswith('.L') or target in globl_names:
                    is_cond = (mnem_raw.lower() != 'jmp')
                    jump_records.append((i, target, is_cond))
                    break

        if mnem == 'call' and current_func:
            for p in partes[1:]:
                target = p.strip().rstrip(',')
                if not target.startswith('.') and not target.startswith('*'):
                    func_calls[current_func].append(target)
                    break


    # Saltos para trás (backward) e para frente (forward)
    backward_jumps = 0
    forward_jumps = 0
    conditional_backward = 0
    for line_no, target, is_cond in jump_records:
        if target in labels_posicao:
            if labels_posicao[target] < line_no:
                backward_jumps += 1
                if is_cond:
                    conditional_backward += 1
            else:
                forward_jumps += 1

    # Labels locais (basic blocks)
    num_labels = sum(1 for l in labels_posicao if l.startswith('.L'))

    # Recursão
    has_recursion = 0
    recursive_call_count = 0
    max_recursive_per_func = 0
    for func_name, calls in func_calls.items():
        rec = calls.count(func_name)
        if rec > 0:
            has_recursion = 1
            recursive_call_count += rec
            max_recursive_per_func = max(max_recursive_per_func, rec)

    # Alvos de call únicos (excluindo funções internas e __main)
    all_call_targets = set()
    for calls in func_calls.values():
        all_call_targets.update(calls)
    internal_funcs = globl_names | {'__main'}
    unique_call_targets = len(all_call_targets - internal_funcs)

    # Ratios
    total_jumps = len(jump_records)
    conditional_jumps = sum(1 for _, _, c in jump_records if c)
    jump_ratio = round(total_jumps / max(instrucoes_total, 1), 4)
    branch_ratio = round(conditional_jumps / max(instrucoes_total, 1), 4)

    backward_intervals = []
    for line_no, target, _ in jump_records:
        if target in labels_posicao and labels_posicao[target] < line_no:
            backward_intervals.append((labels_posicao[target], line_no))

    loop_nesting_depth = 0
    for i, (start_i, end_i) in enumerate(backward_intervals):
        depth = 1
        for j, (start_j, end_j) in enumerate(backward_intervals):
            if i != j and start_i <= start_j and end_j <= end_i:
                depth += 1
        loop_nesting_depth = max(loop_nesting_depth, depth)

    instr_per_label = round(instrucoes_total / max(num_labels, 1), 2)
    instr_per_func  = round(instrucoes_total / max(func_count, 1), 2)

    features = {}

    # A) 15 contagens originais
    for instr in TOP15:
        features[instr] = contagem.get(instr, 0)

    # B) Features estruturais
    features['total_instructions']      = instrucoes_total
    features['num_functions']           = func_count
    features['num_labels']              = num_labels
    features['backward_jumps']          = backward_jumps
    features['forward_jumps']           = forward_jumps
    features['conditional_backward']    = conditional_backward
    features['has_recursion']           = has_recursion
    features['recursive_call_count']    = recursive_call_count
    features['max_recursive_per_func']  = max_recursive_per_func
    features['unique_call_targets']     = unique_call_targets
    features['max_stack_frame']         = max_stack_frame
    features['jump_ratio']              = jump_ratio
    features['branch_ratio']            = branch_ratio

    # C) Novas features
    features['imul_count']          = imul_count
    features['sar_count']           = sar_count
    features['shr_count']           = shr_count
    features['cmov_count']          = cmov_count
    features['jg_jge_count']        = jg_jge_count
    features['loop_nesting_depth']  = loop_nesting_depth
    features['instr_per_label']     = instr_per_label
    features['instr_per_func']      = instr_per_func

    return features


def main():
    labels_map = {}
    with open(CSV_ORIGINAL, newline='', encoding='utf-8') as f:
        for row in csv.DictReader(f):
            labels_map[row['arquivo']] = {
                'time_complexity':  row.get('time_complexity', ''),
                'space_complexity': row.get('space_complexity', ''),
            }

    arquivos_asm = sorted(f for f in os.listdir(ASM_DIR) if f.endswith('.s'))
    print(f"Analisando {len(arquivos_asm)} arquivos assembly...\n")

    # Colunas do CSV de saída (original)
    colunas_feat = TOP15 + [
        'total_instructions', 'num_functions', 'num_labels',
        'backward_jumps', 'forward_jumps', 'conditional_backward',
        'has_recursion', 'recursive_call_count', 'max_recursive_per_func',
        'unique_call_targets', 'max_stack_frame', 'jump_ratio', 'branch_ratio',
    ]
    colunas_novas = [
        'imul_count', 'sar_count', 'shr_count', 'cmov_count',
        'jg_jge_count', 'loop_nesting_depth', 'instr_per_label', 'instr_per_func',
    ]
    colunas_v2  = colunas_feat + colunas_novas
    cabecalho   = ['arquivo'] + colunas_feat  + ['time_complexity', 'space_complexity']
    cabecalho_v2= ['arquivo'] + colunas_v2 + ['time_complexity', 'space_complexity']

    linhas_csv = []
    for nome in arquivos_asm:
        caminho = os.path.join(ASM_DIR, nome)
        features = extrair_features(caminho)

        info = labels_map.get(nome, {})
        linha = {'arquivo': nome}
        for col in colunas_v2:
            linha[col] = features.get(col, 0)
        linha['time_complexity']  = info.get('time_complexity', '')
        linha['space_complexity'] = info.get('space_complexity', '')
        linhas_csv.append(linha)

    with open(CSV_SAIDA, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=cabecalho, extrasaction='ignore')
        writer.writeheader()
        writer.writerows(linhas_csv)

    with open(CSV_SAIDA_V2, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=cabecalho_v2, extrasaction='ignore')
        writer.writeheader()
        writer.writerows(linhas_csv)

    print(f"CSV original salvo em : {CSV_SAIDA}  ({len(colunas_feat)} features)")
    print(f"CSV v2 salvo em       : {CSV_SAIDA_V2}  ({len(colunas_v2)} features)")
    print(f"Amostras: {len(linhas_csv)}")

    com_label = sum(1 for r in linhas_csv if r['time_complexity'])
    sem_label = len(linhas_csv) - com_label
    print(f"\nCom label de complexidade: {com_label}")
    print(f"Sem label:                 {sem_label}")

    # Distribuição de classes
    from collections import Counter as Cnt
    dist = Cnt(r['time_complexity'] for r in linhas_csv if r['time_complexity'])
    print("\nDistribuição das classes:")
    for cls, qtd in dist.most_common():
        print(f"  {cls:<15} {qtd:>4}")

    # Estatísticas das features estruturais
    print("\nEstatísticas das features estruturais:")
    for feat in colunas_feat[len(TOP15):]:
        vals = [r[feat] for r in linhas_csv]
        print(f"  {feat:<26}  min={min(vals):>6}  max={max(vals):>6}  "
              f"media={sum(vals)/len(vals):>7.1f}")


if __name__ == "__main__":
    main()
