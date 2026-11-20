"""C: testa juntar Linear com O(n log n) e O(n*m)."""
import sys
import warnings
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import StratifiedKFold, cross_validate, train_test_split
from sklearn.metrics import classification_report, confusion_matrix

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV     = "features_c_estrutural.csv"
TARGET  = "time_complexity"
N_FOLDS = 5
SEED    = 42

# Mapeamento original (6 classes, "Intermediaria" = O(n log n)+O(n*m))
MAPA_6 = {
    "O(1)"      : "Constante",
    "O(log n)"  : "Logaritmica",
    "O(sqrt(n))": "Logaritmica",
    "O(n)"      : "Linear",
    "O(n log n)": "Intermediaria",
    "O(n*m)"    : "Intermediaria",
    "O(n^2)"    : "Polinomial",
    "O(n^3)"    : "Polinomial",
    "O(2^n)"    : "Exponencial",
}

# Novo mapeamento: Linear + Intermediaria fundidas
MAPA_5_FUNDIDO = {
    "O(1)"      : "Constante",
    "O(log n)"  : "Logaritmica",
    "O(sqrt(n))": "Logaritmica",
    "O(n)"      : "Linear_ou_mais",
    "O(n log n)": "Linear_ou_mais",
    "O(n*m)"    : "Linear_ou_mais",
    "O(n^2)"    : "Polinomial",
    "O(n^3)"    : "Polinomial",
    "O(2^n)"    : "Exponencial",
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
df['y6'] = df[TARGET].map(MAPA_6)
df['y_fundido'] = df[TARGET].map(MAPA_5_FUNDIDO)
df = df[df['y6'].notna() & df['y_fundido'].notna()]

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

def rodar(nome_cenario, X, y):
    n_classes = len(set(y))
    print(f"\n{'='*70}")
    print(f"  {nome_cenario}")
    print(f"{'='*70}")
    print(f"  Amostras: {len(y)}  |  Classes ({n_classes}): {sorted(set(y))}")
    vc = pd.Series(y).value_counts()
    print(f"  Distribuição:\n{vc.to_string()}")

    skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)
    resultados = {}
    for nome, fn in MODELOS.items():
        cv = cross_validate(fn(), X, y, cv=skf, scoring='balanced_accuracy', n_jobs=-1)
        s = cv['test_score']
        resultados[nome] = (s.mean(), s.std())
        print(f"    {nome:<22}: {s.mean():.3f} ± {s.std():.3f}  folds={[f'{v:.3f}' for v in s]}")

    melhor = max(resultados, key=lambda n: resultados[n][0])
    print(f"  ► Melhor: {melhor} = {resultados[melhor][0]:.3f} ± {resultados[melhor][1]:.3f}")
    return len(y), n_classes, melhor, resultados[melhor][0], resultados[melhor][1]

X6 = df[FEAT_BASE].values
y6 = df['y6'].values
Xf = df[FEAT_BASE].values
yf = df['y_fundido'].values

r_baseline = rodar("BASELINE — 6 classes (Linear e Intermediária separadas)", X6, y6)
r_fundido  = rodar("FUNDIDO — Linear + Intermediária = 'Linear_ou_mais' (5 classes)", Xf, yf)

# Relatório detalhado do cenário fundido, para ver a matriz de confusão
print(f"\n{'='*70}")
print("  RELATÓRIO DETALHADO — cenário fundido (split 80/20, melhor modelo)")
print(f"{'='*70}")
melhor_nome = r_fundido[2]
X_tr, X_te, y_tr, y_te = train_test_split(Xf, yf, test_size=0.2, stratify=yf, random_state=SEED)
clf = MODELOS[melhor_nome]()
clf.fit(X_tr, y_tr)
y_pred = clf.predict(X_te)
print(classification_report(y_te, y_pred, zero_division=0))
labels_sorted = sorted(set(yf))
cm = confusion_matrix(y_te, y_pred, labels=labels_sorted)
print("Matriz de confusão:")
print(f"{'':>16}", end="")
for l in labels_sorted:
    print(f"{l[:14]:>16}", end="")
print()
for i, l in enumerate(labels_sorted):
    print(f"{l:>16}", end="")
    for j in range(len(labels_sorted)):
        print(f"{cm[i][j]:>16}", end="")
    print()

print(f"\n{'='*70}")
print("  RESUMO COMPARATIVO")
print(f"{'='*70}")
print(f"  {'Cenário':<45}{'N':>6}{'Classes':>9}{'Melhor modelo':>22}{'Bal.Acc.':>12}{'DP':>8}")
for nome, r in [("Baseline (6 classes)", r_baseline),
                ("Linear+Intermediária fundidas (5 classes)", r_fundido)]:
    n, nc, melhor, media, dp = r
    print(f"  {nome:<45}{n:>6}{nc:>9}{melhor:>22}{media:>12.3f}{dp:>8.3f}")
delta = r_fundido[3] - r_baseline[3]
print(f"\n  Δ vs. baseline: {delta:+.3f} ({delta*100:+.1f} pp)")

print(f"\n  --- Comparativo com testes anteriores (Seção 6, mesma metodologia) ---")
print(f"  Sem Constante+Linear (109, 4 classes)  : 0.602 (Logistic Regression)")
print(f"  Sem Linear apenas    (134, 5 classes)  : 0.604 (Logistic Regression)")
print(f"  Sem Constante apenas (204, 5 classes)  : 0.498 (SVM RBF)")
print(f"  Linear+Intermediária fundidas (229, 5 classes) : {r_fundido[3]:.3f} ({r_fundido[2]})")
