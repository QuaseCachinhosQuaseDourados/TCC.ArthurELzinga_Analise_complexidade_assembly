"""v10: junta Constante e Logarítmica em Sublinear."""
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

MAPA_CLASSES = {
    "O(1)"      : "Sublinear",
    "O(log n)"  : "Sublinear",
    "O(sqrt(n))": "Sublinear",
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

# Features derivadas
df['recursion_depth'] = df['has_recursion'] * df['backward_jumps']

print(f"Amostras: {len(df)}")
print(f"\nDistribuição (5 classes):\n{df['classe'].value_counts().to_string()}\n")

y = df["classe"].values

FEAT_7 = [
    'add', 'jne', 'recursion_depth', 'num_labels',
    'conditional_backward', 'has_recursion', 'backward_jumps',
]

FEAT_TOP9 = [
    'jne', 'add', 'num_labels', 'has_recursion',
    'lea', 'cmp', 'backward_jumps', 'movslq',
    'conditional_backward',
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


res_7, _ = avaliar("5 classes — 7 feat selecionadas", FEAT_7, df, y)
res_9, _ = avaliar("5 classes — Top-9 significativas", FEAT_TOP9, df, y)

todos = {}
for label, res in [("7feat", res_7), ("top9", res_9)]:
    for k, v in res.items():
        todos[f"{label}/{k}"] = v

melhor = max(todos, key=lambda n: todos[n].mean())

print(f"\n{'='*65}")
print(f"MELHOR: {melhor}")
print(f"  balanced_accuracy = {todos[melhor].mean():.3f} ± {todos[melhor].std():.3f}")
print(f"{'='*65}")

# Features finais
grupo = melhor.split("/")[0]
feat_final = FEAT_7 if grupo == "7feat" else FEAT_TOP9

X_all = df[feat_final].values
X_tr, X_te, y_tr, y_te = train_test_split(X_all, y, test_size=0.2, stratify=y, random_state=SEED)

nome_modelo = melhor.split("/")[1]
clf_final = get_modelos()[nome_modelo]
clf_final.fit(X_tr, y_tr)
y_pred = clf_final.predict(X_te)

print(f"\nRelatório ({nome_modelo}, 5 classes, split 80/20):")
print(classification_report(y_te, y_pred, zero_division=0))

labels_sorted = sorted(set(y))
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
print("COMPARATIVO COMPLETO")
print(f"{'='*65}")
print(f"  v4  (15 feat, 6 classes, baseline)        : ~38.0% bal.acc")
print(f"  v7  (28 feat, 6 classes, SVM)             : ~52.0% bal.acc")
print(f"  v8  (7 feat, 6 classes, SVM)              : ~55.6% bal.acc")
print(f"  v9  (7 feat, 5 classes Log+Lin)           : ~54.0% bal.acc")
print(f"  v10 ({len(feat_final)} feat, 5 classes Const+Log)      : {todos[melhor].mean():.1%} bal.acc")
delta = todos[melhor].mean() - 0.38
print(f"  Δ vs baseline                             : {delta:+.1%}")
