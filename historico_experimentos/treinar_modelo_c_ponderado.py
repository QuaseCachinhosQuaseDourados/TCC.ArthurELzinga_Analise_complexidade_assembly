"""C: estratégia de pesos por classe do v12."""
import sys
import warnings
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import StratifiedKFold, cross_validate
from sklearn.metrics import balanced_accuracy_score

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV     = "features_c_estrutural.csv"
TARGET  = "time_complexity"
N_FOLDS = 5
SEED    = 42

MAPA_CLASSES = {
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

IMPORTANCIAS_C_V2 = {
    'loop_ratio'         : 0.148310,
    'idx_array'          : 0.147153,
    'ptr_ops'            : 0.077115,
    'recursive_calls'    : 0.038747,
    'max_loop_depth'     : 0.038441,
    'if_count'           : 0.024795,
    'op_incr'            : 0.024669,
    'malloc_count'       : 0.019932,
    'num_functions'      : 0.016998,
    'double_recursion'   : 0.013684,
    'has_recursion'      : 0.008421,
    'loop_count'         : 0.001949,
    # abaixo: importância negativa (ruído) → zeradas
    'nested_loop_count'  : 0.0,
    'total_lines'        : 0.0,
    'branch_ratio'       : 0.0,
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
df['classe'] = df[TARGET].map(MAPA_CLASSES)
df = df[df['classe'].notna()]

contagem = df['classe'].value_counts()
validas  = contagem[contagem >= 3].index
df = df[df['classe'].isin(validas)]

y = df['classe'].values
X_base = df[FEAT_BASE].values

print(f"Amostras: {len(df)}")
print(f"\nDistribuição das classes:\n{df['classe'].value_counts().to_string()}\n")

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

MODELOS_MULTI = {'Random Forest': rf, 'SVM (RBF)': svm,
                 'Gradient Boosting': gb, 'Logistic Regression': lr}

def cv_scores(clf_fn, X, y, label=""):
    skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)
    cv  = cross_validate(clf_fn(), X, y, cv=skf,
                         scoring='balanced_accuracy', n_jobs=-1)
    s   = cv['test_score']
    print(f"  {label:<30}: {s.mean():.3f} ± {s.std():.3f}  "
          f"(folds: {[f'{v:.3f}' for v in s]})")
    return s.mean(), s.std()

print("=" * 65)
print("BASELINE — 15 features estruturais C, sem ponderação")
print("=" * 65)
base_scores = {}
for nome, fn in MODELOS_MULTI.items():
    m, s = cv_scores(fn, X_base, y, nome)
    base_scores[nome] = m
melhor_base = max(base_scores, key=base_scores.get)
print(f"\n  ► Melhor baseline: {melhor_base} ({base_scores[melhor_base]:.3f})")

print("\n" + "=" * 65)
print("ESTRATÉGIA C-fonte — Pesos de features pela importância AutoGluon v2-C")
print("  Features com importância <= 0 → zeradas (removidas)")
print("=" * 65)

pesos = np.array([IMPORTANCIAS_C_V2.get(f, 0.0) for f in FEAT_BASE])
pesos = np.clip(pesos, 0, None)
pesos_norm = pesos / pesos.sum() if pesos.sum() > 0 else pesos
X_ponderado = X_base * pesos_norm

print(f"\n  Pesos aplicados:")
for f, p in zip(FEAT_BASE, pesos_norm):
    bar = '█' * int(p * 200)
    print(f"  {f:<20}: {p:.4f}  {bar}")

print(f"\n  Features ponderadas:\n")
c_scores = {}
for nome, fn in MODELOS_MULTI.items():
    m, s = cv_scores(fn, X_ponderado, y, nome)
    c_scores[nome] = m
melhor_c = max(c_scores, key=c_scores.get)
delta_c  = c_scores[melhor_c] - base_scores[melhor_base]
print(f"\n  ► Melhor ponderado: {melhor_c} ({c_scores[melhor_c]:.3f})  "
      f"Δ vs baseline: {delta_c:+.3f}")

print(f"\n  --- Ponderação + StandardScaler (escalonamento após peso) ---\n")
from sklearn.preprocessing import StandardScaler as SS
X_pond_scaled = SS().fit_transform(X_ponderado)
c2_scores = {}
for nome, fn in MODELOS_MULTI.items():
    m, s = cv_scores(fn, X_pond_scaled, y, f"[scaled] {nome}")
    c2_scores[nome] = m
melhor_c2 = max(c2_scores, key=c2_scores.get)
delta_c2  = c2_scores[melhor_c2] - base_scores[melhor_base]
print(f"\n  ► Melhor ponderado (scaled): {melhor_c2} ({c2_scores[melhor_c2]:.3f})  "
      f"Δ vs baseline: {delta_c2:+.3f}")

print("\n" + "=" * 65)
print("COMPARATIVO FINAL")
print("=" * 65)
print(f"  Baseline (sklearn, sem peso)   : {base_scores[melhor_base]:.3f} ({melhor_base})")
print(f"  Ponderado (sklearn)            : {c_scores[melhor_c]:.3f} ({melhor_c})  Δ {delta_c:+.3f}")
print(f"  Ponderado + StandardScaler     : {c2_scores[melhor_c2]:.3f} ({melhor_c2})  Δ {delta_c2:+.3f}")
print(f"  ---")
print(f"  Assembly Estratégia C (v12)    : 0.542 (Logistic Regression)  Δ vs baseline: -0.010")
print(f"  AutoGluon C v2 (referência)    : 0.428 ± 0.038 (5-Fold)")
