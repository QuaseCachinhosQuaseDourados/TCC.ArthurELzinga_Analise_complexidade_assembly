# Estimativa da complexidade de tempo de algoritmos a partir do código assembly com aprendizado de máquina

Código, dados e resultados do Trabalho de Conclusão de Curso (Engenharia Mecatrônica — UFSC, Joinville, 2026),
orientado pelo Prof. Dr. Ricardo José Pfitscher.

O trabalho investiga se é possível estimar a classe de complexidade de tempo (Big-O) de um algoritmo a partir
do código **assembly x86-64** gerado pela compilação de seu código-fonte em C. Algoritmos rotulados do
GeeksForGeeks são compilados com o GCC; do assembly são extraídas 18 características (contagens de instruções e
estrutura do fluxo de controle: laços, aninhamento, recursão) que alimentam classificadores para dados tabulares.
O mesmo procedimento é aplicado em paralelo ao código-fonte C (15 características estruturais) para comparar as
duas representações.

## Resultados principais

Acurácia balanceada média em validação cruzada estratificada repetida 5 × 20 (100 avaliações por modelo):

| Formulação | Assembly (189 amostras) | C (229 amostras) |
|---|---|---|
| Binário (Eficiente / Ineficiente) | 72,9% (Regressão Logística + SMOTE) | 72,1% (Random Forest) |
| 3 classes (Sublinear / Linear / Custoso) | 61,7% (Random Forest + SMOTE) | 64,7% (CatBoost + SMOTE) |
| 6 classes | 56,6% (CatBoost + SMOTE) | 53,5% (Regressão Logística + SMOTE) |

O AutoGluon, avaliado nas mesmas partições, não superou o CatBoost em nenhum cenário. Detalhes, Kappa, AUC e
testes estatísticos estão no Capítulo 4 do TCC e nos arquivos de `resultados/`.

## Estrutura do repositório

```
.
├── dados/
│   ├── geeks_for_geeks.json           base original (501 algoritmos rotulados, raspagem do GeeksForGeeks)
│   ├── codigos_c/                     271 códigos C extraídos da base
│   ├── codigos_c_limpos/              os mesmos, após a limpeza de artefatos de raspagem
│   ├── codigos_asm/                   208 arquivos .s (os que compilaram)
│   ├── compilacao_falhas.txt          erros de compilação dos 63 códigos descartados
│   ├── instrucoes_por_arquivo.csv     contagem das 15 instruções mais frequentes + rótulos
│   ├── instrucoes_top15_global.txt    ranking global de instruções
│   ├── features_asm_v2.csv            características do assembly (entrada dos modelos)
│   ├── features_asm_estrutural.csv    versão intermediária das características do assembly
│   └── features_c_estrutural.csv      características do código-fonte C (entrada dos modelos)
├── resultados/                        CSVs e logs dos experimentos finais (v21, v22, v23)
└── historico_experimentos/            versões anteriores dos experimentos (v1–v20), só para consulta
```

## Pipeline final

Todos os scripts são executados **a partir da raiz do repositório**.

| Ordem | Script | Entrada → Saída |
|---|---|---|
| 1 | `extrair_codigos_c.py` | `geeks_for_geeks.json` → `codigos_c/` |
| 2 | `limpar_e_compilar.py` | `codigos_c/` → `codigos_c_limpos/`, `codigos_asm/` (`gcc -S -O1 -w`) |
| 3 | `analisar_instrucoes.py` | `codigos_asm/` + JSON → `instrucoes_por_arquivo.csv` |
| 4 | `extrair_features_asm.py` | `codigos_asm/` + passo 3 → `features_asm_v2.csv` |
| 5 | `analisar_features_c.py` | `codigos_c/` + JSON → `features_c_estrutural.csv` |
| 6 | `treinar_modelo_v21_consolidacao_final.py` | resultados principais (6 modelos, 3 formulações, 5 × 20) |
| 7 | `treinar_modelo_v22_autogluon_mesmas_particoes.py` | AutoGluon × CatBoost nas mesmas partições (5 × 6) |
| 8 | `treinar_modelo_v23_metricas_comparacao.py` | acurácia simples, Kappa e AUC (requer o passo 6) |
| — | `analises_tcc/analise_cap4.py` | matrizes de confusão e figuras do Capítulo 4 |
| — | `analises_tcc/estatisticas_instrucoes.py` | estatísticas de instruções (Seção 3.4.1) |
| — | `analises_tcc/fluxograma.py` | Figura 1 (fluxograma da metodologia) |

A normalização dos rótulos para as formulações de 6, 3 e 2 classes é feita dentro dos scripts de treino
(dicionários `MAPA_*`).

Os arquivos intermediários já estão versionados em `dados/`, então é possível rodar diretamente a partir do
passo 6. Ao regenerar os passos 1–5, os arquivos `.s` e `features_c_estrutural.csv` saem idênticos; em
`instrucoes_por_arquivo.csv` e `features_asm_*.csv`, o arquivo `01_Knapsack_Problem_2.s` fica sem rótulo (no
CSV usado no TCC ele aparece como O(2^n)). Os resultados do TCC foram obtidos com os CSVs versionados.

### Tempo de execução aproximado

- passos 1–5: poucos segundos;
- v21: cerca de 4 min; v23: cerca de 10 min;
- v22: várias horas (AutoGluon com 120 s por partição, 30 partições por cenário). O script retoma de onde parou.

## Ambiente

- Python 3.12 — dependências em `requirements.txt` (`pip install -r requirements.txt`);
- GCC 8.1.0 (MinGW-W64, x86-64) — necessário apenas para o passo 2. Outra versão do GCC pode gerar
  assembly ligeiramente diferente;
- Executado em Windows 11, Intel Core i7-12700H, 32 GB de RAM.

## Pasta `historico_experimentos/`

Contém as versões anteriores dos scripts de treino e de integração de dados (v1–v20, fontes externas
LeetCode/GeeksForGeeks posteriormente descartadas, experimentos de balanceamento e de mapeamento de classes).
Eles foram executados com todos os arquivos na raiz e com caminhos antigos, e alguns dependem de arquivos que
não fazem parte deste repositório. Estão aqui apenas para documentar a evolução descrita na Seção 4.1 do TCC.

## Fonte dos dados

Os códigos e rótulos de complexidade vêm do portal [GeeksForGeeks](https://www.geeksforgeeks.org/), por meio da
raspagem realizada pela ferramenta SACI (Oliveira, 2015), a mesma usada em trabalhos anteriores do grupo
(ver também [RuTiCo](https://github.com/ricardopfitscher/RuTiCo)). O conteúdo pertence aos respectivos autores
e é redistribuído aqui apenas para fins acadêmicos e de reprodutibilidade.
