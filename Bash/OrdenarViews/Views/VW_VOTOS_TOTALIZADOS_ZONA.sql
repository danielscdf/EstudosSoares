CREATE OR REPLACE VIEW vw_votos_totalizados_zona
AS
SELECT DISTINCT SUM(CASE WHEN vt.cd_tipo_votavel = 1 THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta
                            )
                        total_votos_nominais_validos,
                    SUM(CASE WHEN vt.cd_tipo_votavel = 2 THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta
                            )
                        total_votos_brancos,
                    SUM(CASE WHEN vt.cd_tipo_votavel IN (3, 8) THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta
                            )
                        soma_votos_nulos,
                    SUM(CASE WHEN vt.cd_tipo_votavel = 3 THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta
                            )
                        total_votos_nulos,
                    SUM(CASE WHEN vt.cd_tipo_votavel = 4 THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta
                            )
                        total_votos_legenda,
                    SUM(CASE WHEN vt.cd_tipo_votavel = 5 THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta
                            )
                        total_sem_cand_para_votar,
                    SUM(CASE WHEN vt.cd_tipo_votavel = 6 THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta
                            )
                        total_votos_anulado,
                    SUM(CASE WHEN vt.cd_tipo_votavel = 7 THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta
                            )
                        total_votos_anulado_sub_judice,
                    SUM(CASE WHEN vt.cd_tipo_votavel = 8 THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta
                            )
                        total_votos_nulo_tecnico,
                    SUM(CASE WHEN vt.cd_tipo_votavel = 9 THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta
                            )
                        total_votos_anul_apurado_sep,
                    SUM(CASE WHEN vt.cd_tipo_votavel IN (1, 4) THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta
                            )
                        total_votos_validos,
                    SUM(
                        CASE
                            WHEN vt.cd_tipo_votavel IN (1,
                                                        4,
                                                        6,
                                                        7) THEN
                                vmz.qt_votos_totalizados
                            ELSE
                                0
                        END
                       )
                    OVER(
                         PARTITION BY vmz.sg_ue_uf,
                                      vmz.cd_pleito,
                                      vmz.cd_eleicao,
                                      vmz.sg_ue,
                                      vmz.sg_ue_mun,
                                      vmz.nr_zona,
                                      vmz.cd_cargo_pergunta
                        )
                        total_votos_cand_concorrentes,
                    SUM(CASE WHEN vt.cd_tipo_votavel IN (1, 4) AND vt.cd_tipo_votavel_destinacao IN (1,4,6,7) THEN vmz.qt_votos_computados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta,
                                          vt.nr_partido
                            )
                        total_part_col,
                    SUM(vmz.qt_votos_computados)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta
                            )
                        qt_total_votos_computados,
                    SUM(vmz.qt_votos_computados)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta,
                                          vmz.nr_votavel
                            )
                        qt_votos_computados_votavel,
                    SUM(vmz.qt_votos_totalizados)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.nr_zona,
                                          vmz.cd_cargo_pergunta,
                                          vmz.nr_votavel
                            )
                        qt_votos_totalizados_votavel,
                    vmz.sg_ue_uf,
                    vmz.cd_pleito,
                    vmz.cd_eleicao,
                    vmz.sg_ue,
                    vmz.sg_ue_mun,
                    vmz.nr_zona,
                    vmz.cd_cargo_pergunta,
                    vmz.nr_votavel,
                    vt.nr_partido,
                    vt.cd_tipo_votavel_destinacao,
                    cp.cd_tipo_cargo_pergunta
      FROM voto_mun_zona vmz
           JOIN votavel vt
               ON vmz.cd_pleito = vt.cd_pleito
              AND vmz.cd_eleicao = vt.cd_eleicao
              AND (vt.sg_ue_uf = 'BR'
                OR vmz.sg_ue_uf = vt.sg_ue_uf)
              AND vmz.sg_ue = vt.sg_ue
              AND vmz.cd_cargo_pergunta = vt.cd_cargo_pergunta
              AND vmz.nr_votavel = vt.nr_votavel
           JOIN cargo_pergunta cp
             ON CP.CD_PLEITO = vt.cd_pleito
            AND cp.cd_eleicao = vt.cd_eleicao
            AND cp.cd_cargo_pergunta = vt.cd_cargo_pergunta;