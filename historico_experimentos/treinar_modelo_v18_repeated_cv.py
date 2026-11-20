"""v18: refaz os testes com RepeatedStratifiedKFold."""
import warnings
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import RepeatedStratifiedKFold, cross_validate
from imblearn.pipeline import Pipeline as ImbPipeline
from imblearn.over_sampling import RandomOverSampler, SMOTE, BorderlineSMOTE, ADASYN

warnings.filterwarnings("ignore")
SEED = 42
N_REPEATS = 10

MAPA_OLD = {"O(1)":"Constante","O(log n)":"Logaritmica","O(sqrt(n))":"Logaritmica","O(n)":"Linear",
            "O(n log n)":"O(n log n)/O(n*m)","O(n*m)":"O(n log n)/O(n*m)",
            "O(n^2)":"Polinomial","O(n^3)":"Polinomial","O(2^n)":"Exponencial"}
MAPA_NEW = {"O(1)":"Constante","O(log n)":"Logaritmica","O(sqrt(n))":"Logaritmica","O(n)":"Linear",
            "O(n log n)":"O(n log n)","O(n*m)":"Polinomial",
            "O(n^2)":"Polinomial","O(n^3)":"Polinomial","O(2^n)":"Exponencial"}

def modelos_base(seed):
    return {
        "Random Forest": RandomForestClassifier(n_estimators=300, class_weight='balanced', max_depth=6, min_samples_leaf=2, random_state=seed, n_jobs=-1),
        "Gradient Boosting": GradientBoostingClassifier(n_estimators=300, learning_rate=0.03, max_depth=3, min_samples_leaf=2, subsample=0.8, random_state=seed),
        "SVM (RBF)": ImbPipeline([('sc', StandardScaler()), ('svm', SVC(kernel='rbf', C=10, gamma='scale', class_weight='balanced', random_state=seed))]),
        "Logistic Regression": ImbPipeline([('sc', StandardScaler()), ('lr', LogisticRegression(class_weight='balanced', max_iter=1000, C=1.0, random_state=seed))]),
    }

def modelos_bal(fn, seed):
    return {
        "Random Forest": ImbPipeline([('bal', fn()), ('clf', RandomForestClassifier(n_estimators=300, max_depth=6, min_samples_leaf=2, random_state=seed, n_jobs=-1))]),
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
    return resultados[0], resultados

def rodar_dominio(nome, csv, feats, seed=SEED):
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
    print(f"\n{'='*72}\n  {nome} - RepeatedStratifiedKFold 5x{N_REPEATS}=50 avaliacoes\n{'='*72}")

    (nome0, m0, dp0), _ = melhor(modelos_base(seed), X, y_old, rskf)
    print(f"  0) Mapeamento ANTIGO, sem balanceador   : {nome0:<20} {m0:.3f} +/- {dp0:.3f}")

    (nome1, m1, dp1), _ = melhor(modelos_base(seed), X, y_new, rskf)
    print(f"  1) Mapeamento NOVO,   sem balanceador   : {nome1:<20} {m1:.3f} +/- {dp1:.3f}")

    (nome2, m2, dp2), _ = melhor(modelos_bal(lambda: RandomOverSampler(random_state=seed), seed), X, y_new, rskf)
    print(f"  2) Novo + RandomOverSampler             : {nome2:<20} {m2:.3f} +/- {dp2:.3f}")

    (nome3, m3, dp3), _ = melhor(modelos_bal(lambda: SMOTE(k_neighbors=K, random_state=seed), seed), X, y_new, rskf)
    print(f"  3) Novo + SMOTE                         : {nome3:<20} {m3:.3f} +/- {dp3:.3f}")

    (nome4, m4, dp4), _ = melhor(modelos_bal(lambda: BorderlineSMOTE(k_neighbors=K, random_state=seed), seed), X, y_new, rskf)
    print(f"  4) Novo + BorderlineSMOTE               : {nome4:<20} {m4:.3f} +/- {dp4:.3f}")

    (nome5, m5, dp5), _ = melhor(modelos_bal(lambda: ADASYN(n_neighbors=K, random_state=seed), seed), X, y_new, rskf)
    print(f"  5) Novo + ADASYN                        : {nome5:<20} {m5:.3f} +/- {dp5:.3f}")

    print(f"\n  Delta vs (1) novo/sem-bal:")
    print(f"    Mapeamento antigo vs novo : {m0-m1:+.3f}")
    print(f"    RandomOverSampler         : {m2-m1:+.3f}")
    print(f"    SMOTE                     : {m3-m1:+.3f}")
    print(f"    BorderlineSMOTE           : {m4-m1:+.3f}")
    print(f"    ADASYN                    : {m5-m1:+.3f}")
    return dict(old=m0, new=m1, ros=m2, smote=m3, bsmote=m4, adasyn=m5)

FEAT_ASM = ['jne','add','num_labels','has_recursion','lea','cmp','backward_jumps','movslq',
            'conditional_backward','recursion_depth','imul_count','sar_count','shr_count',
            'cmov_count','jg_jge_count','loop_nesting_depth','instr_per_label','instr_per_func']
r_asm = rodar_dominio("ASSEMBLY", "features_asm_v2.csv", FEAT_ASM)

FEAT_C = ['total_lines','num_functions','loop_count','if_count','max_loop_depth','nested_loop_count',
          'has_recursion','recursive_calls','double_recursion','branch_ratio','loop_ratio',
          'malloc_count','ptr_ops','idx_array','op_incr']
r_c = rodar_dominio("C", "features_c_estrutural.csv", FEAT_C)

print(f"\n{'='*72}\n  RESUMO FINAL (RepeatedStratifiedKFold 5x{N_REPEATS})\n{'='*72}")
print(f"  {'Cenario':<28}{'Assembly':>12}{'C':>12}")
for k, label in [('old','Mapeamento antigo'), ('new','Mapeamento novo (sem bal.)'),
                  ('ros','+ RandomOverSampler'), ('smote','+ SMOTE'),
                  ('bsmote','+ BorderlineSMOTE'), ('adasyn','+ ADASYN')]:
    print(f"  {label:<28}{r_asm[k]:>12.3f}{r_c[k]:>12.3f}")
