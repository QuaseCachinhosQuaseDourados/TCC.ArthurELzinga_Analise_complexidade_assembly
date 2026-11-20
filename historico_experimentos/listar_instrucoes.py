import sys, os, re
from collections import Counter
sys.stdout.reconfigure(encoding='utf-8')

ASM_DIR = 'codigos_asm'
IGNORAR = {'.', '#', ';'}
SUFIXO = re.compile(r'^(.+?)[bwlq]$')
BASE = {
    'mov','add','sub','and','or','xor','not','neg','cmp','test',
    'imul','idiv','div','mul','push','pop','lea','inc','dec',
    'sar','shr','shl','sal','ror','rol','movs','movz','set',
}

def normalizar(m):
    m = m.lower()
    r = SUFIXO.match(m)
    if r and r.group(1) in BASE:
        return r.group(1)
    return m

freq_arqs   = Counter()
freq_global = Counter()

arquivos = [f for f in os.listdir(ASM_DIR) if f.endswith('.s')]
for nome in arquivos:
    vistas = set()
    with open(os.path.join(ASM_DIR, nome), encoding='utf-8', errors='replace') as f:
        for linha in f:
            s = linha.strip()
            if not s or s[0] in IGNORAR or s.endswith(':'):
                continue
            p = s.split()
            if p:
                mn = normalizar(p[0])
                if not mn.startswith('.') and not mn.startswith('#'):
                    vistas.add(mn)
                    freq_global[mn] += 1
    freq_arqs.update(vistas)

total_arq = len(arquivos)
print(f"Total de arquivos .s analisados : {total_arq}")
print(f"Total de instrucoes unicas      : {len(freq_arqs)}")
print()
print(f"{'Instrucao':<18} {'Arqs':>5}  {'%Arqs':>6}  {'Total ocorr':>11}")
print("-" * 50)
for instr, n_arqs in freq_arqs.most_common():
    pct = n_arqs / total_arq * 100
    total = freq_global[instr]
    print(f"{instr:<18} {n_arqs:>5}  {pct:>5.1f}%  {total:>11}")
