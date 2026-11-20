"""v13: conjunto expandido de features (features_asm_v2.csv)."""
import sys
import warnings
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import StratifiedKFold, cross_validate, train_test_split
from sklearn.metrics import classification_report, confusion_matrix

sys.stdout.reconfigure(encoding='utf-8')
warnings.filterwarnings("ignore")

CSV     = "features_asm_v2.csv"
TARGET  = "time_complexity"
N_FOLDS = 5
SEED    = 42

MAPA_6 = {
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

MAPA_BIN = {
    "O(1)":"Eficiente","O(log n)":"Eficiente","O(sqrt(n))":"Eficiente",
    "O(n)":"Eficiente","O(n log n)":"Eficiente",
    "O(n*m)":"Ineficiente","O(n^2)":"Ineficiente",
    "O(n^3)":"Ineficiente","O(2^n)":"Ineficiente",
}

MAPA_3 = {
    "O(1)"      : "Sublinear",
    "O(log n)"  : "Sublinear",
    "O(sqrt(n))": "Sublinear",
    "O(n)"      : "Linear",
    "O(n log n)": "Linear",
    "O(n*m)"    : "Custoso",
    "O(n^2)"    : "Custoso",
    "O(n^3)"    : "Custoso",
    "O(2^n)"    : "Custoso",
}

df = pd.read_csv(CSV)
df = df[df[TARGET].notna() & (df[TARGET] != "")]
df['recursion_depth'] = df['has_recursion'] * df['backward_jumps']
df['y6']  = df[TARGET].map(MAPA_6)
df['ybin']= df[TARGET].map(MAPA_BIN)
df['y3']  = df[TARGET].map(MAPA_3)
df = df[df['y6'].notna() & df['ybin'].notna() & df['y3'].notna()]

# Remove classes com < 3 amostras
for col in ['y6']:
    validas = df[col].value_counts()
    df = df[df[col].isin(validas[validas >= 3].index)]

print(f"Amostras: {len(df)}")
print(f"\n6 classes:\n{df['y6'].value_counts().to_string()}")
print(f"\nBinário:\n{df['ybin'].value_counts().to_string()}")
print(f"\n3 classes:\n{df['y3'].value_counts().to_string()}\n")


# Baseline: top-9 + recursion_depth (melhor da v8/v10)
FEAT_V8 = ['jne','add','num_labels','has_recursion','lea','cmp',
           'backward_jumps','movslq','conditional_backward','recursion_depth']

# Novas features apenas
FEAT_NOVAS = ['imul_count','sar_count','shr_count','cmov_count',
              'jg_jge_count','loop_nesting_depth','instr_per_label','instr_per_func']

# Combinado: v8 + novas
FEAT_COMBO = FEAT_V8 + FEAT_NOVAS

# Seleção manual baseada na análise de discriminabilidade
FEAT_SELECT = [
    'jne', 'add', 'num_labels', 'has_recursion', 'backward_jumps',
    'conditional_backward', 'recursion_depth',
    'jg_jge_count',
    'cmov_count',
    'sar_count',
    'imul_count',
    'loop_nesting_depth',
]

def get_modelos():
    modelos = {
        "Random Forest": RandomForestClassifier(
            n_estimators=300, class_weight='balanced', max_depth=6,
            min_samples_leaf=2, random_state=SEED, n_jobs=-1),
        "Gradient Boosting": GradientBoostingClassifier(
            n_estimators=300, learning_rate=0.03, max_depth=3,
            min_samples_leaf=2, subsample=0.8, random_state=SEED),
        "SVM (RBF)": Pipeline([('sc', StandardScaler()),
            ('svm', SVC(kernel='rbf', C=10, gamma='scale',
                        class_weight='balanced', random_state=SEED))]),
        "Logistic Regression": Pipeline([('sc', StandardScaler()),
            ('lr', LogisticRegression(class_weight='balanced',
                                      max_iter=1000, C=1.0, random_state=SEED))]),
    }
    # LightGBM (se disponível)
    try:
        import lightgbm as lgb
        modelos["LightGBM"] = lgb.LGBMClassifier(
            n_estimators=300, learning_rate=0.05, max_depth=4,
            num_leaves=15, class_weight='balanced', random_state=SEED,
            verbose=-1, n_jobs=-1)
    except ImportError:
        pass
    # CatBoost (se disponível)
    try:
        from catboost import CatBoostClassifier
        modelos["CatBoost"] = CatBoostClassifier(
            iterations=300, learning_rate=0.05, depth=4,
            auto_class_weights='Balanced', random_seed=SEED, verbose=0)
    except ImportError:
        pass
    return modelos


def avaliar(titulo, feats, X_df, y, melhor_anterior=None):
    X = X_df[feats].values
    skf = StratifiedKFold(n_splits=N_FOLDS, shuffle=True, random_state=SEED)
    print(f"\n{'='*65}")
    print(f"  {titulo}")
    print(f"  {len(feats)} features | {len(set(y))} classes | {len(y)} amostras")
    print(f"{'='*65}")
    resultados = {}
    for nome, clf in get_modelos().items():
        cv = cross_validate(clf, X, y, cv=skf,
                            scoring='balanced_accuracy', n_jobs=-1)
        s = cv['test_score']
        resultados[nome] = s
        marcador = " ◄" if melhor_anterior and s.mean() > melhor_anterior else ""
        print(f"  {nome:<22}: {s.mean():.3f} ± {s.std():.3f}  "
              f"(folds: {[f'{v:.3f}' for v in s]}){marcador}")
    melhor = max(resultados, key=lambda n: resultados[n].mean())
    print(f"\n  ► Melhor: {melhor} ({resultados[melhor].mean():.3f})")
    return resultados, melhor, resultados[melhor].mean()


print("━"*65)
print("  PARTE 1 — 6 CLASSES  (Constante/Log/Linear/Super/Poli/Exp)")
print("━"*65)

_, _, base6  = avaliar("Baseline v8 (10 feat)", FEAT_V8,    df, df['y6'].values)
_, _, novas6 = avaliar("Novas 8 features",      FEAT_NOVAS, df, df['y6'].values, base6)
_, _, sel6, = avaliar("Seleção manual 12 feat", FEAT_SELECT, df, df['y6'].values, base6)
res_combo6, melhor_combo6, combo6 = avaliar(
    "Combinado 18 feat (v8+novas)", FEAT_COMBO, df, df['y6'].values, base6)

print("\n" + "━"*65)
print("  PARTE 2 — BINÁRIO  (Eficiente / Ineficiente)")
print("━"*65)

_, _, base_bin  = avaliar("Baseline v8 (10 feat)", FEAT_V8,     df, df['ybin'].values)
_, _, combo_bin = avaliar("Combinado 18 feat",      FEAT_COMBO,  df, df['ybin'].values, base_bin)
_, _, sel_bin   = avaliar("Seleção manual 12 feat", FEAT_SELECT, df, df['ybin'].values, base_bin)

print("\n" + "━"*65)
print("  PARTE 3 — 3 CLASSES  (Sublinear / Linear / Custoso)")
print("━"*65)

_, _, base3  = avaliar("Baseline v8 (10 feat)", FEAT_V8,     df, df['y3'].values)
_, _, sel3   = avaliar("Seleção manual 12 feat", FEAT_SELECT, df, df['y3'].values, base3)
res3, melhor3, combo3 = avaliar(
    "Combinado 18 feat", FEAT_COMBO, df, df['y3'].values, base3)

print("\n" + "━"*65)
print("  RESUMO FINAL")
print("━"*65)
print(f"  6 classes  — baseline v8 (10 feat) : {base6:.3f}")
print(f"  6 classes  — novas 8 feat          : {novas6:.3f}  Δ={novas6-base6:+.3f}")
print(f"  6 classes  — seleção 12 feat       : {sel6:.3f}  Δ={sel6-base6:+.3f}")
print(f"  6 classes  — combinado 18 feat     : {combo6:.3f}  Δ={combo6-base6:+.3f}")
print()
print(f"  Binário    — baseline v8 (10 feat) : {base_bin:.3f}  (ref: v11=0.726)")
print(f"  Binário    — combinado 18 feat     : {combo_bin:.3f}  Δ={combo_bin-base_bin:+.3f}")
print(f"  Binário    — seleção 12 feat       : {sel_bin:.3f}  Δ={sel_bin-base_bin:+.3f}")
print()
print(f"  3 classes  — baseline v8 (10 feat) : {base3:.3f}")
print(f"  3 classes  — seleção 12 feat       : {sel3:.3f}  Δ={sel3-base3:+.3f}")
print(f"  3 classes  — combinado 18 feat     : {combo3:.3f}  Δ={combo3-base3:+.3f}")

melhor_cenario = max([
    ("6 classes / combinado", combo6),
    ("Binário / combinado",   combo_bin),
    ("3 classes / combinado", combo3),
], key=lambda x: x[1])
print(f"\n  ► MELHOR CENÁRIO: {melhor_cenario[0]} = {melhor_cenario[1]:.3f}")

if "Binário" in melhor_cenario[0]:
    y_final = df['ybin'].values
    tag = "Binário (Eficiente/Ineficiente)"
elif "3 classes" in melhor_cenario[0]:
    y_final = df['y3'].values
    tag = "3 classes (Sublinear/Linear/Custoso)"
else:
    y_final = df['y6'].values
    tag = "6 classes"

X_tr, X_te, y_tr, y_te = train_test_split(
    df[FEAT_COMBO].values, y_final, test_size=0.2, stratify=y_final, random_state=SEED
)
clf = get_modelos()[melhor_combo6]
clf.fit(X_tr, y_tr)
y_pred = clf.predict(X_te)

print(f"\n{'='*65}")
print(f"  Relatório — {tag} | {melhor_combo6} | split 80/20")
print(f"{'='*65}")
print(classification_report(y_te, y_pred, zero_division=0))

labels_sorted = sorted(set(y_final))
cm = confusion_matrix(y_te, y_pred, labels=labels_sorted)
print("Matriz de confusão:")
print(f"{'':>15}", end="")
for l in labels_sorted:
    print(f"{l[:10]:>12}", end="")
print()
for i, l in enumerate(labels_sorted):
    print(f"{l:>15}", end="")
    for j in range(len(labels_sorted)):
        print(f"{cm[i][j]:>12}", end="")
    print()

print(f"\n{'='*65}")
print("  AutoGluon TabularPredictor — 6 classes, 18 features, time_limit=120s")
print(f"{'='*65}")
try:
    from autogluon.tabular import TabularPredictor
    import os, shutil

    ag_df = df[FEAT_COMBO + ['y6']].copy()
    ag_df.columns = list(ag_df.columns[:-1]) + ['label']

    X_tr_ag, X_te_ag = train_test_split(ag_df, test_size=0.2, stratify=ag_df['label'], random_state=SEED)

    ag_dir = "modelo_autogluon_v13"
    if os.path.exists(ag_dir):
        shutil.rmtree(ag_dir)

    pred = TabularPredictor(
        label='label', path=ag_dir,
        eval_metric='balanced_accuracy',
        verbosity=1
    ).fit(X_tr_ag, time_limit=120, presets='best_quality')

    scores = pred.evaluate(X_te_ag)
    print(f"\n  balanced_accuracy (holdout 80/20): {scores['balanced_accuracy']:.3f}")
    print(f"  accuracy (holdout 80/20)         : {scores['accuracy']:.3f}")

    print("\n  Importância de features (AutoGluon):")
    try:
        imp = pred.feature_importance(X_te_ag)
        print(imp[['importance','stddev','p_value']].head(18).to_string())
    except Exception as e:
        print(f"  (importância não disponível: {e})")

except ImportError:
    print("  AutoGluon não disponível neste ambiente.")
except Exception as e:
    print(f"  Erro no AutoGluon: {e}")
