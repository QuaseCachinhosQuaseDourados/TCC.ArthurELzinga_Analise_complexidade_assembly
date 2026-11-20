"""v11: classificação binária Eficiente x Ineficiente."""
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
from sklearn.model_selection import StratifiedKFold, cross_validate, train_test_split
from sklearn.metrics import (classification_report, confusion_matrix,
                             roc_auc_score)

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV     = "features_asm_estrutural.csv"
TARGET  = "time_complexity"
N_FOLDS = 5
SEED    = 42

MAPA_BINARIO = {
    # Eficientes
    "O(1)"      : "Eficiente",
    "O(log n)"  : "Eficiente",
    "O(sqrt(n))": "Eficiente",
    "O(n)"      : "Eficiente",
    "O(n log n)": "Eficiente",
    # Ineficientes
    "O(n*m)"    : "Ineficiente",
    "O(n^2)"    : "Ineficiente",
    "O(n^3)"    : "Ineficiente",
    "O(2^n)"    : "Ineficiente",
}

df = pd.read_csv(CSV)
df = df[df[TARGET].notna() & (df[TARGET] != "")]
df["classe"] = df[TARGET].map(MAPA_BINARIO)
df = df[df["classe"].notna()]

# Feature derivada: recursão combinada com loops (introduzida na v8)
df['recursion_depth'] = df['has_recursion'] * df['backward_jumps']

print(f"Total de amostras com label válido: {len(df)}")
print(f"\nDistribuição das classes:")
contagem = df["classe"].value_counts()
for cls, n in contagem.items():
    print(f"  {cls:<15}: {n:>3} amostras ({n/len(df)*100:.1f}%)")

print(f"\nComposição das classes:")
for label, grupo in [
    ("Eficiente",   ["O(1)", "O(log n)", "O(sqrt(n))", "O(n)", "O(n log n)"]),
    ("Ineficiente", ["O(n*m)", "O(n^2)", "O(n^3)", "O(2^n)"])
]:
    detalhes = [f"{c}={len(df[df[TARGET]==c])}" for c in grupo if len(df[df[TARGET]==c]) > 0]
    print(f"  {label}: {', '.join(detalhes)}")

y = df["classe"].values

# Top-9 significativas (p<0.05, AutoGluon v7) + recursion_depth
FEATURES = [
    'jne', 'add', 'num_labels', 'has_recursion',
    'lea', 'cmp', 'backward_jumps', 'movslq',
    'conditional_backward', 'recursion_depth',
]

X = df[FEATURES].values
print(f"\nFeatures usadas ({len(FEATURES)}): {FEATURES}")

def get_modelos():
    return {
        "Random Forest": RandomForestClassifier(
            n_estimators=300, class_weight="balanced", random_state=SEED,
            max_depth=6, min_samples_leaf=2, n_jobs=-1
        ),
        "Gradient Boosting": GradientBoostingClassifier(
            n_estimators=300, learning_rate=0.03, max_depth=3,
            min_samples_leaf=2, subsample=0.8, random_state=SEED
        ),
        "SVM (RBF)": Pipeline([
            ('scaler', StandardScaler()),
            ('svm', SVC(kernel='rbf', C=10, gamma='scale',
                        class_weight='balanced', probability=True, random_state=SEED))
        ]),
        "SVM (RBF, C=50)": Pipeline([
            ('scaler', StandardScaler()),
            ('svm', SVC(kernel='rbf', C=50, gamma='scale',
                        class_weight='balanced', probability=True, random_state=SEED))
        ]),
        "KNN (k=5)": Pipeline([
            ('scaler', StandardScaler()),
            ('knn', KNeighborsClassifier(n_neighbors=5, weights='distance', metric='manhattan'))
        ]),
        "Logistic Regression": Pipeline([
            ('scaler', StandardScaler()),
            ('lr', LogisticRegression(class_weight='balanced', max_iter=1000,
                                      random_state=SEED, C=1.0))
        ]),
    }

skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)

print(f"\n{'='*65}")
print(f"  Classificação Binária — Stratified {N_FOLDS}-Fold CV")
print(f"{'='*65}")

resultados = {}
for nome, clf in get_modelos().items():
    cv = cross_validate(clf, X, y, cv=skf,
                        scoring=["balanced_accuracy", "f1_weighted", "roc_auc"],
                        n_jobs=-1)
    bal_acc = cv["test_balanced_accuracy"]
    f1      = cv["test_f1_weighted"]
    auc     = cv["test_roc_auc"]
    resultados[nome] = bal_acc
    print(f"  {nome:<26}  bal_acc={bal_acc.mean():.3f}±{bal_acc.std():.3f}"
          f"  f1={f1.mean():.3f}  auc={auc.mean():.3f}")

melhor = max(resultados, key=lambda n: resultados[n].mean())
print(f"\n  ► Melhor: {melhor} (bal_acc={resultados[melhor].mean():.3f})")

X_tr, X_te, y_tr, y_te = train_test_split(
    X, y, test_size=0.2, stratify=y, random_state=SEED
)

clf_final = get_modelos()[melhor]
clf_final.fit(X_tr, y_tr)
y_pred = clf_final.predict(X_te)

print(f"\n{'='*65}")
print(f"  Relatório detalhado — {melhor} (split 80/20)")
print(f"{'='*65}")
print(classification_report(y_te, y_pred, zero_division=0))

if hasattr(clf_final, "predict_proba"):
    y_prob = clf_final.predict_proba(X_te)
    classes = clf_final.classes_
    idx_inef = list(classes).index("Ineficiente")
    auc_score = roc_auc_score((y_te == "Ineficiente").astype(int), y_prob[:, idx_inef])
    print(f"  ROC-AUC (split 80/20): {auc_score:.3f}")

# Matriz de confusão
cm = confusion_matrix(y_te, y_pred, labels=["Eficiente", "Ineficiente"])
print(f"\nMatriz de confusão:")
print(f"{'':>20}  {'Eficiente':>12}  {'Ineficiente':>12}")
for i, label in enumerate(["Eficiente", "Ineficiente"]):
    print(f"  {'Real '+label:<18}  {cm[i][0]:>12}  {cm[i][1]:>12}")

print(f"\n{'='*65}")
print("COMPARATIVO GERAL")
print(f"{'='*65}")
print(f"  v4  (15 feat, 8 classes)                : ~38.0% bal_acc")
print(f"  v6  (15 feat, 6 classes, + LeetCode)    : ~44.8% bal_acc")
print(f"  v7  (28 feat, 6 classes, SVM)           : ~52.0% bal_acc")
print(f"  v8  ( 7 feat, 6 classes, SVM)           : ~55.6% bal_acc")
print(f"  v10 ( 9 feat, 5 classes, Sublinear)     : ~58.8% bal_acc")
print(f"  v11 ({len(FEATURES):>2} feat, 2 classes, BINÁRIO)    :"
      f" {resultados[melhor].mean():.1%} bal_acc  ← atual")
