CREATE OR REPLACE VIEW vw_votos_secao_pend
AS
    SELECT SUM(CASE WHEN vt.cd_tipo_votavel = 1 THEN pvs.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY pvs.cd_pleito,
                                 pvs.cd_eleicao,
                                 psp.sg_ue_mun,
                                 psp.nr_zona,
                                 psp.nr_secao,
                                 pvs.cd_cargo_pergunta
                   )
               total_votos_nominais_validos,
           SUM(CASE WHEN vt.cd_tipo_votavel = 2 THEN pvs.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY pvs.cd_pleito,
                                 pvs.cd_eleicao,
                                 psp.sg_ue_mun,
                                 psp.nr_zona,
                                 psp.nr_secao,
                                 pvs.cd_cargo_pergunta
                   )
               total_votos_brancos,
           SUM(CASE WHEN vt.cd_tipo_votavel = 3 THEN pvs.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY pvs.cd_pleito,
                                 pvs.cd_eleicao,
                                 psp.sg_ue_mun,
                                 psp.nr_zona,
                                 psp.nr_secao,
                                 pvs.cd_cargo_pergunta
                   )
               total_votos_nulos,
           SUM(CASE WHEN vt.cd_tipo_votavel = 4 THEN pvs.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY pvs.cd_pleito,
                                 pvs.cd_eleicao,
                                 psp.sg_ue_mun,
                                 psp.nr_zona,
                                 psp.nr_secao,
                                 pvs.cd_cargo_pergunta
                   )
               total_votos_legenda,
           SUM(CASE WHEN vt.cd_tipo_votavel = 5 THEN pvs.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY pvs.cd_pleito,
                                 pvs.cd_eleicao,
                                 psp.sg_ue_mun,
                                 psp.nr_zona,
                                 psp.nr_secao,
                                 pvs.cd_cargo_pergunta
                   )
               total_votos_sem_cand_para_votar,
           SUM(CASE WHEN vt.cd_tipo_votavel = 6 THEN pvs.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY pvs.cd_pleito,
                                 pvs.cd_eleicao,
                                 psp.sg_ue_mun,
                                 psp.nr_zona,
                                 psp.nr_secao,
                                 pvs.cd_cargo_pergunta
                   )
               total_votos_anulado,
           SUM(CASE WHEN vt.cd_tipo_votavel = 7 THEN pvs.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY pvs.cd_pleito,
                                 pvs.cd_eleicao,
                                 psp.sg_ue_mun,
                                 psp.nr_zona,
                                 psp.nr_secao,
                                 pvs.cd_cargo_pergunta
                   )
               total_votos_anulado_sub_judice,
           SUM(CASE WHEN vt.cd_tipo_votavel = 8 THEN pvs.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY pvs.cd_pleito,
                                 pvs.cd_eleicao,
                                 psp.sg_ue_mun,
                                 psp.nr_zona,
                                 psp.nr_secao,
                                 pvs.cd_cargo_pergunta
                   )
               total_votos_nulo_tecnico,
           SUM(CASE WHEN vt.cd_tipo_votavel = 9 THEN pvs.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY pvs.cd_pleito,
                                 pvs.cd_eleicao,
                                 psp.sg_ue_mun,
                                 psp.nr_zona,
                                 psp.nr_secao,
                                 pvs.cd_cargo_pergunta
                   )
               total_votos_anul_apurado_sep,
           SUM(pvs.qt_votos)
               OVER(
                    PARTITION BY pvs.cd_pleito,
                                 pvs.cd_eleicao,
                                 psp.sg_ue_mun,
                                 psp.nr_zona,
                                 psp.nr_secao,
                                 pvs.cd_cargo_pergunta
                   )
               qt_total_votos_computados,
           SUM(CASE WHEN vt.cd_tipo_votavel = 4 THEN pvs.qt_votos ELSE 0 END)
               OVER(
                    PARTITION BY pvs.cd_pleito,
                                 pvs.cd_eleicao,
                                 psp.sg_ue_mun,
                                 psp.nr_zona,
                                 psp.nr_secao,
                                 pvs.cd_cargo_pergunta,
                                 vt.nr_partido
                   )
               qt_votos_legenda,
           SUM(pvs.qt_votos)
               OVER(
                    PARTITION BY pvs.cd_pleito,
                                 pvs.cd_eleicao,
                                 psp.sg_ue_mun,
                                 psp.nr_zona,
                                 psp.nr_secao,
                                 pvs.cd_cargo_pergunta,
                                 vt.nr_partido
                   )
               qt_votos_partido,
           pvs.qt_votos,
           pvs.cd_pleito,
           pvs.cd_eleicao,
           pvs.sg_ue_uf,
           pvs.sg_ue,
           psp.sg_ue_mun,
           psp.nr_zona,
           psp.nr_secao,
           pvs.cd_cargo_pergunta,
           pvs.nr_votavel,
           pvs.nr_partido
      FROM pendencia_voto_secao pvs
           JOIN pendencia_secao_pleito psp
               ON psp.cd_pleito = pvs.cd_pleito
              AND psp.sq_pendencia_secao_pleito = pvs.sq_pendencia_secao_pleito
              AND psp.sg_ue_uf = pvs.sg_ue_uf
           INNER JOIN votavel vt
               ON pvs.cd_pleito = vt.cd_pleito
              AND pvs.cd_eleicao = vt.cd_eleicao
              AND pvs.sg_ue_uf = DECODE(vt.sg_ue_uf, 'BR', pvs.sg_ue_uf, vt.sg_ue_uf)
              AND pvs.sg_ue = vt.sg_ue
              AND pvs.cd_cargo_pergunta = vt.cd_cargo_pergunta
              AND pvs.nr_votavel = vt.nr_votavel;