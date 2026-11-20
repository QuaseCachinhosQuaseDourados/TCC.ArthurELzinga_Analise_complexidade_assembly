"""v9: junta Logarítmica e Linear."""
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
from sklearn.metrics import classification_report, confusion_matrix

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV     = "features_asm_estrutural.csv"
TARGET  = "time_complexity"
N_FOLDS = 5
SEED    = 42

# 5 classes: juntamos Logaritmica e Linear em "Linear_ou_menor"
MAPA_CLASSES_5 = {
    "O(1)"      : "Constante",
    "O(log n)"  : "Linear_ou_menor",
    "O(sqrt(n))": "Linear_ou_menor",
    "O(n)"      : "Linear_ou_menor",
    "O(n log n)": "Superlinear",
    "O(n*m)"    : "Superlinear",
    "O(n^2)"    : "Polinomial",
    "O(n^3)"    : "Polinomial",
    "O(2^n)"    : "Exponencial",
}

# 6 classes originais (para comparação)
MAPA_CLASSES_6 = {
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

# Features derivadas (mesmas da v8)
df['loop_intensity'] = df['backward_jumps'] / df['num_labels'].clip(lower=1)
df['branch_per_label'] = df['conditional_backward'] / df['num_labels'].clip(lower=1)
df['cmp_add_ratio'] = df['cmp'] / df['add'].clip(lower=1)
df['jump_cmp_interaction'] = df['jne'] * df['cmp']
df['lea_movslq_interaction'] = df['lea'] * df['movslq']
df['recursion_depth'] = df['has_recursion'] * df['backward_jumps']

FEAT_7_SELECTED = [
    'add', 'jne', 'recursion_depth', 'num_labels',
    'conditional_backward', 'has_recursion', 'backward_jumps',
]

FEAT_TOP9 = [
    'jne', 'add', 'num_labels', 'has_recursion',
    'lea', 'cmp', 'backward_jumps', 'movslq',
    'conditional_backward',
]

FEAT_TOP9_PLUS = FEAT_TOP9 + [
    'loop_intensity', 'branch_per_label', 'cmp_add_ratio',
    'jump_cmp_interaction', 'lea_movslq_interaction', 'recursion_depth',
]

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


# PARTE 1: Teste com 5 classes (Logaritmica + Linear juntas)
print("\n" + "█" * 65)
print("  TESTE COM 5 CLASSES (Logaritmica + Linear → Linear_ou_menor)")
print("█" * 65)

df5 = df.copy()
df5["classe"] = df5[TARGET].map(MAPA_CLASSES_5)
df5 = df5[df5["classe"].notna()]
contagem5 = df5["classe"].value_counts()
classes_validas5 = contagem5[contagem5 >= 3].index
df5 = df5[df5["classe"].isin(classes_validas5)]

print(f"\nAmostras: {len(df5)}")
print(f"\nDistribuição (5 classes):\n{df5['classe'].value_counts().to_string()}")

y5 = df5["classe"].values

res5_7, _ = avaliar("5 classes — 7 feat selecionadas", FEAT_7_SELECTED, df5, y5)
res5_9, _ = avaliar("5 classes — Top-9 significativas", FEAT_TOP9, df5, y5)
res5_15, _ = avaliar("5 classes — Top-9 + derivadas", FEAT_TOP9_PLUS, df5, y5)

# PARTE 2: Referência com 6 classes (para comparação direta)
print("\n" + "█" * 65)
print("  REFERÊNCIA COM 6 CLASSES (v8)")
print("█" * 65)

df6 = df.copy()
df6["classe"] = df6[TARGET].map(MAPA_CLASSES_6)
df6 = df6[df6["classe"].notna()]
contagem6 = df6["classe"].value_counts()
classes_validas6 = contagem6[contagem6 >= 3].index
df6 = df6[df6["classe"].isin(classes_validas6)]

y6 = df6["classe"].values
res6_7, _ = avaliar("6 classes — 7 feat selecionadas (ref v8)", FEAT_7_SELECTED, df6, y6)

# MELHOR GLOBAL (5 classes)
todos5 = {}
for label, res in [("7feat", res5_7), ("top9", res5_9), ("top9+d", res5_15)]:
    for k, v in res.items():
        todos5[f"{label}/{k}"] = v

melhor5 = max(todos5, key=lambda n: todos5[n].mean())
ref6 = max(
    {k: v for k, v in {f"ref6/{k2}": v2 for k2, v2 in res6_7.items()}.items()},
    key=lambda n: {f"ref6/{k2}": v2 for k2, v2 in res6_7.items()}[n].mean()
)
ref6_score = max(v.mean() for v in res6_7.values())

print(f"\n{'='*65}")
print(f"MELHOR 5 CLASSES: {melhor5}")
print(f"  balanced_accuracy = {todos5[melhor5].mean():.3f} ± {todos5[melhor5].std():.3f}")
print(f"{'='*65}")

grupo = melhor5.split("/")[0]
if grupo == "7feat":
    feat_final = FEAT_7_SELECTED
elif grupo == "top9":
    feat_final = FEAT_TOP9
else:
    feat_final = FEAT_TOP9_PLUS

X_all = df5[feat_final].values
X_tr, X_te, y_tr, y_te = train_test_split(X_all, y5, test_size=0.2, stratify=y5, random_state=SEED)

nome_modelo = melhor5.split("/")[1]
modelos_map = get_modelos()
clf_final = modelos_map[nome_modelo]
clf_final.fit(X_tr, y_tr)
y_pred = clf_final.predict(X_te)

print(f"\nRelatório de classificação ({nome_modelo}, 5 classes, split 80/20):")
print(classification_report(y_te, y_pred, zero_division=0))

labels_sorted = sorted(set(y5))
cm = confusion_matrix(y_te, y_pred, labels=labels_sorted)
print("Matriz de confusão:")
print(f"{'':>18}", end="")
for l in labels_sorted:
    print(f"{l[:10]:>12}", end="")
print()
for i, l in enumerate(labels_sorted):
    print(f"{l:>18}", end="")
    for j in range(len(labels_sorted)):
        print(f"{cm[i][j]:>12}", end="")
    print()

print(f"\n{'='*65}")
print("COMPARATIVO COMPLETO")
print(f"{'='*65}")
print(f"  v4  (15 feat, 6 classes, baseline) : ~38.0% bal.acc")
print(f"  v7  (28 feat, 6 classes, SVM)      : ~52.0% bal.acc")
print(f"  v8  (7 feat, 6 classes, SVM)       : ~55.6% bal.acc")
print(f"  v8  (7 feat, 6 classes, ref)       : {ref6_score:.1%} bal.acc")
print(f"  v9  ({len(feat_final)} feat, 5 classes)          : {todos5[melhor5].mean():.1%} bal.acc")
delta = todos5[melhor5].mean() - 0.38
print(f"  Δ vs baseline                      : {delta:+.1%}")
