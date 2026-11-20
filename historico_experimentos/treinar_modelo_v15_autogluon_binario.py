"""v15: AutoGluon nas formulações binária e de 3 classes."""
import sys
import warnings
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import balanced_accuracy_score, accuracy_score

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV    = "features_asm_v2.csv"
TARGET = "time_complexity"
SEED   = 42

MAPA_6 = {
    "O(1)": "Constante", "O(log n)": "Logaritmica", "O(sqrt(n))": "Logaritmica",
    "O(n)": "Linear", "O(n log n)": "Superlinear", "O(n*m)": "Superlinear",
    "O(n^2)": "Polinomial", "O(n^3)": "Polinomial", "O(2^n)": "Exponencial",
}
MAPA_BIN = {
    "O(1)": "Eficiente", "O(log n)": "Eficiente", "O(sqrt(n))": "Eficiente",
    "O(n)": "Eficiente", "O(n log n)": "Eficiente",
    "O(n*m)": "Ineficiente", "O(n^2)": "Ineficiente", "O(n^3)": "Ineficiente",
    "O(2^n)": "Ineficiente",
}

df = pd.read_csv(CSV)
df = df[df[TARGET].notna() & (df[TARGET] != "")]
df['recursion_depth'] = df['has_recursion'] * df['backward_jumps']
df['y6']   = df[TARGET].map(MAPA_6)
df['ybin'] = df[TARGET].map(MAPA_BIN)
df = df[df['y6'].notna() & df['ybin'].notna()]
for col in ['y6']:
    validas = df[col].value_counts()
    df = df[df[col].isin(validas[validas >= 3].index)]

FEAT_V8  = ['jne', 'add', 'num_labels', 'has_recursion', 'lea', 'cmp',
            'backward_jumps', 'movslq', 'conditional_backward']
FEAT_V11 = FEAT_V8 + ['recursion_depth']
FEAT_NOVAS = ['imul_count', 'sar_count', 'shr_count', 'cmov_count',
              'jg_jge_count', 'loop_nesting_depth', 'instr_per_label', 'instr_per_func']
FEAT_V13 = FEAT_V11 + FEAT_NOVAS
FEAT_V8_7 = ['add', 'jne', 'recursion_depth', 'num_labels',
             'conditional_backward', 'has_recursion', 'backward_jumps']

CENARIOS = [
    ("A) Binario, 10 feat (v11)", FEAT_V11, 'ybin'),
    ("B) Binario, 18 feat (v13 combinado)", FEAT_V13, 'ybin'),
    ("C) 6 classes, 7 feat (v8 forward selection)", FEAT_V8_7, 'y6'),
]

from autogluon.tabular import TabularPredictor

resumo = []
for nome, feats, y_col in CENARIOS:
    print(f"\n{'='*70}\n  {nome}\n{'='*70}")
    sub = df[feats + [y_col]].copy()
    tr, te = train_test_split(sub, test_size=0.2, stratify=sub[y_col], random_state=SEED)
    predictor = TabularPredictor(label=y_col, eval_metric='balanced_accuracy',
                                  verbosity=0, path=f"AutogluonModels/v15_{y_col}_{len(feats)}feat")
    predictor.fit(tr, time_limit=120, presets='best_quality')
    pred = predictor.predict(te.drop(columns=[y_col]))
    bal_acc = balanced_accuracy_score(te[y_col], pred)
    acc = accuracy_score(te[y_col], pred)
    melhor_modelo = predictor.leaderboard(te, silent=True).iloc[0]['model']
    print(f"  balanced_accuracy (holdout 80/20): {bal_acc:.3f}")
    print(f"  accuracy (holdout 80/20)         : {acc:.3f}")
    print(f"  melhor modelo AutoGluon           : {melhor_modelo}")
    resumo.append((nome, len(feats), bal_acc, acc, melhor_modelo))

print(f"\n{'='*70}\n  RESUMO — AutoGluon em Assembly (holdout 80/20, best_quality, 120s)\n{'='*70}")
for nome, n_feat, bal_acc, acc, modelo in resumo:
    print(f"  {nome:<45}: bal_acc={bal_acc:.3f}  acc={acc:.3f}  ({modelo})")
