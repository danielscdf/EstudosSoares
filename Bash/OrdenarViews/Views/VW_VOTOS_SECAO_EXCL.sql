CREATE OR REPLACE VIEW vw_votos_secao_excl
AS
    SELECT SUM(CASE WHEN vt.cd_tipo_votavel = 1 THEN se.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY se.cd_pleito,
                                 se.cd_eleicao,
                                 se.sg_ue,
                                 se.nr_zona,
                                 se.nr_secao,
                                 se.cd_cargo_pergunta
                   )
               total_votos_nominais_validos,
           SUM(CASE WHEN vt.cd_tipo_votavel = 2 THEN se.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY se.cd_pleito,
                                 se.cd_eleicao,
                                 se.sg_ue,
                                 se.nr_zona,
                                 se.nr_secao,
                                 se.cd_cargo_pergunta
                   )
               total_votos_brancos,
           SUM(CASE WHEN vt.cd_tipo_votavel = 3 THEN se.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY se.cd_pleito,
                                 se.cd_eleicao,
                                 se.sg_ue,
                                 se.nr_zona,
                                 se.nr_secao,
                                 se.cd_cargo_pergunta
                   )
               total_votos_nulos,
           SUM(CASE WHEN vt.cd_tipo_votavel = 4 THEN se.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY se.cd_pleito,
                                 se.cd_eleicao,
                                 se.sg_ue,
                                 se.nr_zona,
                                 se.nr_secao,
                                 se.cd_cargo_pergunta
                   )
               total_votos_legenda,
           SUM(CASE WHEN vt.cd_tipo_votavel = 5 THEN se.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY se.cd_pleito,
                                 se.cd_eleicao,
                                 se.sg_ue,
                                 se.nr_zona,
                                 se.nr_secao,
                                 se.cd_cargo_pergunta
                   )
               total_votos_sem_cand_para_votar,
           SUM(CASE WHEN vt.cd_tipo_votavel = 6 THEN se.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY se.cd_pleito,
                                 se.cd_eleicao,
                                 se.sg_ue,
                                 se.nr_zona,
                                 se.nr_secao,
                                 se.cd_cargo_pergunta
                   )
               total_votos_anulado,
           SUM(CASE WHEN vt.cd_tipo_votavel = 7 THEN se.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY se.cd_pleito,
                                 se.cd_eleicao,
                                 se.sg_ue,
                                 se.nr_zona,
                                 se.nr_secao,
                                 se.cd_cargo_pergunta
                   )
               total_votos_anulado_sub_judice,
           SUM(CASE WHEN vt.cd_tipo_votavel = 8 THEN se.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY se.cd_pleito,
                                 se.cd_eleicao,
                                 se.sg_ue,
                                 se.nr_zona,
                                 se.nr_secao,
                                 se.cd_cargo_pergunta
                   )
               total_votos_nulo_tecnico,
           SUM(CASE WHEN vt.cd_tipo_votavel = 9 THEN se.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY se.cd_pleito,
                                 se.cd_eleicao,
                                 se.sg_ue,
                                 se.nr_zona,
                                 se.nr_secao,
                                 se.cd_cargo_pergunta
                   )
               total_votos_anul_apurado_sep,
           SUM(se.qt_votos)
               OVER(
                    PARTITION BY se.cd_pleito,
                                 se.cd_eleicao,
                                 se.sg_ue,
                                 se.nr_zona,
                                 se.nr_secao,
                                 se.cd_cargo_pergunta
                   )
               qt_total_votos_computados,
           SUM(CASE WHEN vt.cd_tipo_votavel = 4 THEN se.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY se.cd_pleito,
                                 se.cd_eleicao,
                                 se.sg_ue,
                                 se.nr_zona,
                                 se.nr_secao,
                                 se.cd_cargo_pergunta,
                                 vt.nr_partido
                   )
               qt_votos_legenda,
           SUM(se.qt_votos)
               OVER(
                    PARTITION BY se.cd_pleito,
                                 se.cd_eleicao,
                                 se.sg_ue,
                                 se.nr_zona,
                                 se.nr_secao,
                                 se.cd_cargo_pergunta,
                                 vt.nr_partido
                   )
               qt_votos_partido,
           se.qt_votos,
           se.cd_pleito,
           se.cd_eleicao,
           se.sg_ue_uf,
           se.sg_ue,
           se.sg_ue_mun,
           se.nr_zona,
           se.nr_secao,
           se.cd_cargo_pergunta,
           se.nr_votavel,
           se.nr_partido
      FROM voto_secao_exc se
           INNER JOIN votavel vt
               ON se.cd_pleito = vt.cd_pleito
              AND se.cd_eleicao = vt.cd_eleicao
              AND se.sg_ue_uf = DECODE(vt.sg_ue_uf, 'BR', se.sg_ue_uf, vt.sg_ue_uf)
              AND se.sg_ue = vt.sg_ue
              AND se.cd_cargo_pergunta = vt.cd_cargo_pergunta
              AND se.nr_votavel = vt.nr_votavel;