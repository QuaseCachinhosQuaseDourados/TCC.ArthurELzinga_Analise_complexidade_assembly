"""v8: só as features mais importantes."""
import sys
import warnings
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import StratifiedKFold, cross_validate, train_test_split
from sklearn.metrics import classification_report, confusion_matrix, balanced_accuracy_score

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV    = "features_asm_estrutural.csv"
TARGET = "time_complexity"
N_FOLDS = 5
SEED   = 42

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

df = pd.read_csv(CSV)
df = df[df[TARGET].notna() & (df[TARGET] != "")]
df["classe"] = df[TARGET].map(MAPA_CLASSES)
df = df[df["classe"].notna()]

contagem = df["classe"].value_counts()
classes_validas = contagem[contagem >= 3].index
df = df[df["classe"].isin(classes_validas)]

print(f"Amostras: {len(df)}")
print(f"\nDistribuição:\n{df['classe'].value_counts().to_string()}\n")

y = df["classe"].values


# A) Top-9 significativas (p < 0.05 no AutoGluon)
FEAT_TOP9 = [
    'jne', 'add', 'num_labels', 'has_recursion',
    'lea', 'cmp', 'backward_jumps', 'movslq',
    'conditional_backward',
]

df['loop_intensity'] = df['backward_jumps'] / df['num_labels'].clip(lower=1)
df['branch_per_label'] = df['conditional_backward'] / df['num_labels'].clip(lower=1)
df['cmp_add_ratio'] = df['cmp'] / df['add'].clip(lower=1)
df['jump_cmp_interaction'] = df['jne'] * df['cmp']
df['lea_movslq_interaction'] = df['lea'] * df['movslq']
df['recursion_depth'] = df['has_recursion'] * df['backward_jumps']

FEAT_DERIVADAS = [
    'loop_intensity', 'branch_per_label', 'cmp_add_ratio',
    'jump_cmp_interaction', 'lea_movslq_interaction', 'recursion_depth',
]

FEAT_TOP9_PLUS = FEAT_TOP9 + FEAT_DERIVADAS

def get_modelos():
    return {
        "Random Forest": RandomForestClassifier(
            n_estimators=300, class_weight="balanced", random_state=SEED,
            max_depth=6, min_samples_leaf=3, n_jobs=-1
        ),
        "Gradient Boosting": GradientBoostingClassifier(
            n_estimators=300, learning_rate=0.03, max_depth=3,
            min_samples_leaf=3, subsample=0.8, random_state=SEED
        ),
        "KNN (k=5)": Pipeline([
            ('scaler', StandardScaler()),
            ('knn', KNeighborsClassifier(n_neighbors=5, weights='distance', metric='manhattan'))
        ]),
        "KNN (k=7)": Pipeline([
            ('scaler', StandardScaler()),
            ('knn', KNeighborsClassifier(n_neighbors=7, weights='distance', metric='manhattan'))
        ]),
        "SVM (RBF)": Pipeline([
            ('scaler', StandardScaler()),
            ('svm', SVC(kernel='rbf', C=10, gamma='scale', class_weight='balanced', random_state=SEED))
        ]),
        "SVM (RBF, C=50)": Pipeline([
            ('scaler', StandardScaler()),
            ('svm', SVC(kernel='rbf', C=50, gamma='scale', class_weight='balanced', random_state=SEED))
        ]),
        "SVM (poly d=3)": Pipeline([
            ('scaler', StandardScaler()),
            ('svm', SVC(kernel='poly', degree=3, C=10, gamma='scale', class_weight='balanced', random_state=SEED))
        ]),
    }


def avaliar(nome, feats, df, y):
    X = df[feats].values
    skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)
    modelos = get_modelos()

    print(f"\n{'='*65}")
    print(f"  {nome} — {len(feats)} features")
    print(f"  Features: {feats}")
    print(f"  Stratified {N_FOLDS}-Fold CV  (balanced_accuracy)")
    print(f"{'='*65}")

    resultados = {}
    for nome_m, clf in modelos.items():
        cv = cross_validate(clf, X, y, cv=skf, scoring="balanced_accuracy", n_jobs=-1)
        scores = cv["test_score"]
        resultados[nome_m] = scores
        print(f"  {nome_m:<26}: {scores.mean():.3f} ± {scores.std():.3f}  "
              f"(folds: {[f'{s:.3f}' for s in scores]})")

    melhor = max(resultados, key=lambda n: resultados[n].mean())
    print(f"\n  ► Melhor: {melhor} ({resultados[melhor].mean():.3f})")
    return resultados, melhor


