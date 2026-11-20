"""v3: avaliação com validação cruzada e classes consolidadas."""

import pandas as pd
import numpy as np
from collections import Counter

from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import StratifiedKFold, cross_validate, GridSearchCV
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import balanced_accuracy_score, classification_report
from autogluon.tabular import TabularPredictor
import sys, warnings
sys.stdout.reconfigure(encoding="utf-8")
warnings.filterwarnings("ignore")

CSV_PATH   = "instrucoes_por_arquivo.csv"
TARGET     = "time_complexity"
MODELO_DIR = "modelo_autogluon_v3"
N_FOLDS    = 5

MAPA_CLASSES = {
    "O(1)"       : "Constante",
    "O(log n)"   : "Logaritmica",
    "O(n)"       : "Linear",
    "O(n log n)" : "Superlinear",
    "O(n*m)"     : "Superlinear",
    "O(n^2)"     : "Polinomial",
    "O(n^3)"     : "Polinomial",
    "O(2^n)"     : "Exponencial",
}

df = pd.read_csv(CSV_PATH)
df = df[df[TARGET].notna() & (df[TARGET] != "")].copy()

# Aplica consolidação
df["classe"] = df[TARGET].map(MAPA_CLASSES)
df = df[df["classe"].notna()].copy()

print("Distribuição original → consolidada:")
for orig, cons in sorted(MAPA_CLASSES.items()):
    n = (df[TARGET] == orig).sum()
    if n > 0:
        print(f"  {orig:<15} → {cons:<15} ({n} amostras)")

print(f"\nDistribuição das classes consolidadas:")
print(df["classe"].value_counts().to_string())

# Recarrega assembly para extrair TODAS as instruções
import os, re

ASM_DIR = "codigos_asm"
IGNORAR = {'.', '#', ';'}
SUFIXO_TAMANHO = re.compile(r'^(.+?)[bwlq]$')
BASE_COM_SUFIXO = {
    'mov','add','sub','and','or','xor','not','neg','cmp','test',
    'imul','idiv','div','mul','push','pop','lea','inc','dec',
    'sar','shr','shl','sal','ror','rol','movs','movz','set',
}

def normalizar(mnem):
    mnem = mnem.lower()
    m = SUFIXO_TAMANHO.match(mnem)
    if m and m.group(1) in BASE_COM_SUFIXO:
        return m.group(1)
    return mnem

def extrair_instrucoes(caminho):
    instrs = []
    with open(caminho, encoding="utf-8", errors="replace") as f:
        for linha in f:
            s = linha.strip()
            if not s or s[0] in IGNORAR or s.endswith(':'):
                continue
            partes = s.split()
            if partes:
                mn = normalizar(partes[0])
                if not mn.startswith('.') and not mn.startswith('#'):
                    instrs.append(mn)
    return instrs

# Conta frequência global de cada instrução
freq_global = Counter()
contagens_por_arquivo = {}
arquivos_asm = [f for f in os.listdir(ASM_DIR) if f.endswith('.s')]

for nome in arquivos_asm:
    instrs = extrair_instrucoes(os.path.join(ASM_DIR, nome))
    cnt = Counter(instrs)
    contagens_por_arquivo[nome] = cnt
    freq_global.update(cnt.keys())

# Mantém instruções que aparecem em ≥ 5 arquivos
features_instrucoes = [
    instr for instr, n_arquivos in freq_global.items()
    if n_arquivos >= 5
]
features_instrucoes.sort()
print(f"\nFeatures (instruções em ≥ 5 arquivos): {len(features_instrucoes)}")

# Constrói DataFrame com todas as features
arquivo_col = df["arquivo"].str.replace(".c", ".s", regex=False)
rows = []
for arq_s in arquivo_col:
    cnt = contagens_por_arquivo.get(arq_s, Counter())
    rows.append({f: cnt.get(f, 0) for f in features_instrucoes})

df_features = pd.DataFrame(rows, index=df.index)
df_features["classe"] = df["classe"].values
df_features = df_features.dropna(subset=["classe"])

X = df_features[features_instrucoes]
y = df_features["classe"]

print(f"Shape final do dataset: {X.shape}")

print("\n" + "=" * 65)
print(f"AVALIAÇÃO VIA STRATIFIED {N_FOLDS}-FOLD CROSS-VALIDATION")
print("=" * 65)

skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=42)

modelos = {
    "Random Forest": RandomForestClassifier(
        n_estimators=300, class_weight="balanced", random_state=42, n_jobs=-1
    ),
    "Gradient Boosting": GradientBoostingClassifier(
        n_estimators=200, learning_rate=0.05, max_depth=4, random_state=42
    ),
    "KNN (k=5)": KNeighborsClassifier(
        n_neighbors=5, weights="distance", metric="manhattan"
    ),
}

resultados = {}
for nome_modelo, clf in modelos.items():
    scores = cross_validate(
        clf, X, y,
        cv=skf,
        scoring="balanced_accuracy",
        return_train_score=True,
        n_jobs=-1,
    )
    media  = scores["test_score"].mean()
    desvio = scores["test_score"].std()
    resultados[nome_modelo] = (media, desvio, scores["test_score"])
    print(f"\n{nome_modelo}:")
    print(f"  Balanced accuracy: {media:.2%} ± {desvio:.2%}")
    print(f"  Por fold: {[f'{s:.2%}' for s in scores['test_score']]}")

melhor_nome = max(resultados, key=lambda k: resultados[k][0])
print(f"\n→ Melhor modelo: {melhor_nome} ({resultados[melhor_nome][0]:.2%})")

print("\n" + "=" * 65)
print(f"RELATÓRIO POR CLASSE — {melhor_nome} (último fold)")
print("=" * 65)

clf_melhor = list(modelos.values())[list(modelos.keys()).index(melhor_nome)]
folds_list = list(skf.split(X, y))
train_idx, test_idx = folds_list[-1]
clf_melhor.fit(X.iloc[train_idx], y.iloc[train_idx])
y_pred = clf_melhor.predict(X.iloc[test_idx])
print(classification_report(y.iloc[test_idx], y_pred, zero_division=0))

print("\n" + "=" * 65)
print("AUTOGLUON COM CLASSES CONSOLIDADAS (treino completo)")
print("=" * 65)

from sklearn.model_selection import train_test_split

df_ag = X.copy()
df_ag["classe"] = y.values

df_treino, df_teste = train_test_split(
    df_ag, test_size=0.2, random_state=42, stratify=df_ag["classe"]
)

predictor = TabularPredictor(
    label="classe",
    eval_metric="balanced_accuracy",
    path=MODELO_DIR,
    verbosity=1,
).fit(
    train_data=df_treino,
    time_limit=300,
    presets="best_quality",
    num_bag_folds=5,
    num_stack_levels=1,
)

resultado_ag = predictor.evaluate(df_teste, silent=True)
preds = predictor.predict(df_teste.drop(columns=["classe"]))
acuracia = (preds.values == df_teste["classe"].values).mean()

print(f"AutoGluon — Balanced accuracy: {resultado_ag.get('balanced_accuracy', 'N/A'):.2%}")
print(f"AutoGluon — Acurácia geral   : {acuracia:.2%}")

print("\nLeaderboard:")
lb = predictor.leaderboard(df_teste, silent=True)
print(lb[["model", "score_test", "score_val"]].head(8).to_string())

print("\nImportância das features (top 15):")
imp = predictor.feature_importance(df_teste, silent=True)
print(imp.head(15).to_string())
