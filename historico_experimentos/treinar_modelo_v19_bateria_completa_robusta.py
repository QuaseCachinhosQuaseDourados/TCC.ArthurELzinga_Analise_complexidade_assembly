"""v19: bateria de balanceamento com validação repetida."""
import warnings, time
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import RepeatedStratifiedKFold, cross_validate
from sklearn.tree import DecisionTreeClassifier
from imblearn.pipeline import Pipeline as ImbPipeline
from imblearn.over_sampling import RandomOverSampler, SMOTE, BorderlineSMOTE, ADASYN
from imblearn.under_sampling import RandomUnderSampler, TomekLinks
from imblearn.combine import SMOTETomek
from imblearn.ensemble import (BalancedRandomForestClassifier,
                                BalancedBaggingClassifier, EasyEnsembleClassifier)

warnings.filterwarnings("ignore")
SEED = 42
N_REPEATS = 20

MAPA_OLD = {"O(1)":"Constante","O(log n)":"Logaritmica","O(sqrt(n))":"Logaritmica","O(n)":"Linear",
            "O(n log n)":"O(n log n)/O(n*m)","O(n*m)":"O(n log n)/O(n*m)",
            "O(n^2)":"Polinomial","O(n^3)":"Polinomial","O(2^n)":"Exponencial"}
MAPA_NEW = {"O(1)":"Constante","O(log n)":"Logaritmica","O(sqrt(n))":"Logaritmica","O(n)":"Linear",
            "O(n log n)":"O(n log n)","O(n*m)":"Polinomial",
            "O(n^2)":"Polinomial","O(n^3)":"Polinomial","O(2^n)":"Exponencial"}

def modelos_base(seed):
    return {
        "Random Forest": RandomForestClassifier(n_estimators=300, class_weight='balanced', max_depth=6, min_samples_leaf=2, random_state=seed, n_jobs=1),
        "Gradient Boosting": GradientBoostingClassifier(n_estimators=300, learning_rate=0.03, max_depth=3, min_samples_leaf=2, subsample=0.8, random_state=seed),
        "SVM (RBF)": ImbPipeline([('sc', StandardScaler()), ('svm', SVC(kernel='rbf', C=10, gamma='scale', class_weight='balanced', random_state=seed))]),
        "Logistic Regression": ImbPipeline([('sc', StandardScaler()), ('lr', LogisticRegression(class_weight='balanced', max_iter=1000, C=1.0, random_state=seed))]),
    }

def modelos_bal(fn, seed):
    return {
        "Random Forest": ImbPipeline([('bal', fn()), ('clf', RandomForestClassifier(n_estimators=300, max_depth=6, min_samples_leaf=2, random_state=seed, n_jobs=1))]),
        "Gradient Boosting": ImbPipeline([('bal', fn()), ('clf', GradientBoostingClassifier(n_estimators=300, learning_rate=0.03, max_depth=3, min_samples_leaf=2, subsample=0.8, random_state=seed))]),
        "SVM (RBF)": ImbPipeline([('sc', StandardScaler()), ('bal', fn()), ('svm', SVC(kernel='rbf', C=10, gamma='scale', random_state=seed))]),
        "Logistic Regression": ImbPipeline([('sc', StandardScaler()), ('bal', fn()), ('lr', LogisticRegression(max_iter=1000, C=1.0, random_state=seed))]),
    }

def melhor(modelos, X, y, cv):
    resultados = []
    for nome, clf in modelos.items():
        try:
            r = cross_validate(clf, X, y, cv=cv, scoring='balanced_accuracy', n_jobs=-1, error_score='raise')
            s = r['test_score']
            resultados.append((nome, s.mean(), s.std()))
        except Exception:
            resultados.append((nome, -1, 0))
    resultados.sort(key=lambda t: -t[1])
    return resultados[0]

