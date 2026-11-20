"""v2: normalização de features e ajustes de hiperparâmetros."""

import pandas as pd
import numpy as np
from autogluon.tabular import TabularPredictor
from sklearn.model_selection import train_test_split

CSV_PATH      = "instrucoes_por_arquivo.csv"
TARGET        = "time_complexity"
MODELO_DIR    = "modelo_autogluon_v2"
TEMPO_LIMITE  = 300

INSTRUCOES = [
    "mov", "call", "lea", "add", "push", "pop",
    "cmp", "sub", "ret", "jmp", "je", "test",
    "movslq", "jne", "jle",
]
SALTOS = ["jmp", "je", "jne", "jle"]

df = pd.read_csv(CSV_PATH)
df = df[df[TARGET].notna() & (df[TARGET] != "")].copy()

# Remove classes com < 3 amostras (impossível estratificar treino/teste)
contagem_classes = df[TARGET].value_counts()
classes_validas  = contagem_classes[contagem_classes >= 3].index
removidos = df[~df[TARGET].isin(classes_validas)]
if len(removidos) > 0:
    print(f"Classes removidas por ter < 3 amostras: "
          f"{removidos[TARGET].value_counts().to_dict()}")
df = df[df[TARGET].isin(classes_validas)].copy()

print(f"\nAmostras após filtro: {len(df)}")
print(f"Distribuição das classes:\n{df[TARGET].value_counts()}\n")

# DECISÃO 1: normalização por total de instruções
total = df[INSTRUCOES].sum(axis=1).replace(0, 1)
for col in INSTRUCOES:
    df[f"prop_{col}"] = df[col] / total

# DECISÃO 2: razões semânticas
df["total_instrucoes"]  = total
df["ratio_jump_total"]  = df[SALTOS].sum(axis=1) / total
df["ratio_call_total"]  = df["call"] / total
df["ratio_cmp_total"]   = df["cmp"]  / total
df["ratio_jump_cmp"]    = df[SALTOS].sum(axis=1) / (df["cmp"] + 1)

FEATURES_V2 = (
    INSTRUCOES
    + [f"prop_{c}" for c in INSTRUCOES]
    + ["total_instrucoes", "ratio_jump_total", "ratio_call_total",
       "ratio_cmp_total", "ratio_jump_cmp"]
)

df_modelo = df[FEATURES_V2 + [TARGET]].copy()
print(f"Total de features: {len(FEATURES_V2)}")

df_treino, df_teste = train_test_split(
    df_modelo,
    test_size=0.2,
    random_state=42,
    stratify=df_modelo[TARGET],
)
print(f"Treino: {len(df_treino)} | Teste: {len(df_teste)}\n")

predictor = TabularPredictor(
    label=TARGET,
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
print("AVALIAÇÃO NO CONJUNTO DE TESTE (v2)")
print("=" * 60)
resultado = predictor.evaluate(df_teste, silent=False)

print("\nLeaderboard dos modelos:")
lb = predictor.leaderboard(df_teste, silent=True)
print(lb[["model", "score_test", "score_val", "fit_time"]].to_string())

print("\n" + "=" * 60)
print("IMPORTÂNCIA DAS FEATURES")
print("=" * 60)
imp = predictor.feature_importance(df_teste)
print(imp.head(20).to_string())

print("\n" + "=" * 60)
print("PREDIÇÕES vs REAL")
print("=" * 60)
preds = predictor.predict(df_teste.drop(columns=[TARGET]))
comp  = pd.DataFrame({
    "real": df_teste[TARGET].values,
    "predito": preds.values,
})
comp["acerto"] = comp["real"] == comp["predito"]
print(comp.to_string())

acc_geral = comp["acerto"].mean()
print(f"\nAcurácia geral  : {acc_geral:.2%}")

# Acurácia por classe
print("\nAcurácia por classe:")
for cls in sorted(comp["real"].unique()):
    mask = comp["real"] == cls
    acc  = comp.loc[mask, "acerto"].mean()
    n    = mask.sum()
    print(f"  {cls:<15}  {acc:.0%}  ({n} amostras)")

print(f"\nModelo salvo em: {MODELO_DIR}/")
