CREATE OR REPLACE VIEW vw_combo_cargo_pergunta(cd_pleito,
                                               cd_eleicao,
                                               cd_cargo_pergunta,
                                               nm_cargo_neutro,
                                               cd_tipo_eleicao,
                                               nm_tipo_eleicao,
                                               nm_pergunta,
                                               st_votavel,
                                               ordemx,
                                               cd_tipo_cargo_pergunta)
    BEQUEATH DEFINER
AS
    SELECT cp.cd_pleito,
           cp.cd_eleicao,
           cp.cd_cargo_pergunta,
           ca.nm_cargo_neutro,
           te.cd_tipo_eleicao,
           te.nm_tipo_eleicao,
           pe.nm_pergunta,
           ca.st_votavel,
           DECODE(cp.cd_cargo_pergunta,  1, 1,  2, 1,  3, 2,  4, 2,  5, 3,  6, 4,  7, 5,  8, 6,  9, 3,  10, 3,  11, 1,  12, 1,  13, 2,  cp.cd_cargo_pergunta) ordemx,
           cp.cd_tipo_cargo_pergunta
      FROM cargo_pergunta cp
           JOIN eleicao e
               ON cp.cd_pleito = e.cd_pleito
              AND cp.cd_eleicao = e.cd_eleicao
           LEFT JOIN cargo ca
               ON cp.cd_cargo_pergunta = ca.cd_cargo
              AND cp.cd_eleicao = ca.cd_eleicao
           LEFT JOIN tipo_eleicao te ON e.cd_tipo_eleicao = te.cd_tipo_eleicao
           LEFT JOIN pergunta pe
               ON cp.cd_cargo_pergunta = pe.cd_pergunta
              AND cp.cd_eleicao = pe.cd_eleicao
              AND cp.cd_pleito = pe.cd_pleito;