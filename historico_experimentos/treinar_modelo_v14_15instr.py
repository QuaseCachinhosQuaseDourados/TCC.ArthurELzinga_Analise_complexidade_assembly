"""v14: só as 15 contagens de instrução originais."""
import sys
import warnings
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import StratifiedKFold, cross_validate

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV     = "features_asm_estrutural.csv"
TARGET  = "time_complexity"
N_FOLDS = 5
SEED    = 42

FEAT_15 = ['mov', 'call', 'lea', 'add', 'push', 'pop', 'cmp', 'sub', 'ret',
           'jmp', 'je', 'test', 'movslq', 'jne', 'jle']

MAPA_6 = {
    "O(1)": "Constante", "O(log n)": "Logaritmica", "O(sqrt(n))": "Logaritmica",
    "O(n)": "Linear", "O(n log n)": "Superlinear", "O(n*m)": "Superlinear",
    "O(n^2)": "Polinomial", "O(n^3)": "Polinomial", "O(2^n)": "Exponencial",
}
MAPA_5_SUBLINEAR = {
    "O(1)": "Sublinear", "O(log n)": "Sublinear", "O(sqrt(n))": "Sublinear",
    "O(n)": "Linear", "O(n log n)": "Superlinear", "O(n*m)": "Superlinear",
    "O(n^2)": "Polinomial", "O(n^3)": "Polinomial", "O(2^n)": "Exponencial",
}
MAPA_3 = {
    "O(1)": "Sublinear", "O(log n)": "Sublinear", "O(sqrt(n))": "Sublinear",
    "O(n)": "Linear", "O(n log n)": "Linear",
    "O(n*m)": "Custoso", "O(n^2)": "Custoso", "O(n^3)": "Custoso", "O(2^n)": "Custoso",
}
MAPA_BIN = {
    "O(1)": "Eficiente", "O(log n)": "Eficiente", "O(sqrt(n))": "Eficiente",
    "O(n)": "Eficiente", "O(n log n)": "Eficiente",
    "O(n*m)": "Ineficiente", "O(n^2)": "Ineficiente", "O(n^3)": "Ineficiente",
    "O(2^n)": "Ineficiente",
}

df = pd.read_csv(CSV)
df = df[df[TARGET].notna() & (df[TARGET] != "")]
df['y6']  = df[TARGET].map(MAPA_6)
df['y5']  = df[TARGET].map(MAPA_5_SUBLINEAR)
df['y3']  = df[TARGET].map(MAPA_3)
df['ybin']= df[TARGET].map(MAPA_BIN)
df = df[df['y6'].notna() & df['y5'].notna() & df['y3'].notna() & df['ybin'].notna()]

print(f"Amostras: {len(df)}  |  Features: {len(FEAT_15)} (contagens de instrucao)")

def svm():
    return Pipeline([('sc', StandardScaler()),
                     ('svm', SVC(kernel='rbf', C=10, gamma='scale',
                                 class_weight='balanced', probability=True,
                                 random_state=SEED))])
def rf():
    return RandomForestClassifier(n_estimators=300, class_weight='balanced',
                                   max_depth=6, min_samples_leaf=2,
                                   random_state=SEED, n_jobs=-1)
def lr():
    return Pipeline([('sc', StandardScaler()),
                     ('lr', LogisticRegression(class_weight='balanced',
                                               max_iter=1000, C=1.0,
                                               random_state=SEED))])
def gb():
    return GradientBoostingClassifier(n_estimators=300, learning_rate=0.03,
                                      max_depth=3, min_samples_leaf=2,
                                      subsample=0.8, random_state=SEED)

MODELOS = {'Random Forest': rf, 'SVM (RBF)': svm,
           'Gradient Boosting': gb, 'Logistic Regression': lr}

def rodar(nome, y_col, min_por_classe=3):
    sub = df.copy()
    contagem = sub[y_col].value_counts()
    sub = sub[sub[y_col].isin(contagem[contagem >= min_por_classe].index)]
    X = sub[FEAT_15].values
    y = sub[y_col].values
    n_classes = len(set(y))

    print(f"\n{'='*70}\n  {nome}\n{'='*70}")
    print(f"  Amostras: {len(sub)}  |  Classes ({n_classes}): {sorted(set(y))}")

    skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)
    resultados = {}
    for m_nome, fn in MODELOS.items():
        cv = cross_validate(fn(), X, y, cv=skf, scoring='balanced_accuracy', n_jobs=-1)
        s = cv['test_score']
        resultados[m_nome] = (s.mean(), s.std())
        print(f"    {m_nome:<22}: {s.mean():.3f} ± {s.std():.3f}")

    melhor = max(resultados, key=lambda n: resultados[n][0])
    print(f"  ► Melhor: {melhor} = {resultados[melhor][0]:.3f} ± {resultados[melhor][1]:.3f}")
    return melhor, resultados[melhor][0], resultados[melhor][1]

resumo = []
resumo.append(("6 classes",  *rodar("A) 6 classes", 'y6')))
resumo.append(("5 classes (Sublinear)", *rodar("B) 5 classes — Sublinear = Const+Log", 'y5')))
resumo.append(("3 classes (Sublinear/Linear/Custoso)", *rodar("C) 3 classes praticas", 'y3')))
resumo.append(("Binario (Efic/Inefic)", *rodar("D) Binario Eficiente/Ineficiente", 'ybin')))

print(f"\n{'='*70}\n  RESUMO — 15 features (contagens de instrucao)\n{'='*70}")
for nome, modelo, media, dp in resumo:
    print(f"  {nome:<38}: {media:.3f} ± {dp:.3f}  ({modelo})")
