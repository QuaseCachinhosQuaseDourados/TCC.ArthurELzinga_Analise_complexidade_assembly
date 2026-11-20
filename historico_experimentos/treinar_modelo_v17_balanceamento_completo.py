"""v17: testes de balanceamento com o mapeamento do v16."""
import sys
import warnings
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import StratifiedKFold, cross_validate

from imblearn.pipeline import Pipeline as ImbPipeline
from imblearn.over_sampling import RandomOverSampler, SMOTE, BorderlineSMOTE, ADASYN
from imblearn.under_sampling import RandomUnderSampler, TomekLinks
from imblearn.combine import SMOTETomek
from imblearn.ensemble import (BalancedRandomForestClassifier,
                                BalancedBaggingClassifier, EasyEnsembleClassifier)
from sklearn.tree import DecisionTreeClassifier

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV     = "features_asm_v2.csv"
TARGET  = "time_complexity"
N_FOLDS = 5
SEED    = 42

MAPA_6_NEW = {
    "O(1)": "Constante", "O(log n)": "Logaritmica", "O(sqrt(n))": "Logaritmica",
    "O(n)": "Linear", "O(n log n)": "O(n log n)", "O(n*m)": "Polinomial",
    "O(n^2)": "Polinomial", "O(n^3)": "Polinomial", "O(2^n)": "Exponencial",
}

df = pd.read_csv(CSV)
df = df[df[TARGET].notna() & (df[TARGET] != "")]
df['recursion_depth'] = df['has_recursion'] * df['backward_jumps']
df['y'] = df[TARGET].map(MAPA_6_NEW)
df = df[df['y'].notna()]

FEAT_COMBO = ['jne','add','num_labels','has_recursion','lea','cmp',
              'backward_jumps','movslq','conditional_backward','recursion_depth',
              'imul_count','sar_count','shr_count','cmov_count',
              'jg_jge_count','loop_nesting_depth','instr_per_label','instr_per_func']

X = df[FEAT_COMBO].values
y = df['y'].values
print(f"Amostras: {len(df)} | Distribuição:\n{df['y'].value_counts().to_string()}\n")

min_count = df['y'].value_counts().min()
K = max(1, min(5, min_count - 2))
print(f"k_neighbors (SMOTE/Borderline/ADASYN) ajustado para menor classe ({min_count}): k={K}\n")

def modelos_base():
    return {
        "Random Forest": RandomForestClassifier(n_estimators=300, class_weight='balanced',
            max_depth=6, min_samples_leaf=2, random_state=SEED, n_jobs=-1),
        "Gradient Boosting": GradientBoostingClassifier(n_estimators=300, learning_rate=0.03,
            max_depth=3, min_samples_leaf=2, subsample=0.8, random_state=SEED),
        "SVM (RBF)": ImbPipeline([('sc', StandardScaler()),
            ('svm', SVC(kernel='rbf', C=10, gamma='scale', class_weight='balanced', random_state=SEED))]),
        "Logistic Regression": ImbPipeline([('sc', StandardScaler()),
            ('lr', LogisticRegression(class_weight='balanced', max_iter=1000, C=1.0, random_state=SEED))]),
    }

def modelos_com_balanceador(balanceador_fn):
    return {
        "Random Forest": ImbPipeline([('bal', balanceador_fn()),
            ('clf', RandomForestClassifier(n_estimators=300, max_depth=6, min_samples_leaf=2,
                                            random_state=SEED, n_jobs=-1))]),
        "Gradient Boosting": ImbPipeline([('bal', balanceador_fn()),
            ('clf', GradientBoostingClassifier(n_estimators=300, learning_rate=0.03, max_depth=3,
                                                min_samples_leaf=2, subsample=0.8, random_state=SEED))]),
        "SVM (RBF)": ImbPipeline([('sc', StandardScaler()), ('bal', balanceador_fn()),
            ('svm', SVC(kernel='rbf', C=10, gamma='scale', random_state=SEED))]),
        "Logistic Regression": ImbPipeline([('sc', StandardScaler()), ('bal', balanceador_fn()),
            ('lr', LogisticRegression(max_iter=1000, C=1.0, random_state=SEED))]),
    }

