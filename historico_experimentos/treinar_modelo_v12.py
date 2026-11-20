"""v12: multiclasse a partir do classificador binário."""
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
from sklearn.base import clone
from sklearn.model_selection import (StratifiedKFold, cross_validate,
                                     cross_val_predict, train_test_split)
from sklearn.metrics import (classification_report, confusion_matrix,
                             balanced_accuracy_score)

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV     = "features_asm_estrutural.csv"
TARGET  = "time_complexity"
N_FOLDS = 5
SEED    = 42


# 6 classes consolidadas (baseline, igual v10 sem consolidar Const+Log)
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

# 7 classes: separa Superlinear em Linearitmica + Multipla
MAPA_7 = {
    "O(1)"      : "Constante",
    "O(log n)"  : "Logaritmica",
    "O(sqrt(n))": "Logaritmica",
    "O(n)"      : "Linear",
    "O(n log n)": "Linearitmica",
    "O(n*m)"    : "Multipla",
    "O(n^2)"    : "Polinomial",
    "O(n^3)"    : "Polinomial",
    "O(2^n)"    : "Exponencial",
}

# Binário baseado em Chivers e Sleightholme (2015)
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

IMPORTANCIAS_V7 = {
    'jne'                 : 0.0875,
    'add'                 : 0.0625,
    'num_labels'          : 0.0521,
    'has_recursion'       : 0.0500,
    'lea'                 : 0.0271,
    'cmp'                 : 0.0229,
    'backward_jumps'      : 0.0222,
    'movslq'              : 0.0160,
    'conditional_backward': 0.0132,
    # abaixo do limiar ou negativas → peso 0 (removidas)
    'recursion_depth'     : 0.0,
}

df = pd.read_csv(CSV)
df = df[df[TARGET].notna() & (df[TARGET] != "")]
df['recursion_depth'] = df['has_recursion'] * df['backward_jumps']

df['y6']  = df[TARGET].map(MAPA_6)
df['y7']  = df[TARGET].map(MAPA_7)
df['ybin'] = df[TARGET].map(MAPA_BIN)

df = df[df['y6'].notna() & df['y7'].notna() & df['ybin'].notna()]

# Remove classes com < 3 amostras
for col in ['y6', 'y7']:
    contagem = df[col].value_counts()
    validas  = contagem[contagem >= 3].index
    df = df[df[col].isin(validas)]

y6   = df['y6'].values
y7   = df['y7'].values
ybin = df['ybin'].values

print(f"Amostras totais: {len(df)}")
print(f"\nDistribuição 6 classes:\n{df['y6'].value_counts().to_string()}")
print(f"\nDistribuição 7 classes:\n{df['y7'].value_counts().to_string()}")
print(f"\nDistribuição binária:\n{df['ybin'].value_counts().to_string()}\n")

FEAT_BASE = ['jne', 'add', 'num_labels', 'has_recursion',
             'lea', 'cmp', 'backward_jumps', 'movslq',
             'conditional_backward', 'recursion_depth']

X_base = df[FEAT_BASE].values

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
print("BASELINE — 6 classes, 10 features (referência v10 sem consolidar)")
print("=" * 65)
base_scores = {}
for nome, fn in MODELOS_MULTI.items():
    m, s = cv_scores(fn, X_base, y6, nome)
    base_scores[nome] = m

melhor_base = max(base_scores, key=base_scores.get)
print(f"\n  ► Melhor baseline: {melhor_base} ({base_scores[melhor_base]:.3f})")

print("\n" + "=" * 65)
print("ESTRATÉGIA A — Probabilidade binária como feature extra")
print("  P(Ineficiente) adicionada via cross_val_predict (sem leakage)")
print("=" * 65)

skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)

# Gera probabilidades out-of-fold para não vazar informação
clf_bin_oof = lr()
prob_oof = cross_val_predict(clf_bin_oof, X_base, ybin, cv=skf,
                              method='predict_proba', n_jobs=-1)
# Índice da classe Ineficiente
clf_bin_oof.fit(X_base, ybin)
idx_inef = list(clf_bin_oof.classes_).index('Ineficiente') \
           if hasattr(clf_bin_oof, 'classes_') \
           else list(clf_bin_oof[-1].classes_).index('Ineficiente')
p_inef_oof = prob_oof[:, idx_inef].reshape(-1, 1)

X_plus = np.hstack([X_base, p_inef_oof])

print(f"\n  Features: {len(FEAT_BASE)+1} (10 originais + P(Ineficiente))\n")
a_scores = {}
for nome, fn in MODELOS_MULTI.items():
    m, s = cv_scores(fn, X_plus, y6, nome)
    a_scores[nome] = m

