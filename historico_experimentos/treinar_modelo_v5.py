"""v5: treino com o dataset ampliado (instrucoes_completo.csv)."""
import sys
import numpy as np
import pandas as pd
from collections import Counter
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import StratifiedKFold, cross_validate
from sklearn.metrics import balanced_accuracy_score, classification_report

sys.stdout.reconfigure(encoding='utf-8')

CSV        = "instrucoes_completo.csv"
TARGET     = "time_complexity"
N_FOLDS    = 5
SEED       = 42

# Consolidação de classes (igual à v3/v4: 9 → 6 classes)
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
print(f"Total de amostras no CSV: {len(df)}")

df = df[df[TARGET].notna() & (df[TARGET] != "")]
print(f"Com label de tempo:       {len(df)}")

df["classe"] = df[TARGET].map(MAPA_CLASSES)
sem_mapa = df["classe"].isna()
if sem_mapa.any():
    print(f"Labels não mapeadas (ignoradas): {df.loc[sem_mapa, TARGET].unique()}")
df = df[~sem_mapa]

# Remove classes com < 3 amostras (inviável para CV-5)
contagem = df["classe"].value_counts()
classes_validas = contagem[contagem >= 3].index
df = df[df["classe"].isin(classes_validas)]

print(f"\nAmostras após filtros: {len(df)}")
print("\nDistribuição de classes:")
print(df["classe"].value_counts().to_string())

colunas_feat = [c for c in df.columns
                if c not in ("arquivo", "time_complexity", "space_complexity", "classe")]
print(f"\nFeatures utilizadas ({len(colunas_feat)}): {colunas_feat}")

X = df[colunas_feat].values
y = df["classe"].values

modelos = {
    "Random Forest"    : RandomForestClassifier(n_estimators=200, random_state=SEED, n_jobs=-1),
    "Gradient Boosting": GradientBoostingClassifier(n_estimators=200, random_state=SEED),
    "KNN (k=5)"        : KNeighborsClassifier(n_neighbors=5),
    "SVM (RBF)"        : SVC(kernel='rbf', C=10, gamma='scale', random_state=SEED),
}

skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)

print(f"\n{'='*60}")
print(f"Stratified {N_FOLDS}-Fold Cross-Validation  (balanced_accuracy)")
print(f"{'='*60}")

resultados = {}
for nome, clf in modelos.items():
    cv_res = cross_validate(clf, X, y, cv=skf,
                            scoring="balanced_accuracy", n_jobs=-1)
    scores = cv_res["test_score"]
    resultados[nome] = scores
    print(f"  {nome:<22}: {scores.mean():.3f} ± {scores.std():.3f}  "
          f"(folds: {[f'{s:.3f}' for s in scores]})")

melhor_nome = max(resultados, key=lambda n: resultados[n].mean())
print(f"\nMelhor modelo: {melhor_nome}  "
      f"(balanced_accuracy = {resultados[melhor_nome].mean():.3f})")

from sklearn.model_selection import train_test_split

X_tr, X_te, y_tr, y_te = train_test_split(X, y,
                                           test_size=0.2,
                                           stratify=y,
                                           random_state=SEED)
clf_melhor = modelos[melhor_nome]
clf_melhor.fit(X_tr, y_tr)
y_pred = clf_melhor.predict(X_te)

print(f"\n{'='*60}")
print("Relatório de classificação (split 80/20):")
print(f"{'='*60}")
print(classification_report(y_te, y_pred, zero_division=0))

acc_geral = (y_pred == y_te).mean()
print(f"Acurácia geral (split 80/20): {acc_geral:.1%}")

if hasattr(clf_melhor, "feature_importances_"):
    importancias = clf_melhor.feature_importances_
    print("\nImportância das features (Random Forest):")
    for feat, imp in sorted(zip(colunas_feat, importancias),
                            key=lambda x: -x[1]):
        print(f"  {feat:<12}  {imp:.4f}")
