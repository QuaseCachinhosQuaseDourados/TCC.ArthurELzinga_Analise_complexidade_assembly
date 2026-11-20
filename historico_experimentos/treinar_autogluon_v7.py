"""AutoGluon com as 28 features estruturais do assembly."""
import sys
import warnings
import pandas as pd
import numpy as np
from sklearn.model_selection import StratifiedKFold, train_test_split
from sklearn.metrics import balanced_accuracy_score, classification_report
from autogluon.tabular import TabularPredictor

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV        = "features_asm_estrutural.csv"
TARGET     = "time_complexity"
MODELO_DIR = "modelo_autogluon_v7"
N_FOLDS    = 5
SEED       = 42
TEMPO      = 300

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
print(f"\nDistribuição:\n{df['classe'].value_counts().to_string()}")

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

print(f"\n{'='*65}")
print(f"Stratified {N_FOLDS}-Fold CV com AutoGluon (28 features)")
print(f"{'='*65}")

df_ag = df[FEAT_TODAS + ['classe']].copy()
skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)

scores_cv = []
for fold_idx, (train_idx, test_idx) in enumerate(skf.split(df_ag, df_ag['classe'])):
    df_train = df_ag.iloc[train_idx]
    df_test  = df_ag.iloc[test_idx]

    predictor = TabularPredictor(
        label='classe',
        eval_metric='balanced_accuracy',
        path=f"{MODELO_DIR}_fold{fold_idx}",
        verbosity=0,
    ).fit(
        train_data=df_train,
        time_limit=TEMPO,
        presets="best_quality",
        num_bag_folds=5,
        num_stack_levels=1,
    )

    y_pred = predictor.predict(df_test.drop(columns=['classe']))
    ba = balanced_accuracy_score(df_test['classe'], y_pred)
    scores_cv.append(ba)
    print(f"  Fold {fold_idx+1}: balanced_accuracy = {ba:.3f}")

scores_cv = np.array(scores_cv)
print(f"\n  Média: {scores_cv.mean():.3f} ± {scores_cv.std():.3f}")

print(f"\n{'='*65}")
print("AutoGluon — Treino final (split 80/20)")
print(f"{'='*65}")

df_treino, df_teste = train_test_split(
    df_ag, test_size=0.2, random_state=SEED, stratify=df_ag['classe']
)

predictor_final = TabularPredictor(
    label='classe',
    eval_metric='balanced_accuracy',
    path=MODELO_DIR,
    verbosity=1,
).fit(
    train_data=df_treino,
    time_limit=TEMPO,
    presets="best_quality",
    num_bag_folds=5,
    num_stack_levels=1,
)

resultado = predictor_final.evaluate(df_teste, silent=True)
y_pred_final = predictor_final.predict(df_teste.drop(columns=['classe']))
acc = (y_pred_final.values == df_teste['classe'].values).mean()

print(f"\nBalanced accuracy (teste): {resultado.get('balanced_accuracy', 0):.3f}")
print(f"Acurácia geral (teste):   {acc:.1%}")

# Leaderboard
print("\nLeaderboard (top 10):")
lb = predictor_final.leaderboard(df_teste, silent=True)
print(lb[["model", "score_test", "score_val", "fit_time"]].head(10).to_string())

# Relatório
print(f"\nRelatório de classificação:")
print(classification_report(
    df_teste['classe'], y_pred_final, zero_division=0
))

# Importância
print("Importância das features:")
imp = predictor_final.feature_importance(df_teste, silent=True)
print(imp[["importance", "stddev", "p_value"]].to_string())

print(f"\n{'='*65}")
print("COMPARATIVO FINAL")
print(f"{'='*65}")
print(f"  v4 (15 feat, sklearn)    : ~38.0% bal.acc (5-Fold CV)")
print(f"  v6 (15 feat, sklearn)    : ~44.8% bal.acc (5-Fold CV, 353 amostras c/ ruído)")
print(f"  v7 sklearn (28 feat, SVM): ~52.0% bal.acc (5-Fold CV, 189 amostras)")
print(f"  v7 AutoGluon (28 feat)   : ~{scores_cv.mean():.1%} bal.acc (5-Fold CV, 189 amostras)")
