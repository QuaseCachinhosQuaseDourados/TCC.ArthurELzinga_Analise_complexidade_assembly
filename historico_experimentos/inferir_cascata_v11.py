"""Aplica a cascata de modelos do v11 (binário -> subclasses)."""
import json
import os
import pickle
import sys

import pandas as pd

sys.stdout.reconfigure(encoding="utf-8")

DIR_MODELOS = "modelo_v11"


def carregar_cascata(diretorio: str = DIR_MODELOS):
    meta_path = os.path.join(diretorio, "metadata.json")
    with open(meta_path, encoding="utf-8") as f:
        meta = json.load(f)
    feats = meta["features"]
    with open(os.path.join(diretorio, "classificador_eficiencia.pkl"), "rb") as f:
        clf_bin = pickle.load(f)
    with open(os.path.join(diretorio, "classificador_fino_eficiente.pkl"), "rb") as f:
        clf_ef = pickle.load(f)
    with open(os.path.join(diretorio, "classificador_fino_ineficiente.pkl"), "rb") as f:
        clf_inef = pickle.load(f)
    return meta, feats, clf_bin, clf_ef, clf_inef


def vetor_features(linha: pd.Series, feats: list) -> "object":
    return linha[feats].values.reshape(1, -1)


def predizer(linha: pd.Series, feats, clf_bin, clf_ef, clf_inef):
    X = vetor_features(linha, feats)
    ef = clf_bin.predict(X)[0]
    if ef == "Eficiente":
        classe_fina = clf_ef.predict(X)[0]
    else:
        classe_fina = clf_inef.predict(X)[0]
    return ef, classe_fina


if __name__ == "__main__":
    if not os.path.isdir(DIR_MODELOS):
        print(f"Execute antes: python treinar_modelo_v11.py  (pasta ./{DIR_MODELOS}/ ausente)")
        sys.exit(1)
    _, feats, clf_bin, clf_ef, clf_inef = carregar_cascata()
    print("Modelos carregados. Features:", feats)
    print("Use: from inferir_cascata_v11 import carregar_cascata, predizer")
