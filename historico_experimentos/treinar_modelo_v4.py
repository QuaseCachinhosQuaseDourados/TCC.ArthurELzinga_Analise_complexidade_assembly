"""v4: avaliação das 15 instruções originais."""

import sys, warnings
sys.stdout.reconfigure(encoding="utf-8")
warnings.filterwarnings("ignore")

import pandas as pd
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import StratifiedKFold, cross_validate
from sklearn.metrics import classification_report
from autogluon.tabular import TabularPredictor
from sklearn.model_selection import train_test_split

CSV_PATH = "instrucoes_por_arquivo.csv"
TARGET   = "time_complexity"
N_FOLDS  = 5

FEATURES_15 = [
    "mov", "call", "lea", "add", "push", "pop",
    "cmp", "sub", "ret", "jmp", "je", "test",
    "movslq", "jne", "jle",
]

df = pd.read_csv(CSV_PATH)
df = df[df[TARGET].notna() & (df[TARGET] != "")].copy()

# Remove classes com < 3 amostras
contagem = df[TARGET].value_counts()
df = df[df[TARGET].isin(contagem[contagem >= 3].index)].copy()

X = df[FEATURES_15]
y = df[TARGET]

print(f"Dataset: {len(df)} amostras | {len(FEATURES_15)} features")
print(f"\nDistribuicao das classes:")
print(y.value_counts().to_string())

print("\n" + "=" * 60)
print(f"STRATIFIED {N_FOLDS}-FOLD CROSS-VALIDATION  (15 instrucoes)")
print("=" * 60)

skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=42)

modelos = {
    "Random Forest     ": RandomForestClassifier(
        n_estimators=300, class_weight="balanced",
        random_state=42, n_jobs=-1
    ),
    "Gradient Boosting ": GradientBoostingClassifier(
        n_estimators=200, learning_rate=0.05,
        max_depth=4, random_state=42
    ),
    "KNN (k=5)         ": KNeighborsClassifier(
        n_neighbors=5, weights="distance", metric="manhattan"
    ),
}

resultados = {}
for nome, clf in modelos.items():
    scores = cross_validate(
        clf, X, y,
        cv=skf,
        scoring="balanced_accuracy",
        return_train_score=False,
        n_jobs=-1,
    )
    media  = scores["test_score"].mean()
    desvio = scores["test_score"].std()
    folds  = " | ".join(f"{s:.1%}" for s in scores["test_score"])
    print(f"\n{nome}")
    print(f"  Balanced accuracy: {media:.1%} +/- {desvio:.1%}")
    print(f"  Por fold: {folds}")
    resultados[nome] = (media, desvio, scores["test_score"])

melhor = max(resultados, key=lambda k: resultados[k][0])
print(f"\nMelhor modelo: {melhor.strip()} "
      f"({resultados[melhor][0]:.1%} +/- {resultados[melhor][1]:.1%})")

print("\n" + "=" * 60)
print("RELATORIO POR CLASSE (ultimo fold do melhor modelo)")
print("=" * 60)
folds_list = list(skf.split(X, y))
train_idx, test_idx = folds_list[-1]

nome_melhor = melhor.strip()
clf_melhor = modelos[melhor]
clf_melhor.fit(X.iloc[train_idx], y.iloc[train_idx])
y_pred = clf_melhor.predict(X.iloc[test_idx])
print(classification_report(y.iloc[test_idx], y_pred, zero_division=0))

print("\n" + "=" * 60)
print("AUTOGLUON com 15 features (split 80/20 para leaderboard)")
print("=" * 60)

df_ag = X.copy()
df_ag[TARGET] = y.values

df_treino, df_teste = train_test_split(
    df_ag, test_size=0.2, random_state=42, stratify=df_ag[TARGET]
)

predictor = TabularPredictor(
    label=TARGET,
    eval_metric="balanced_accuracy",
    path="modelo_autogluon_v4",
    verbosity=1,
).fit(
    train_data=df_treino,
    time_limit=300,
    presets="best_quality",
    num_bag_folds=5,
    num_stack_levels=1,
)

res = predictor.evaluate(df_teste, silent=True)
preds = predictor.predict(df_teste.drop(columns=[TARGET]))
acuracia = (preds.values == df_teste[TARGET].values).mean()

print(f"Balanced accuracy : {res.get('balanced_accuracy', 0):.1%}")
print(f"Acuracia geral    : {acuracia:.1%}")

print("\nLeaderboard (top 8):")
lb = predictor.leaderboard(df_teste, silent=True)
print(lb[["model","score_test","score_val","fit_time"]].head(8).to_string())

print("\nImportancia das 15 features:")
imp = predictor.feature_importance(df_teste, silent=True)
print(imp[["importance","stddev","p_value"]].to_string())

print("\n" + "=" * 60)
print("RESUMO COMPARATIVO DE TODAS AS VERSOES")
print("=" * 60)
print(f"{'Versao':<10} {'Features':>10} {'Avaliacao':<22} {'Resultado'}")
print("-" * 60)
print(f"{'v1':<10} {'15':>10} {'1 split 80/20':<22} 60.5% geral (nao confiavel)")
print(f"{'v2':<10} {'35':>10} {'1 split 80/20':<22} 55.3% geral (nao confiavel)")
print(f"{'v3':<10} {'44':>10} {'5-Fold CV':<22} ~40% bal.acc. +/- 8% (confiavel)")
ba_v4 = resultados[melhor][0]
sd_v4 = resultados[melhor][1]
print(f"{'v4':<10} {'15':>10} {'5-Fold CV':<22} {ba_v4:.1%} bal.acc. +/- {sd_v4:.1%} (confiavel)")
