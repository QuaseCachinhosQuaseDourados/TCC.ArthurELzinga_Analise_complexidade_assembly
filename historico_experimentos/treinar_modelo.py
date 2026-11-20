"""Primeiro treino com AutoGluon Tabular."""

import pandas as pd
from autogluon.tabular import TabularPredictor

CSV_PATH      = "instrucoes_por_arquivo.csv"
TARGET_COLUNA = "time_complexity"
MODELO_DIR    = "modelo_autogluon"
TEMPO_LIMITE  = 120

FEATURES = [
    "mov", "call", "lea", "add", "push", "pop",
    "cmp", "sub", "ret", "jmp", "je", "test",
    "movslq", "jne", "jle",
]

df = pd.read_csv(CSV_PATH)

# Remove linhas sem label de complexidade de tempo
df = df[df[TARGET_COLUNA].notna() & (df[TARGET_COLUNA] != "")]
print(f"Amostras com label valido: {len(df)}")
print(f"\nDistribuição das classes:\n{df[TARGET_COLUNA].value_counts()}\n")

# Seleciona apenas as colunas de features + target
df_modelo = df[FEATURES + [TARGET_COLUNA]].copy()

from sklearn.model_selection import train_test_split

df_treino, df_teste = train_test_split(
    df_modelo,
    test_size=0.2,
    random_state=42,
    stratify=df_modelo[TARGET_COLUNA],
)
print(f"Treino : {len(df_treino)} amostras")
print(f"Teste  : {len(df_teste)} amostras\n")

predictor = TabularPredictor(
    label=TARGET_COLUNA,
    eval_metric="balanced_accuracy",
    path=MODELO_DIR,
    verbosity=2,
).fit(
    train_data=df_treino,
    time_limit=TEMPO_LIMITE,
    presets="best_quality",
    num_bag_folds=5,
    num_stack_levels=1,
)

print("\n" + "=" * 60)
print("AVALIAÇÃO NO CONJUNTO DE TESTE")
print("=" * 60)

resultado = predictor.evaluate(df_teste, silent=False)

# Leaderboard dos modelos treinados
print("\nLeaderboard dos modelos:")
leaderboard = predictor.leaderboard(df_teste, silent=True)
print(leaderboard[["model", "score_test", "score_val", "fit_time"]].to_string())

print("\n" + "=" * 60)
print("IMPORTÂNCIA DAS FEATURES (instruções mais preditivas)")
print("=" * 60)
importancia = predictor.feature_importance(df_teste)
print(importancia.head(15).to_string())

print("\n" + "=" * 60)
print("PREDIÇÕES vs REAL (conjunto de teste)")
print("=" * 60)
predicoes = predictor.predict(df_teste.drop(columns=[TARGET_COLUNA]))
comparacao = pd.DataFrame({
    "arquivo": df_teste.index,
    "real": df_teste[TARGET_COLUNA].values,
    "predito": predicoes.values,
})
comparacao["acerto"] = comparacao["real"] == comparacao["predito"]
print(comparacao.to_string())
print(f"\nAcurácia geral: {comparacao['acerto'].mean():.2%}")
print(f"Modelo salvo em: {MODELO_DIR}/")
