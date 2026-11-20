"""AutoGluon nas mesmas partições do v21, para comparar com os outros modelos."""
import sys, os, shutil, warnings, time
import numpy as np
import pandas as pd
from scipy.stats import wilcoxon
from sklearn.model_selection import RepeatedStratifiedKFold
from sklearn.metrics import balanced_accuracy_score
from catboost import CatBoostClassifier
from autogluon.tabular import TabularPredictor

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")
SEED = 42
N_REPEATS = 6
TEMPO = 120
SAIDA = "resultados/resultados_v22_autogluon.csv"
TMP = "AutogluonModels/v22_tmp"

MAPA_6 = {"O(1)":"Constante","O(log n)":"Logaritmica","O(sqrt(n))":"Logaritmica","O(n)":"Linear",
          "O(n log n)":"O(n log n)","O(n*m)":"Polinomial",
          "O(n^2)":"Polinomial","O(n^3)":"Polinomial","O(2^n)":"Exponencial"}
MAPA_BIN = {"O(1)":"Eficiente","O(log n)":"Eficiente","O(sqrt(n))":"Eficiente",
            "O(n)":"Eficiente","O(n log n)":"Eficiente",
            "O(n*m)":"Ineficiente","O(n^2)":"Ineficiente","O(n^3)":"Ineficiente","O(2^n)":"Ineficiente"}
FEAT_ASM = ['jne','add','num_labels','has_recursion','lea','cmp','backward_jumps','movslq',
            'conditional_backward','recursion_depth','imul_count','sar_count','shr_count',
            'cmov_count','jg_jge_count','loop_nesting_depth','instr_per_label','instr_per_func']
FEAT_C = ['total_lines','num_functions','loop_count','if_count','max_loop_depth','nested_loop_count',
          'has_recursion','recursive_calls','double_recursion','branch_ratio','loop_ratio',
          'malloc_count','ptr_ops','idx_array','op_incr']


def carregar(csv, mapa, feats):
    df = pd.read_csv(csv)
    df = df[df['time_complexity'].notna() & (df['time_complexity'] != "")]
    if 'recursion_depth' in feats:
        df['recursion_depth'] = df['has_recursion'] * df['backward_jumps']
    df['y'] = df['time_complexity'].map(mapa)
    df = df[df['y'].notna()]
    vc = df['y'].value_counts()
    df = df[df['y'].isin(vc[vc >= 3].index)].reset_index(drop=True)
    return df[feats + ['y']]


feitos = pd.read_csv(SAIDA) if os.path.exists(SAIDA) else pd.DataFrame(columns=['dominio', 'formulacao', 'fold'])
chaves_feitas = set(zip(feitos['dominio'], feitos['formulacao'], feitos['fold']))

for dominio, csv, feats in [("Assembly", "dados/features_asm_v2.csv", FEAT_ASM),
                            ("C", "dados/features_c_estrutural.csv", FEAT_C)]:
    for form, mapa in [("Binario", MAPA_BIN), ("6 classes", MAPA_6)]:
        df = carregar(csv, mapa, feats)
        X, y = df[feats].values, df['y'].values
        cv = RepeatedStratifiedKFold(n_splits=5, n_repeats=N_REPEATS, random_state=SEED)
        print(f"\n{'='*70}\n  {dominio} | {form} | {len(df)} amostras\n{'='*70}", flush=True)
        for fold, (tr, te) in enumerate(cv.split(X, y)):
            if (dominio, form, fold) in chaves_feitas:
                continue
            t0 = time.time()
            cb = CatBoostClassifier(iterations=300, learning_rate=0.05, depth=4, auto_class_weights='Balanced',
                                    random_seed=SEED, verbose=0, thread_count=-1)
            cb.fit(X[tr], y[tr])
            ba_cb = balanced_accuracy_score(y[te], np.ravel(cb.predict(X[te])))

            if os.path.exists(TMP):
                shutil.rmtree(TMP, ignore_errors=True)
            pred = TabularPredictor(label='y', eval_metric='balanced_accuracy', verbosity=0, path=TMP)
            pred.fit(df.iloc[tr], time_limit=TEMPO, presets='best_quality')
            ba_ag = balanced_accuracy_score(y[te], pred.predict(df.iloc[te].drop(columns=['y'])))
            melhor_interno = pred.model_best

            linha = pd.DataFrame([dict(dominio=dominio, formulacao=form, fold=fold,
                                       autogluon=ba_ag, catboost=ba_cb, ag_melhor_interno=melhor_interno)])
            linha.to_csv(SAIDA, mode='a', header=not os.path.exists(SAIDA), index=False)
            print(f"  fold {fold+1:>2}/{5*N_REPEATS}: AutoGluon {ba_ag:.3f} | CatBoost {ba_cb:.3f} "
                  f"| {melhor_interno} ({time.time()-t0:.0f}s)", flush=True)

shutil.rmtree(TMP, ignore_errors=True)
from scipy.stats import t as t_dist


def t_corrigido(dif, razao_teste_treino=0.25):
    """Corrected resampled t-test (Nadeau & Bengio, 2003) para CV repetida."""
    k = len(dif)
    var = np.var(dif, ddof=1)
    if var == 0:
        return float('nan')
    tstat = np.mean(dif) / np.sqrt((1 / k + razao_teste_treino) * var)
    return 2 * t_dist.sf(abs(tstat), k - 1)


res = pd.read_csv(SAIDA)
res = res[res['fold'] < 5 * N_REPEATS]
print(f"\n{'='*70}\n  RESUMO (mesmas particoes, 5x{N_REPEATS}={5*N_REPEATS} avaliacoes)\n{'='*70}")
for (d, f), g in res.groupby(['dominio', 'formulacao']):
    dif = (g['catboost'] - g['autogluon']).values
    try:
        p_w = wilcoxon(g['catboost'], g['autogluon']).pvalue
    except ValueError:
        p_w = float('nan')
    print(f"  {d:<9}{f:<11} AutoGluon {g.autogluon.mean():.3f}+/-{g.autogluon.std():.3f} | "
          f"CatBoost {g.catboost.mean():.3f}+/-{g.catboost.std():.3f} | "
          f"dif {dif.mean():+.3f} | CatBoost vence {(dif>0).sum()}/{len(g)} | "
          f"p corrigido={t_corrigido(dif):.3f} (Wilcoxon, ref.: {p_w:.3f})")
