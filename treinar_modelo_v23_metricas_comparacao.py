"""Mesmo protocolo do v21 com as métricas usadas pelos trabalhos de referência."""
import sys, warnings, time
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import RepeatedStratifiedKFold, cross_validate
from sklearn.metrics import make_scorer, cohen_kappa_score
from imblearn.pipeline import Pipeline as ImbPipeline
from imblearn.over_sampling import SMOTE
import lightgbm as lgb
from catboost import CatBoostClassifier

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")
SEED = 42
N_REPEATS = 20

MAPA_6 = {"O(1)":"Constante","O(log n)":"Logaritmica","O(sqrt(n))":"Logaritmica","O(n)":"Linear",
          "O(n log n)":"O(n log n)","O(n*m)":"Polinomial",
          "O(n^2)":"Polinomial","O(n^3)":"Polinomial","O(2^n)":"Exponencial"}
MAPA_3 = {"O(1)":"Sublinear","O(log n)":"Sublinear","O(sqrt(n))":"Sublinear",
          "O(n)":"Linear","O(n log n)":"Linear",
          "O(n*m)":"Custoso","O(n^2)":"Custoso","O(n^3)":"Custoso","O(2^n)":"Custoso"}
MAPA_BIN = {"O(1)":"Eficiente","O(log n)":"Eficiente","O(sqrt(n))":"Eficiente",
            "O(n)":"Eficiente","O(n log n)":"Eficiente",
            "O(n*m)":"Ineficiente","O(n^2)":"Ineficiente","O(n^3)":"Ineficiente","O(2^n)":"Ineficiente"}

FEAT_ASM = ['jne','add','num_labels','has_recursion','lea','cmp','backward_jumps','movslq',
            'conditional_backward','recursion_depth','imul_count','sar_count','shr_count',
            'cmov_count','jg_jge_count','loop_nesting_depth','instr_per_label','instr_per_func']
FEAT_C = ['total_lines','num_functions','loop_count','if_count','max_loop_depth','nested_loop_count',
          'has_recursion','recursive_calls','double_recursion','branch_ratio','loop_ratio',
          'malloc_count','ptr_ops','idx_array','op_incr']


def clf_base(nome, seed, cw=True):
    b = 'balanced' if cw else None
    if nome == "Random Forest":
        return RandomForestClassifier(n_estimators=300, class_weight=b, max_depth=6, min_samples_leaf=2, random_state=seed, n_jobs=1)
    if nome == "Gradient Boosting":
        return GradientBoostingClassifier(n_estimators=300, learning_rate=0.03, max_depth=3, min_samples_leaf=2, subsample=0.8, random_state=seed)
    if nome == "SVM (RBF)":
        return SVC(kernel='rbf', C=10, gamma='scale', class_weight=b, random_state=seed)
    if nome == "Logistic Regression":
        return LogisticRegression(class_weight=b, max_iter=1000, C=1.0, random_state=seed)
    if nome == "LightGBM":
        return lgb.LGBMClassifier(n_estimators=300, learning_rate=0.05, max_depth=4, num_leaves=15, class_weight=b, random_state=seed, verbose=-1, n_jobs=1)
    if nome == "CatBoost":
        return CatBoostClassifier(iterations=300, learning_rate=0.05, depth=4, auto_class_weights=('Balanced' if cw else None), random_seed=seed, verbose=0, thread_count=1)

MODELOS = ["Random Forest", "Gradient Boosting", "SVM (RBF)", "Logistic Regression", "LightGBM", "CatBoost"]
ESCALA = {"SVM (RBF)", "Logistic Regression"}


def montar(nome, seed, smote_k=None):
    """Sem SMOTE: class_weight='balanced' (padrao do projeto)."""
    passos = []
    if nome in ESCALA:
        passos.append(('sc', StandardScaler()))
    if smote_k is not None:
        passos.append(('bal', SMOTE(k_neighbors=smote_k, random_state=seed)))
    passos.append(('clf', clf_base(nome, seed, cw=(smote_k is None))))
    return ImbPipeline(passos)


