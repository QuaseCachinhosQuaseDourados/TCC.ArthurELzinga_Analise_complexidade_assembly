"""v7: treino com as features estruturais do assembly."""
import sys
import warnings
import numpy as np
import pandas as pd
from collections import Counter
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import StratifiedKFold, cross_validate, train_test_split
from sklearn.metrics import classification_report, confusion_matrix

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV        = "features_asm_estrutural.csv"
TARGET     = "time_complexity"
N_FOLDS    = 5
SEED       = 42

# Consolidação de classes (mesma das versões anteriores)
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

contagem = df["classe"].value_counts()
classes_validas = contagem[contagem >= 3].index
df = df[df["classe"].isin(classes_validas)]

print(f"\nAmostras após filtros: {len(df)}")
print("\nDistribuição de classes:")
print(df["classe"].value_counts().to_string())

FEAT_15 = [
    'mov', 'call', 'lea', 'add', 'push', 'pop', 'cmp',
    'sub', 'ret', 'jmp', 'je', 'test', 'movslq', 'jne', 'jle',
]

FEAT_ESTRUTURAIS = [
    'total_instructions', 'num_functions', 'num_labels',
    'backward_jumps', 'forward_jumps', 'conditional_backward',
    'has_recursion', 'recursive_call_count', 'max_recursive_per_func',
    'unique_call_targets', 'max_stack_frame', 'jump_ratio', 'branch_ratio',
]

FEAT_TODAS = FEAT_15 + FEAT_ESTRUTURAIS

y = df["classe"].values

def avaliar_conjunto_features(nome_conjunto, colunas_feat, df, y):
    """Roda 5-Fold CV com vários modelos e reporta resultados."""
    X = df[colunas_feat].values
    skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)

    modelos = {
        "Random Forest": RandomForestClassifier(
            n_estimators=200, class_weight="balanced", random_state=SEED, n_jobs=-1
        ),
        "Gradient Boosting": GradientBoostingClassifier(
            n_estimators=200, learning_rate=0.05, max_depth=4, random_state=SEED
        ),
        "KNN (k=5, scaler)": Pipeline([
            ('scaler', StandardScaler()),
            ('knn', KNeighborsClassifier(n_neighbors=5, weights='distance', metric='manhattan'))
        ]),
        "SVM (RBF, scaler)": Pipeline([
            ('scaler', StandardScaler()),
            ('svm', SVC(kernel='rbf', C=10, gamma='scale', random_state=SEED))
        ]),
    }

    print(f"\n{'='*65}")
    print(f"  {nome_conjunto} — {len(colunas_feat)} features")
    print(f"  Stratified {N_FOLDS}-Fold CV  (balanced_accuracy)")
    print(f"{'='*65}")

    resultados = {}
    for nome, clf in modelos.items():
        cv_res = cross_validate(clf, X, y, cv=skf,
                                scoring="balanced_accuracy", n_jobs=-1)
        scores = cv_res["test_score"]
        resultados[nome] = scores
        print(f"  {nome:<26}: {scores.mean():.3f} ± {scores.std():.3f}  "
              f"(folds: {[f'{s:.3f}' for s in scores]})")

    melhor_nome = max(resultados, key=lambda n: resultados[n].mean())
    melhor_score = resultados[melhor_nome].mean()
    print(f"\n  Melhor: {melhor_nome} ({melhor_score:.3f})")

    return resultados, melhor_nome


# A) Apenas 15 instruções (baseline, igual às versões anteriores)
res_15, melhor_15 = avaliar_conjunto_features(
    "A) Apenas 15 instruções (baseline)", FEAT_15, df, y
)

# B) Apenas features estruturais (13)
res_est, melhor_est = avaliar_conjunto_features(
    "B) Apenas features estruturais (13)", FEAT_ESTRUTURAIS, df, y
)

# C) Todas as 28 features (15 + 13)
res_todas, melhor_todas = avaliar_conjunto_features(
    "C) Todas as 28 features (15 + 13)", FEAT_TODAS, df, y
)

todos_resultados = {
    f"15instr/{k}": v for k, v in res_15.items()
} | {
    f"estrut/{k}": v for k, v in res_est.items()
} | {
    f"todas/{k}": v for k, v in res_todas.items()
}

melhor_global = max(todos_resultados, key=lambda n: todos_resultados[n].mean())
print(f"\n{'='*65}")
print(f"MELHOR RESULTADO GLOBAL: {melhor_global}")
print(f"  balanced_accuracy = {todos_resultados[melhor_global].mean():.3f} "
      f"± {todos_resultados[melhor_global].std():.3f}")
print(f"{'='*65}")

# Determina qual conjunto de features usar e qual modelo
grupo, nome_modelo = melhor_global.split("/", 1)
if grupo == "15instr":
    feat_final = FEAT_15
elif grupo == "estrut":
    feat_final = FEAT_ESTRUTURAIS
else:
    feat_final = FEAT_TODAS

# Split 80/20 para relatório detalhado
X_all = df[feat_final].values
X_tr, X_te, y_tr, y_te = train_test_split(
    X_all, y, test_size=0.2, stratify=y, random_state=SEED
)

modelos_map = {
    "Random Forest": RandomForestClassifier(
        n_estimators=200, class_weight="balanced", random_state=SEED, n_jobs=-1
    ),
    "Gradient Boosting": GradientBoostingClassifier(
        n_estimators=200, learning_rate=0.05, max_depth=4, random_state=SEED
    ),
    "KNN (k=5, scaler)": Pipeline([
        ('scaler', StandardScaler()),
        ('knn', KNeighborsClassifier(n_neighbors=5, weights='distance', metric='manhattan'))
    ]),
    "SVM (RBF, scaler)": Pipeline([
        ('scaler', StandardScaler()),
        ('svm', SVC(kernel='rbf', C=10, gamma='scale', random_state=SEED))
    ]),
}

clf_final = modelos_map[nome_modelo]
clf_final.fit(X_tr, y_tr)
y_pred = clf_final.predict(X_te)

print(f"\nRelatório de classificação ({nome_modelo}, split 80/20):")
print(classification_report(y_te, y_pred, zero_division=0))
print(f"Acurácia geral: {(y_pred == y_te).mean():.1%}")

# Matriz de confusão
labels_sorted = sorted(set(y))
cm = confusion_matrix(y_te, y_pred, labels=labels_sorted)
print("\nMatriz de confusão:")
print(f"{'':>15}", end="")
for l in labels_sorted:
    print(f"{l[:8]:>10}", end="")
print()
for i, l in enumerate(labels_sorted):
    print(f"{l:>15}", end="")
    for j in range(len(labels_sorted)):
        print(f"{cm[i][j]:>10}", end="")
    print()

# Importância de features (se RF ou GB)
if hasattr(clf_final, "feature_importances_"):
    print(f"\nImportância das features ({nome_modelo}):")
    importancias = clf_final.feature_importances_
    for feat, imp in sorted(zip(feat_final, importancias), key=lambda x: -x[1]):
        barra = "█" * int(imp * 100)
        print(f"  {feat:<26}  {imp:.4f}  {barra}")

print(f"\n{'='*65}")
print("COMPARATIVO: v4 (baseline) vs v7 (estrutural)")
print(f"{'='*65}")
print(f"  v4: 15 features, 189 amostras, 8 classes → ~38.0% bal.acc")
print(f"  v7: {len(feat_final)} features, {len(y)} amostras, 6 classes → "
      f"{todos_resultados[melhor_global].mean():.1%} bal.acc")
delta = todos_resultados[melhor_global].mean() - 0.38
print(f"  Δ = {delta:+.1%}")
