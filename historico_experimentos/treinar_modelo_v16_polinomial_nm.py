"""v16: O(n*m) passa para Polinomial e O(n log n) vira classe própria."""
import sys
import warnings
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import StratifiedKFold, cross_validate, train_test_split
from sklearn.metrics import classification_report, confusion_matrix

from imblearn.pipeline import Pipeline as ImbPipeline
from imblearn.over_sampling import SMOTE
from imblearn.combine import SMOTETomek

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV     = "features_asm_v2.csv"
TARGET  = "time_complexity"
N_FOLDS = 5
SEED    = 42

MAPA_6_OLD = {
    "O(1)"      : "Constante",
    "O(log n)"  : "Logaritmica",
    "O(sqrt(n))": "Logaritmica",
    "O(n)"      : "Linear",
    "O(n log n)": "O(n log n) / O(n*m)",
    "O(n*m)"    : "O(n log n) / O(n*m)",
    "O(n^2)"    : "Polinomial",
    "O(n^3)"    : "Polinomial",
    "O(2^n)"    : "Exponencial",
}

MAPA_6_NEW = {
    "O(1)"      : "Constante",
    "O(log n)"  : "Logaritmica",
    "O(sqrt(n))": "Logaritmica",
    "O(n)"      : "Linear",
    "O(n log n)": "O(n log n)",
    "O(n*m)"    : "Polinomial",
    "O(n^2)"    : "Polinomial",
    "O(n^3)"    : "Polinomial",
    "O(2^n)"    : "Exponencial",
}

df = pd.read_csv(CSV)
df = df[df[TARGET].notna() & (df[TARGET] != "")]
df['recursion_depth'] = df['has_recursion'] * df['backward_jumps']
df['y_old'] = df[TARGET].map(MAPA_6_OLD)
df['y_new'] = df[TARGET].map(MAPA_6_NEW)
df = df[df['y_old'].notna() & df['y_new'].notna()]

print(f"Amostras: {len(df)}")
print(f"\nDistribuição — mapeamento ANTIGO:\n{df['y_old'].value_counts().to_string()}")
print(f"\nDistribuição — mapeamento NOVO:\n{df['y_new'].value_counts().to_string()}\n")

# Conjunto de features combinado (v8 + novas), melhor resultado do v13
FEAT_COMBO = ['jne','add','num_labels','has_recursion','lea','cmp',
              'backward_jumps','movslq','conditional_backward','recursion_depth',
              'imul_count','sar_count','shr_count','cmov_count',
              'jg_jge_count','loop_nesting_depth','instr_per_label','instr_per_func']

X = df[FEAT_COMBO].values
y_old = df['y_old'].values
y_new = df['y_new'].values

min_count_new = df['y_new'].value_counts().min()
K_SMOTE = max(1, min(5, min_count_new - 2))
print(f"k_neighbors do SMOTE ajustado para a menor classe ({min_count_new} amostras): k={K_SMOTE}\n")

def modelos_base():
    return {
        "Random Forest": RandomForestClassifier(
            n_estimators=300, class_weight='balanced', max_depth=6,
            min_samples_leaf=2, random_state=SEED, n_jobs=-1),
        "Gradient Boosting": GradientBoostingClassifier(
            n_estimators=300, learning_rate=0.03, max_depth=3,
            min_samples_leaf=2, subsample=0.8, random_state=SEED),
        "SVM (RBF)": ImbPipeline([('sc', StandardScaler()),
            ('svm', SVC(kernel='rbf', C=10, gamma='scale',
                        class_weight='balanced', random_state=SEED))]),
        "Logistic Regression": ImbPipeline([('sc', StandardScaler()),
            ('lr', LogisticRegression(class_weight='balanced',
                                      max_iter=1000, C=1.0, random_state=SEED))]),
    }

def modelos_com_balanceador(balanceador_fn):
    """Injeta um passo de resampling (SMOTE/SMOTETomek) antes do classificador, dentro de um imblearn Pipeline — resample só acontece no .fit (treino),"""
    modelos = {}
    modelos["Random Forest"] = ImbPipeline([
        ('bal', balanceador_fn()),
        ('clf', RandomForestClassifier(n_estimators=300, max_depth=6,
                                        min_samples_leaf=2, random_state=SEED, n_jobs=-1))])
    modelos["Gradient Boosting"] = ImbPipeline([
        ('bal', balanceador_fn()),
        ('clf', GradientBoostingClassifier(n_estimators=300, learning_rate=0.03,
                                            max_depth=3, min_samples_leaf=2,
                                            subsample=0.8, random_state=SEED))])
    modelos["SVM (RBF)"] = ImbPipeline([
        ('sc', StandardScaler()),
        ('bal', balanceador_fn()),
        ('svm', SVC(kernel='rbf', C=10, gamma='scale', random_state=SEED))])
    modelos["Logistic Regression"] = ImbPipeline([
        ('sc', StandardScaler()),
        ('bal', balanceador_fn()),
        ('lr', LogisticRegression(max_iter=1000, C=1.0, random_state=SEED))])
    return modelos