def rodar_dominio(nome, csv, feats, seed=SEED):
    t0 = time.time()
    df = pd.read_csv(csv)
    df = df[df['time_complexity'].notna() & (df['time_complexity'] != "")]
    if 'recursion_depth' in feats:
        df['recursion_depth'] = df['has_recursion'] * df['backward_jumps']
    df['y_old'] = df['time_complexity'].map(MAPA_OLD)
    df['y_new'] = df['time_complexity'].map(MAPA_NEW)
    df = df[df['y_old'].notna() & df['y_new'].notna()]
    X = df[feats].values
    y_old = df['y_old'].values
    y_new = df['y_new'].values
    min_count = df['y_new'].value_counts().min()
    K = max(1, min(5, min_count - 2))

    rskf = RepeatedStratifiedKFold(n_splits=5, n_repeats=N_REPEATS, random_state=seed)
    print(f"\n{'='*74}\n  {nome} - RepeatedStratifiedKFold 5x{N_REPEATS}={5*N_REPEATS} avaliacoes\n{'='*74}", flush=True)

    cenarios = {}
    nome0, m0, dp0 = melhor(modelos_base(seed), X, y_old, rskf)
    cenarios['0) Mapeamento ANTIGO'] = (nome0, m0, dp0); print(f"  0) Mapeamento ANTIGO         : {nome0:<20} {m0:.3f} +/- {dp0:.3f}", flush=True)

    nome1, m1, dp1 = melhor(modelos_base(seed), X, y_new, rskf)
    cenarios['1) Novo, sem balanceador'] = (nome1, m1, dp1); print(f"  1) Novo, sem balanceador     : {nome1:<20} {m1:.3f} +/- {dp1:.3f}", flush=True)

    nome2, m2, dp2 = melhor(modelos_bal(lambda: RandomOverSampler(random_state=seed), seed), X, y_new, rskf)
    cenarios['2) RandomOverSampler'] = (nome2, m2, dp2); print(f"  2) RandomOverSampler         : {nome2:<20} {m2:.3f} +/- {dp2:.3f}", flush=True)

    nome3, m3, dp3 = melhor(modelos_bal(lambda: SMOTE(k_neighbors=K, random_state=seed), seed), X, y_new, rskf)
    cenarios['3) SMOTE'] = (nome3, m3, dp3); print(f"  3) SMOTE                     : {nome3:<20} {m3:.3f} +/- {dp3:.3f}", flush=True)

    nome4, m4, dp4 = melhor(modelos_bal(lambda: BorderlineSMOTE(k_neighbors=K, random_state=seed), seed), X, y_new, rskf)
    cenarios['4) BorderlineSMOTE'] = (nome4, m4, dp4); print(f"  4) BorderlineSMOTE           : {nome4:<20} {m4:.3f} +/- {dp4:.3f}", flush=True)

    nome5, m5, dp5 = melhor(modelos_bal(lambda: ADASYN(n_neighbors=K, random_state=seed), seed), X, y_new, rskf)
    cenarios['5) ADASYN'] = (nome5, m5, dp5); print(f"  5) ADASYN                    : {nome5:<20} {m5:.3f} +/- {dp5:.3f}", flush=True)

    nome6, m6, dp6 = melhor(modelos_bal(lambda: RandomUnderSampler(random_state=seed), seed), X, y_new, rskf)
    cenarios['6) RandomUnderSampler'] = (nome6, m6, dp6); print(f"  6) RandomUnderSampler        : {nome6:<20} {m6:.3f} +/- {dp6:.3f}", flush=True)

    nome7, m7, dp7 = melhor(modelos_bal(lambda: TomekLinks(), seed), X, y_new, rskf)
    cenarios['7) TomekLinks'] = (nome7, m7, dp7); print(f"  7) TomekLinks                : {nome7:<20} {m7:.3f} +/- {dp7:.3f}", flush=True)

    nome8, m8, dp8 = melhor(modelos_bal(lambda: SMOTETomek(smote=SMOTE(k_neighbors=K, random_state=seed), random_state=seed), seed), X, y_new, rskf)
    cenarios['8) SMOTETomek'] = (nome8, m8, dp8); print(f"  8) SMOTETomek                : {nome8:<20} {m8:.3f} +/- {dp8:.3f}", flush=True)

    ensembles = {
        "9) BalancedRandomForest": BalancedRandomForestClassifier(n_estimators=300, max_depth=6, min_samples_leaf=2, random_state=seed, n_jobs=1, sampling_strategy='all', replacement=True),
        "10) BalancedBagging": BalancedBaggingClassifier(estimator=DecisionTreeClassifier(max_depth=6, random_state=seed), n_estimators=100, random_state=seed, n_jobs=1),
        "11) EasyEnsemble": EasyEnsembleClassifier(n_estimators=50, random_state=seed, n_jobs=1),
    }
    for enome, clf in ensembles.items():
        try:
            r = cross_validate(clf, X, y_new, cv=rskf, scoring='balanced_accuracy', n_jobs=-1, error_score='raise')
            s = r['test_score']
            cenarios[enome] = (enome, s.mean(), s.std())
            print(f"  {enome:<28} : {s.mean():.3f} +/- {s.std():.3f}", flush=True)
        except Exception as e:
            print(f"  {enome:<28} : ERRO - {e}", flush=True)

    print(f"\n  Delta vs (1) novo/sem-bal:")
    base = cenarios['1) Novo, sem balanceador'][1]
    for k, v in cenarios.items():
        if k == '1) Novo, sem balanceador':
            continue
        print(f"    {k:<28}: {v[1]-base:+.3f}")
    print(f"\n  Tempo: {time.time()-t0:.0f}s")
    return {k: v[1] for k, v in cenarios.items()}

FEAT_ASM = ['jne','add','num_labels','has_recursion','lea','cmp','backward_jumps','movslq',
            'conditional_backward','recursion_depth','imul_count','sar_count','shr_count',
            'cmov_count','jg_jge_count','loop_nesting_depth','instr_per_label','instr_per_func']
r_asm = rodar_dominio("ASSEMBLY", "features_asm_v2.csv", FEAT_ASM)

FEAT_C = ['total_lines','num_functions','loop_count','if_count','max_loop_depth','nested_loop_count',
          'has_recursion','recursive_calls','double_recursion','branch_ratio','loop_ratio',
          'malloc_count','ptr_ops','idx_array','op_incr']
r_c = rodar_dominio("C", "features_c_estrutural.csv", FEAT_C)

print(f"\n{'='*74}\n  RESUMO FINAL (RepeatedStratifiedKFold 5x{N_REPEATS}={5*N_REPEATS} avaliacoes)\n{'='*74}")
print(f"  {'Cenario':<28}{'Assembly':>12}{'C':>12}")
for k in r_asm:
    c = r_c.get(k, float('nan'))
    print(f"  {k:<28}{r_asm[k]:>12.3f}{c:>12.3f}")
