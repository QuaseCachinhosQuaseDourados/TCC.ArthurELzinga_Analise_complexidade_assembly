"""Experimentos de revisão das features de C."""
import sys
import warnings
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import StratifiedKFold, cross_validate

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV     = "features_c_estrutural.csv"
TARGET  = "time_complexity"
N_FOLDS = 5
SEED    = 42

MAPA_6 = {
    "O(1)"      : "Constante",
    "O(log n)"  : "Logaritmica",
    "O(sqrt(n))": "Logaritmica",
    "O(n)"      : "Linear",
    "O(n log n)": "Superlinear",
    "O(n*m)"    : "Superlinear",
    "O(n^2)"    : "Polinomial",
    "O(n^3)"    : "Polinomial",
    "O(2^n)"    : "Exponencial",
}

MAPA_BIN = {
    "O(1)"      : "Eficiente",
    "O(log n)"  : "Eficiente",
    "O(sqrt(n))": "Eficiente",
    "O(n)"      : "Eficiente",
    "O(n log n)": "Eficiente",
    "O(n*m)"    : "Ineficiente",
    "O(n^2)"    : "Ineficiente",
    "O(n^3)"    : "Ineficiente",
    "O(2^n)"    : "Ineficiente",
}

FEAT_BASE = [
    'total_lines', 'num_functions',
    'loop_count', 'if_count',
    'max_loop_depth', 'nested_loop_count',
    'has_recursion', 'recursive_calls', 'double_recursion',
    'branch_ratio', 'loop_ratio',
    'malloc_count', 'ptr_ops', 'idx_array', 'op_incr',
]

df = pd.read_csv(CSV)
df = df[df[TARGET].notna() & (df[TARGET] != "")]
df['y6']   = df[TARGET].map(MAPA_6)
df['ybin'] = df[TARGET].map(MAPA_BIN)
df = df[df['y6'].notna() & df['ybin'].notna()]

def svm():
    return Pipeline([('sc', StandardScaler()),
                     ('svm', SVC(kernel='rbf', C=10, gamma='scale',
                                 class_weight='balanced', probability=True,
                                 random_state=SEED))])
def rf():
    return RandomForestClassifier(n_estimators=300, class_weight='balanced',
                                   max_depth=6, min_samples_leaf=2,
                                   random_state=SEED, n_jobs=-1)
def lr():
    return Pipeline([('sc', StandardScaler()),
                     ('lr', LogisticRegression(class_weight='balanced',
                                               max_iter=1000, C=1.0,
                                               random_state=SEED))])
def gb():
    return GradientBoostingClassifier(n_estimators=300, learning_rate=0.03,
                                      max_depth=3, min_samples_leaf=2,
                                      subsample=0.8, random_state=SEED)

MODELOS = {'Random Forest': rf, 'SVM (RBF)': svm,
           'Gradient Boosting': gb, 'Logistic Regression': lr}

def rodar(nome_cenario, sub_df, y_col, min_por_classe=3):
    sub_df = sub_df.copy()
    contagem = sub_df[y_col].value_counts()
    validas = contagem[contagem >= min_por_classe].index
    sub_df = sub_df[sub_df[y_col].isin(validas)]

    X = sub_df[FEAT_BASE].values
    y = sub_df[y_col].values
    n_classes = len(set(y))

    print(f"\n{'='*70}")
    print(f"  {nome_cenario}")
    print(f"{'='*70}")
    print(f"  Amostras: {len(sub_df)}  |  Classes ({n_classes}): {sorted(set(y))}")
    print(f"  Distribuição:\n{sub_df[y_col].value_counts().to_string()}")

    skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)
    resultados = {}
    for nome, fn in MODELOS.items():
        cv = cross_validate(fn(), X, y, cv=skf, scoring='balanced_accuracy', n_jobs=-1)
        s = cv['test_score']
        resultados[nome] = (s.mean(), s.std())
        print(f"    {nome:<22}: {s.mean():.3f} ± {s.std():.3f}  folds={[f'{v:.3f}' for v in s]}")

    melhor = max(resultados, key=lambda n: resultados[n][0])
    print(f"  ► Melhor: {melhor} = {resultados[melhor][0]:.3f} ± {resultados[melhor][1]:.3f}")
    return len(sub_df), n_classes, melhor, resultados[melhor][0], resultados[melhor][1]

resumo = []

# 1. Baseline (conferência do número já publicado: 52,6%)
r = rodar("1) BASELINE — 6 classes (réplica do relatório original)", df, 'y6')
resumo.append(("Baseline 6 classes", *r))

# 2. Binário Eficiente/Ineficiente (réplica do v11 assembly, aplicado a C)
r = rodar("2) BINÁRIO Eficiente/Ineficiente (réplica v11, domínio C)", df, 'ybin')
resumo.append(("Binário Efic/Inefic", *r))

# 3. Remove Constante e Linear (pedido do professor)
df_sem_cl = df[~df['y6'].isin(['Constante', 'Linear'])]
r = rodar("3) SEM Constante e Linear — 4 classes restantes", df_sem_cl, 'y6')
resumo.append(("Sem Constante+Linear", *r))

# 4. Remove apenas Constante (combinação adicional justificável)
df_sem_c = df[df['y6'] != 'Constante']
r = rodar("4) SEM Constante (mantém Linear) — 5 classes restantes", df_sem_c, 'y6')
resumo.append(("Sem Constante", *r))

# 5. Remove apenas Linear (combinação adicional justificável)
df_sem_l = df[df['y6'] != 'Linear']
r = rodar("5) SEM Linear (mantém Constante) — 5 classes restantes", df_sem_l, 'y6')
resumo.append(("Sem Linear", *r))

print(f"\n{'='*70}")
print("  RESUMO COMPARATIVO")
print(f"{'='*70}")
print(f"  {'Cenário':<24}{'N':>6}{'Classes':>9}{'Melhor modelo':>22}{'Bal.Acc.':>12}{'DP':>8}")
for nome, n, nc, melhor, media, dp in resumo:
    print(f"  {nome:<24}{n:>6}{nc:>9}{melhor:>22}{media:>12.3f}{dp:>8.3f}")