def avaliar(titulo, modelos, X, y):
    skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)
    print(f"\n{'='*68}\n  {titulo}\n{'='*68}")
    resultados = {}
    for nome, clf in modelos.items():
        try:
            cv = cross_validate(clf, X, y, cv=skf, scoring='balanced_accuracy',
                                 n_jobs=-1, error_score='raise')
            s = cv['test_score']
            resultados[nome] = (s.mean(), s.std())
            print(f"  {nome:<24}: {s.mean():.3f} ± {s.std():.3f}")
        except Exception as e:
            print(f"  {nome:<24}: ERRO — {e}")
    if not resultados:
        return None, None, None
    melhor = max(resultados, key=lambda n: resultados[n][0])
    print(f"  ► Melhor: {melhor} ({resultados[melhor][0]:.3f})")
    return melhor, resultados[melhor][0], resultados[melhor][1]

resumo = []

_, base, base_dp = avaliar("0) SEM BALANCEADOR (referência, novo mapeamento)", modelos_base(), X, y)
resumo.append(("0) Sem balanceador", base, base_dp))

_, ros, ros_dp = avaliar("1) RandomOverSampler",
    modelos_com_balanceador(lambda: RandomOverSampler(random_state=SEED)), X, y)
resumo.append(("1) RandomOverSampler", ros, ros_dp))

_, smote, smote_dp = avaliar("2) SMOTE",
    modelos_com_balanceador(lambda: SMOTE(k_neighbors=K, random_state=SEED)), X, y)
resumo.append(("2) SMOTE", smote, smote_dp))

_, bsmote, bsmote_dp = avaliar("3) BorderlineSMOTE",
    modelos_com_balanceador(lambda: BorderlineSMOTE(k_neighbors=K, random_state=SEED)), X, y)
resumo.append(("3) BorderlineSMOTE", bsmote, bsmote_dp))

_, adasyn, adasyn_dp = avaliar("4) ADASYN",
    modelos_com_balanceador(lambda: ADASYN(n_neighbors=K, random_state=SEED)), X, y)
resumo.append(("4) ADASYN", adasyn, adasyn_dp))

_, rus, rus_dp = avaliar("5) RandomUnderSampler (reduz Linear)",
    modelos_com_balanceador(lambda: RandomUnderSampler(random_state=SEED)), X, y)
resumo.append(("5) RandomUnderSampler", rus, rus_dp))

_, tomek, tomek_dp = avaliar("6) TomekLinks (só limpeza, sem reduzir volume-alvo)",
    modelos_com_balanceador(lambda: TomekLinks()), X, y)
resumo.append(("6) TomekLinks", tomek, tomek_dp))

_, st, st_dp = avaliar("7) SMOTETomek",
    modelos_com_balanceador(lambda: SMOTETomek(smote=SMOTE(k_neighbors=K, random_state=SEED),
                                                random_state=SEED)), X, y)
resumo.append(("7) SMOTETomek", st, st_dp))

skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)
print(f"\n{'='*68}\n  8-10) ENSEMBLES NATIVOS PARA DADO DESBALANCEADO\n{'='*68}")
ensembles = {
    "8) BalancedRandomForest": BalancedRandomForestClassifier(
        n_estimators=300, max_depth=6, min_samples_leaf=2, random_state=SEED,
        n_jobs=-1, sampling_strategy='all', replacement=True),
    "9) BalancedBagging (tree)": BalancedBaggingClassifier(
        estimator=DecisionTreeClassifier(max_depth=6, random_state=SEED),
        n_estimators=100, random_state=SEED, n_jobs=-1),
    "10) EasyEnsemble (AdaBoost)": EasyEnsembleClassifier(
        n_estimators=50, random_state=SEED, n_jobs=-1),
}
for nome, clf in ensembles.items():
    try:
        cv = cross_validate(clf, X, y, cv=skf, scoring='balanced_accuracy',
                             n_jobs=-1, error_score='raise')
        s = cv['test_score']
        print(f"  {nome:<28}: {s.mean():.3f} ± {s.std():.3f}")
        resumo.append((nome, s.mean(), s.std()))
    except Exception as e:
        print(f"  {nome:<28}: ERRO — {e}")

print(f"\n{'='*68}\n  RESUMO COMPARATIVO (Assembly, 6 classes, novo mapeamento)\n{'='*68}")
print(f"  {'Estratégia':<32}{'Bal.Acc.':>12}{'DP':>8}{'Δ vs sem-bal.':>16}")
for nome, media, dp in resumo:
    if media is None:
        continue
    delta = media - base
    print(f"  {nome:<32}{media:>12.3f}{dp:>8.3f}{delta:>+16.3f}")
