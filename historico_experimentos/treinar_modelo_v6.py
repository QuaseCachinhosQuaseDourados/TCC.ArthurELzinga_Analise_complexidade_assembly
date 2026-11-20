"""v6: treino com o dataset final (instrucoes_dataset_final.csv)."""
import sys
import numpy as np
import pandas as pd
from collections import Counter
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.model_selection import StratifiedKFold, cross_validate, train_test_split
from sklearn.metrics import classification_report

sys.stdout.reconfigure(encoding='utf-8')

CSV    = "instrucoes_dataset_final.csv"
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
print(f"Total de amostras no CSV: {len(df)}")

df = df[df[TARGET].notna() & (df[TARGET] != "")]
print(f"Com label de tempo:       {len(df)}")

df["classe"] = df[TARGET].map(MAPA_CLASSES)
sem_mapa = df["classe"].isna()
if sem_mapa.any():
    print(f"Labels nao mapeadas (ignoradas): {df.loc[sem_mapa, TARGET].unique()}")
df = df[~sem_mapa]

contagem = df["classe"].value_counts()
classes_validas = contagem[contagem >= 3].index
df = df[df["classe"].isin(classes_validas)]

print(f"\nAmostras apos filtros: {len(df)}")
print("\nDistribuicao de classes:")
print(df["classe"].value_counts().to_string())

# Mostra distribuição por origem
if "origem" in df.columns:
    print("\nDistribuicao por origem:")
    print(df.groupby(["classe", "origem"]).size().unstack(fill_value=0).to_string())

colunas_feat = [c for c in df.columns
                if c not in ("arquivo", "time_complexity", "space_complexity", "classe", "origem")]
print(f"\nFeatures ({len(colunas_feat)}): {colunas_feat}")

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
    cv_res = cross_validate(clf, X, y, cv=skf, scoring="balanced_accuracy", n_jobs=-1)
    scores = cv_res["test_score"]
    resultados[nome] = scores
    print(f"  {nome:<22}: {scores.mean():.3f} +/- {scores.std():.3f}  "
          f"(folds: {[f'{s:.3f}' for s in scores]})")

melhor_nome = max(resultados, key=lambda n: resultados[n].mean())
print(f"\nMelhor modelo: {melhor_nome}  "
      f"(balanced_accuracy = {resultados[melhor_nome].mean():.3f})")

X_tr, X_te, y_tr, y_te = train_test_split(X, y, test_size=0.2, stratify=y, random_state=SEED)
clf_melhor = modelos[melhor_nome]
clf_melhor.fit(X_tr, y_tr)
y_pred = clf_melhor.predict(X_te)

print(f"\n{'='*60}")
print("Relatorio de classificacao (split 80/20):")
print(f"{'='*60}")
print(classification_report(y_te, y_pred, zero_division=0))
print(f"Acuracia geral (split 80/20): {(y_pred == y_te).mean():.1%}")

if hasattr(clf_melhor, "feature_importances_"):
    importancias = clf_melhor.feature_importances_
    print("\nImportancia das features:")
    for feat, imp in sorted(zip(colunas_feat, importancias), key=lambda x: -x[1]):
        print(f"  {feat:<12}  {imp:.4f}")