def avaliar(titulo, modelos, X, y):
    skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)
    print(f"\n{'='*70}")
    print(f"  {titulo}")
    print(f"  {len(set(y))} classes | {len(y)} amostras")
    print(f"{'='*70}")
    resultados = {}
    for nome, clf in modelos.items():
        try:
            cv = cross_validate(clf, X, y, cv=skf, scoring='balanced_accuracy', n_jobs=-1,
                                 error_score='raise')
            s = cv['test_score']
            resultados[nome] = (s.mean(), s.std())
            print(f"  {nome:<22}: {s.mean():.3f} ± {s.std():.3f}  (folds: {[f'{v:.3f}' for v in s]})")
        except Exception as e:
            print(f"  {nome:<22}: ERRO — {e}")
    melhor = max(resultados, key=lambda n: resultados[n][0])
    print(f"\n  ► Melhor: {melhor} ({resultados[melhor][0]:.3f} ± {resultados[melhor][1]:.3f})")
    return resultados, melhor, resultados[melhor][0], resultados[melhor][1]

print("━"*70)
print("  0) REFERÊNCIA — mapeamento ANTIGO (O(n log n)+O(n*m) fundidos)")
print("━"*70)
_, _, ref_old, ref_old_dp = avaliar("Mapeamento antigo (6 classes)", modelos_base(), X, y_old)

print("\n" + "━"*70)
print("  1) NOVO MAPEAMENTO — sem balanceamento (O(n*m) -> Polinomial)")
print("━"*70)
_, melhor_semb, semb, semb_dp = avaliar("Novo mapeamento, sem balanceador", modelos_base(), X, y_new)

print("\n" + "━"*70)
print("  2) NOVO MAPEAMENTO — SMOTE")
print("━"*70)
_, melhor_smote, smote, smote_dp = avaliar(
    "Novo mapeamento + SMOTE",
    modelos_com_balanceador(lambda: SMOTE(k_neighbors=K_SMOTE, random_state=SEED)),
    X, y_new)

print("\n" + "━"*70)
print("  3) NOVO MAPEAMENTO — SMOTETomek (SMOTE + limpeza Tomek links)")
print("━"*70)
_, melhor_st, st, st_dp = avaliar(
    "Novo mapeamento + SMOTETomek",
    modelos_com_balanceador(lambda: SMOTETomek(
        smote=SMOTE(k_neighbors=K_SMOTE, random_state=SEED), random_state=SEED)),
    X, y_new)

print("\n" + "━"*70)
print("  RESUMO COMPARATIVO (Assembly, 6 classes)")
print("━"*70)
print(f"  {'Cenário':<45}{'Bal.Acc.':>12}{'DP':>8}{'Δ vs novo/sem-bal':>20}")
linhas = [
    ("0) Antigo (O(n log n)/O(n*m) fundidos)", ref_old, ref_old_dp, ref_old - semb),
    ("1) Novo (O(n*m) -> Polinomial), sem bal.", semb, semb_dp, 0.0),
    ("2) Novo + SMOTE", smote, smote_dp, smote - semb),
    ("3) Novo + SMOTETomek", st, st_dp, st - semb),
]
for nome, media, dp, delta in linhas:
    print(f"  {nome:<45}{media:>12.3f}{dp:>8.3f}{delta:>+20.3f}")

cenarios_novo = {"sem balanceador": (semb, modelos_base()),
                  "SMOTE": (smote, modelos_com_balanceador(lambda: SMOTE(k_neighbors=K_SMOTE, random_state=SEED))),
                  "SMOTETomek": (st, modelos_com_balanceador(lambda: SMOTETomek(
                      smote=SMOTE(k_neighbors=K_SMOTE, random_state=SEED), random_state=SEED)))}
melhor_cenario_nome = max(cenarios_novo, key=lambda k: cenarios_novo[k][0])
_, modelos_escolhidos = cenarios_novo[melhor_cenario_nome]

print(f"\n{'='*70}")
print(f"  Relatório detalhado — melhor cenário do novo mapeamento: {melhor_cenario_nome}")
print(f"{'='*70}")
X_tr, X_te, y_tr, y_te = train_test_split(X, y_new, test_size=0.2, stratify=y_new, random_state=SEED)
nome_modelo_final = {"sem balanceador": melhor_semb, "SMOTE": melhor_smote, "SMOTETomek": melhor_st}[melhor_cenario_nome]
clf = modelos_escolhidos[nome_modelo_final]
clf.fit(X_tr, y_tr)
y_pred = clf.predict(X_te)
print(f"  Modelo: {nome_modelo_final}\n")
print(classification_report(y_te, y_pred, zero_division=0))
labels_sorted = sorted(set(y_new))
cm = confusion_matrix(y_te, y_pred, labels=labels_sorted)
print("Matriz de confusão:")
print(f"{'':>15}", end="")
for l in labels_sorted:
    print(f"{l[:12]:>14}", end="")
print()
for i, l in enumerate(labels_sorted):
    print(f"{l:>15}", end="")
    for j in range(len(labels_sorted)):
        print(f"{cm[i][j]:>14}", end="")
    print()