# A) Top-9 significativas
res_a, melhor_a = avaliar("A) Top-9 significativas", FEAT_TOP9, df, y)

# B) Top-9 + derivadas
res_b, melhor_b = avaliar("B) Top-9 + 6 derivadas", FEAT_TOP9_PLUS, df, y)

print(f"\n{'='*65}")
print("  C) Forward Feature Selection (SVM RBF)")
print(f"{'='*65}")

ALL_CANDIDATE_FEATS = FEAT_TOP9 + FEAT_DERIVADAS
skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)

selected = []
best_score = 0.0
history = []

for step in range(len(ALL_CANDIDATE_FEATS)):
    remaining = [f for f in ALL_CANDIDATE_FEATS if f not in selected]
    best_feat = None
    best_step_score = 0.0

    for feat in remaining:
        trial = selected + [feat]
        X_trial = df[trial].values
        clf = Pipeline([
            ('scaler', StandardScaler()),
            ('svm', SVC(kernel='rbf', C=10, gamma='scale', class_weight='balanced', random_state=SEED))
        ])
        cv = cross_validate(clf, X_trial, y, cv=skf, scoring="balanced_accuracy", n_jobs=-1)
        score = cv["test_score"].mean()
        if score > best_step_score:
            best_step_score = score
            best_feat = feat

    if best_feat is None:
        break

    selected.append(best_feat)
    history.append((len(selected), best_feat, best_step_score))
    print(f"  Step {len(selected):2d}: +{best_feat:<28} → {best_step_score:.3f}")

    if best_step_score <= best_score and len(selected) > 3:
        # Parou de melhorar
        selected.pop()
        history.pop()
        break
    best_score = best_step_score

FEAT_SELECTED = selected
print(f"\n  ► Features selecionadas ({len(FEAT_SELECTED)}): {FEAT_SELECTED}")
print(f"  ► Score: {best_score:.3f}")

res_c, melhor_c = avaliar("C) Forward Selection resultado", FEAT_SELECTED, df, y)

todos = {}
for label, res in [("top9", res_a), ("top9+deriv", res_b), ("selected", res_c)]:
    for k, v in res.items():
        todos[f"{label}/{k}"] = v

melhor_global = max(todos, key=lambda n: todos[n].mean())
print(f"\n{'='*65}")
print(f"MELHOR GLOBAL: {melhor_global}")
print(f"  balanced_accuracy = {todos[melhor_global].mean():.3f} ± {todos[melhor_global].std():.3f}")
print(f"{'='*65}")

grupo = melhor_global.split("/")[0]
if grupo == "top9":
    feat_final = FEAT_TOP9
elif grupo == "top9+deriv":
    feat_final = FEAT_TOP9_PLUS
else:
    feat_final = FEAT_SELECTED

# Split 80/20 para relatório detalhado
X_all = df[feat_final].values
X_tr, X_te, y_tr, y_te = train_test_split(X_all, y, test_size=0.2, stratify=y, random_state=SEED)

clf_final = Pipeline([
    ('scaler', StandardScaler()),
    ('svm', SVC(kernel='rbf', C=10, gamma='scale', class_weight='balanced', random_state=SEED))
])
clf_final.fit(X_tr, y_tr)
y_pred = clf_final.predict(X_te)

print(f"\nRelatório ({feat_final}):")
print(classification_report(y_te, y_pred, zero_division=0))

labels_sorted = sorted(set(y))
cm = confusion_matrix(y_te, y_pred, labels=labels_sorted)
print("Matriz de confusão:")
print(f"{'':>15}", end="")
for l in labels_sorted:
    print(f"{l[:8]:>10}", end="")
print()
for i, l in enumerate(labels_sorted):
    print(f"{l:>15}", end="")
    for j in range(len(labels_sorted)):
        print(f"{cm[i][j]:>10}", end="")
    print()

print(f"\n{'='*65}")
print("COMPARATIVO COMPLETO")
print(f"{'='*65}")
print(f"  v4  (15 feat, baseline)    : ~38.0% bal.acc")
print(f"  v7  (28 feat, SVM)         : ~52.0% bal.acc")
print(f"  v8  ({len(feat_final)} feat, selecionadas) : {todos[melhor_global].mean():.1%} bal.acc")
delta = todos[melhor_global].mean() - 0.38
print(f"  Δ vs baseline              : {delta:+.1%}")