def carregar(csv, mapa, feats):
    df = pd.read_csv(csv)
    df = df[df['time_complexity'].notna() & (df['time_complexity'] != "")]
    if 'recursion_depth' in feats:
        df['recursion_depth'] = df['has_recursion'] * df['backward_jumps']
    df['y'] = df['time_complexity'].map(mapa)
    df = df[df['y'].notna()]
    vc = df['y'].value_counts()
    df = df[df['y'].isin(vc[vc >= 3].index)]
    return df[feats].values, df['y'].values, df['y'].value_counts()


linhas = []
t_total = time.time()
for dominio, csv, feats in [("Assembly", "dados/features_asm_v2.csv", FEAT_ASM),
                            ("C", "dados/features_c_estrutural.csv", FEAT_C)]:
    for form, mapa in [("6 classes", MAPA_6), ("3 classes", MAPA_3), ("Binario", MAPA_BIN)]:
        X, y, vc = carregar(csv, mapa, feats)
        K = max(1, min(5, vc.min() - 2))
        cv = RepeatedStratifiedKFold(n_splits=5, n_repeats=N_REPEATS, random_state=SEED)
        print(f"\n{'='*78}\n  {dominio} | {form} | {len(y)} amostras | {len(feats)} features | 5x{N_REPEATS}\n"
              f"  classes: {dict(vc)}\n{'='*78}", flush=True)
        for bal in ["sem", "SMOTE"]:
            for nome in MODELOS:
                t0 = time.time()
                pipe = montar(nome, SEED, None if bal == "sem" else K)
                sc = {'balanced_accuracy': 'balanced_accuracy', 'f1_macro': 'f1_macro', 'accuracy': 'accuracy',
                      'kappa': make_scorer(cohen_kappa_score)}
                if form == "Binario":
                    sc['roc_auc'] = 'roc_auc'
                r = cross_validate(pipe, X, y, cv=cv, scoring=sc, n_jobs=-1)
                ba, f1, acc, kp = r['test_balanced_accuracy'], r['test_f1_macro'], r['test_accuracy'], r['test_kappa']
                auc = r.get('test_roc_auc', np.array([np.nan]))
                linhas.append(dict(dominio=dominio, formulacao=form, balanceamento=bal, modelo=nome,
                                   n=len(y), bal_acc=ba.mean(), bal_acc_std=ba.std(),
                                   f1_macro=f1.mean(), f1_std=f1.std(), acc=acc.mean(), acc_std=acc.std(),
                                   kappa=kp.mean(), kappa_std=kp.std(), auc=auc.mean(), auc_std=auc.std()))
                print(f"  [{bal:<5}] {nome:<20}: bal.acc {ba.mean():.3f} | acc {acc.mean():.3f} | "
                      f"kappa {kp.mean():.3f} | F1 {f1.mean():.3f} | AUC {auc.mean():.3f}  ({time.time()-t0:.0f}s)", flush=True)

res = pd.DataFrame(linhas)
res.to_csv("resultados/resultados_v23_metricas.csv", index=False)

print(f"\n{'='*78}\n  RESUMO - melhor modelo por cenario (bal.acc, 5x{N_REPEATS}=100 avaliacoes)\n{'='*78}")
idx = res.groupby(['dominio', 'formulacao', 'balanceamento'])['bal_acc'].idxmax()
best = res.loc[idx].sort_values(['dominio', 'formulacao', 'balanceamento'])
for _, r in best.iterrows():
    print(f"  {r.dominio:<9}{r.formulacao:<11}{r.balanceamento:<7}{r.modelo:<20}bal {r.bal_acc:.3f} | acc {r.acc:.3f} | "
          f"kappa {r.kappa:.3f} | F1 {r.f1_macro:.3f} | AUC {r.auc:.3f}")
v21 = pd.read_csv("resultados/resultados_v21_consolidacao.csv")
m = res.merge(v21, on=['dominio', 'formulacao', 'balanceamento', 'modelo'], suffixes=('', '_v21'))
print(f"\n  Checagem: max |bal_acc v23 - v21| = {(m.bal_acc - m.bal_acc_v21).abs().max():.6f}")

print(f"\n  CatBoost especificamente:")
cb = res[res.modelo == "CatBoost"].sort_values(['dominio', 'formulacao', 'balanceamento'])
for _, r in cb.iterrows():
    print(f"  {r.dominio:<9}{r.formulacao:<11}{r.balanceamento:<7}{r.bal_acc:.3f} +/- {r.bal_acc_std:.3f}")
print(f"\n  Tempo total: {time.time()-t_total:.0f}s")