melhor_a = max(a_scores, key=a_scores.get)
delta_a  = a_scores[melhor_a] - base_scores[melhor_base]
print(f"\n  ► Melhor A: {melhor_a} ({a_scores[melhor_a]:.3f})  "
      f"Δ vs baseline: {delta_a:+.3f}")

print("\n" + "=" * 65)
print("ESTRATÉGIA B — Cascata binária → especialistas (7 classes)")
print("  Stage 1: Eficiente/Ineficiente")
print("  Stage 2a (Eficiente):   Constante | Logaritmica | Linear | Linearitmica")
print("  Stage 2b (Ineficiente): Multipla  | Polinomial  | Exponencial")
print("=" * 65)

for clf_nome, clf_fn in [('Random Forest', rf), ('SVM (RBF)', svm),
                          ('Logistic Regression', lr)]:
    scores_casc = []
    skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)

    for tr_idx, te_idx in skf.split(X_base, y7):
        X_tr, X_te = X_base[tr_idx], X_base[te_idx]
        yb_tr      = ybin[tr_idx]
        y7_tr      = y7[tr_idx]
        y7_te      = y7[te_idx]

        # Stage 1: binário
        clf1 = clone(clf_fn())
        clf1.fit(X_tr, yb_tr)

        # Stage 2: especialistas
        mask_ef = yb_tr == 'Eficiente'
        mask_in = yb_tr == 'Ineficiente'

        clf2_ef = clone(clf_fn())
        clf2_in = clone(clf_fn())

        # Treina só se houver ≥ 2 classes no subconjunto
        classes_ef = np.unique(y7_tr[mask_ef])
        classes_in = np.unique(y7_tr[mask_in])

        if len(classes_ef) >= 2:
            clf2_ef.fit(X_tr[mask_ef], y7_tr[mask_ef])
        if len(classes_in) >= 2:
            clf2_in.fit(X_tr[mask_in], y7_tr[mask_in])

        # Predição em cascata
        pred_bin  = clf1.predict(X_te)
        pred_fine = np.empty(len(X_te), dtype=object)

        for i in range(len(X_te)):
            xi = X_te[i:i+1]
            if pred_bin[i] == 'Eficiente' and len(classes_ef) >= 2:
                pred_fine[i] = clf2_ef.predict(xi)[0]
            elif pred_bin[i] == 'Ineficiente' and len(classes_in) >= 2:
                pred_fine[i] = clf2_in.predict(xi)[0]
            else:
                # fallback: usa a predição binária para decidir a classe mais provável
                pred_fine[i] = y7_tr[mask_ef if pred_bin[i] == 'Eficiente'
                                     else mask_in][0]

        scores_casc.append(balanced_accuracy_score(y7_te, pred_fine))

    sc = np.array(scores_casc)
    print(f"  {clf_nome:<26}: {sc.mean():.3f} ± {sc.std():.3f}  "
          f"(folds: {[f'{v:.3f}' for v in sc]})")

# Baseline direto nas 7 classes
print(f"\n  --- Comparativo direto (sem cascata, 7 classes) ---")
b7_scores = {}
for nome, fn in MODELOS_MULTI.items():
    m, s = cv_scores(fn, X_base, y7, nome)
    b7_scores[nome] = m
melhor_b7 = max(b7_scores, key=b7_scores.get)
print(f"\n  ► Melhor direto 7 classes: {melhor_b7} ({b7_scores[melhor_b7]:.3f})")

print("\n" + "=" * 65)
print("ESTRATÉGIA C — Pesos de features pela importância AutoGluon v7")
print("  Features com importância < 0 → zeradas (removidas)")
print("=" * 65)

# Cria matriz ponderada
pesos = np.array([IMPORTANCIAS_V7.get(f, 0.0) for f in FEAT_BASE])
# Normaliza para que a soma seja 1 (como probabilidade)
pesos_norm = pesos / pesos.sum() if pesos.sum() > 0 else pesos
X_ponderado = X_base * pesos_norm

print(f"\n  Pesos aplicados:")
for f, p in zip(FEAT_BASE, pesos_norm):
    bar = '█' * int(p * 200)
    print(f"  {f:<25}: {p:.4f}  {bar}")

print(f"\n  6 classes, features ponderadas:\n")
c_scores = {}
for nome, fn in MODELOS_MULTI.items():
    m, s = cv_scores(fn, X_ponderado, y6, nome)
    c_scores[nome] = m

melhor_c  = max(c_scores, key=c_scores.get)
delta_c   = c_scores[melhor_c] - base_scores[melhor_base]
print(f"\n  ► Melhor C: {melhor_c} ({c_scores[melhor_c]:.3f})  "
      f"Δ vs baseline: {delta_c:+.3f}")

# Testa também StandardScaler aplicado APÓS ponderação
print(f"\n  --- Ponderação + StandardScaler (escalonamento após peso) ---\n")
from sklearn.preprocessing import StandardScaler as SS
X_pond_scaled = SS().fit_transform(X_ponderado)
c2_scores = {}
for nome, fn in MODELOS_MULTI.items():
    m, s = cv_scores(fn, X_pond_scaled, y6, f"[scaled] {nome}")
    c2_scores[nome] = m
melhor_c2 = max(c2_scores, key=c2_scores.get)
delta_c2  = c2_scores[melhor_c2] - base_scores[melhor_base]
print(f"\n  ► Melhor C (scaled): {melhor_c2} ({c2_scores[melhor_c2]:.3f})  "
      f"Δ vs baseline: {delta_c2:+.3f}")

print("\n" + "=" * 65)
print("RESUMO FINAL")
print("=" * 65)
print(f"  Baseline (6 classes, 10 feat)            : {base_scores[melhor_base]:.3f}")
print(f"  A) + P(Ineficiente) como feature         : {a_scores[melhor_a]:.3f}  "
      f"Δ={a_scores[melhor_a]-base_scores[melhor_base]:+.3f}")
print(f"  B) 7 classes direto (sem cascata)        : {b7_scores[melhor_b7]:.3f}  "
      f"Δ={b7_scores[melhor_b7]-base_scores[melhor_base]:+.3f}")
print(f"  C) Features ponderadas (importância)     : {c_scores[melhor_c]:.3f}  "
      f"Δ={c_scores[melhor_c]-base_scores[melhor_base]:+.3f}")
print(f"  C) Features pond. + scaled               : {c2_scores[melhor_c2]:.3f}  "
      f"Δ={c2_scores[melhor_c2]-base_scores[melhor_base]:+.3f}")

todos = {
    f"baseline/{melhor_base}": base_scores[melhor_base],
    f"A/{melhor_a}": a_scores[melhor_a],
    f"B7/{melhor_b7}": b7_scores[melhor_b7],
    f"C/{melhor_c}": c_scores[melhor_c],
    f"C_scaled/{melhor_c2}": c2_scores[melhor_c2],
}
melhor_global = max(todos, key=todos.get)
print(f"\n  ► MELHOR GLOBAL: {melhor_global} = {todos[melhor_global]:.3f}")

# Relatório detalhado da melhor estratégia
grupo = melhor_global.split("/")[0]
if grupo == 'baseline':
    X_final, y_final, tag = X_base, y6, "6 classes, 10 feat"
elif grupo == 'A':
    X_final, y_final, tag = X_plus, y6, "6 classes, 11 feat (+ P_bin)"
elif grupo == 'B7':
    X_final, y_final, tag = X_base, y7, "7 classes, 10 feat"
elif grupo == 'C':
    X_final, y_final, tag = X_ponderado, y6, "6 classes, feat ponderadas"
else:
    X_final, y_final, tag = X_pond_scaled, y6, "6 classes, feat pond+scaled"

clf_nome = melhor_global.split("/")[1]
X_tr, X_te, y_tr, y_te = train_test_split(
    X_final, y_final, test_size=0.2, stratify=y_final, random_state=SEED
)
clf = MODELOS_MULTI[clf_nome]()
clf.fit(X_tr, y_tr)
y_pred = clf.predict(X_te)

print(f"\n{'='*65}")
print(f"Relatório detalhado — {clf_nome} ({tag}, split 80/20):")
print(f"{'='*65}")
print(classification_report(y_te, y_pred, zero_division=0))

labels_sorted = sorted(set(y_final))
cm = confusion_matrix(y_te, y_pred, labels=labels_sorted)
print("Matriz de confusão:")
print(f"{'':>15}", end="")
for l in labels_sorted:
    print(f"{l[:10]:>12}", end="")
print()
for i, l in enumerate(labels_sorted):
    print(f"{l:>15}", end="")
    for j in range(len(labels_sorted)):
        print(f"{cm[i][j]:>12}", end="")
    print()

print(f"\n{'='*65}")
print("COMPARATIVO HISTÓRICO")
print(f"{'='*65}")
print(f"  v4  (15 feat, 8 classes)                     : ~38.0% bal_acc")
print(f"  v7  (28 feat, 6 classes, SVM)                : ~52.0% bal_acc")
print(f"  v8  ( 7 feat, 6 classes, SVM)                : ~55.6% bal_acc")
print(f"  v10 ( 9 feat, 5 classes, Sublinear)          : ~58.8% bal_acc")
print(f"  v11 (10 feat, 2 classes, Efic/Inefic)        : ~72.6% bal_acc")
print(f"  v12 melhor multiclasse ({tag}) : {todos[melhor_global]:.1%} bal_acc")
