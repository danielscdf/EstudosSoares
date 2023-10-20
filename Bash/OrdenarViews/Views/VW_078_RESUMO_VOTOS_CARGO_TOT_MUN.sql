CREATE OR REPLACE VIEW VW_078_RESUMO_VOTOS_CARGO_TOT_MUN (TOTAL_VOTOS_NOMINAIS_VALIDOS,
																													 TOTAL_VOTOS_BRANCOS,
																													 TOTAL_VOTOS_NULOS,
																													 TOTAL_VOTOS_LEGENDA,
																													 TOTAL_SEM_CAND_PARA_VOTAR,
																													 TOTAL_VOTOS_ANULADO,
																													 TOTAL_VOTOS_ANULADO_SUB_JUDICE,
																													 TOTAL_VOTOS_NULO_TECNICO,
																													 TOTAL_VOTOS_ANUL_APURADO_SEP,
																													 TOTAL_VOTOS_VALIDOS,
																													 QT_TOTAL_VOTOS_COMPUTADOS,
																													 SG_UE_UF,
																													 CD_PLEITO,
																													 CD_ELEICAO,
																													 SG_UE,
																													 SG_UE_MUN,
																													 CD_CARGO_PERGUNTA,
																													 NM_CARGO,
																													 CD_TIPO_CARGO_PERGUNTA)
AS
    SELECT DISTINCT SUM(CASE WHEN vt.cd_tipo_votavel = 1 THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
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
                                          vmz.cd_cargo_pergunta
                            )
                        total_votos_brancos,
                    SUM(CASE WHEN vt.cd_tipo_votavel = 3 THEN vmz.qt_votos_totalizados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
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
                                          vmz.cd_cargo_pergunta
                            )
                        total_votos_validos,
                    SUM(vmz.qt_votos_computados)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.sg_ue_mun,
                                          vmz.cd_cargo_pergunta
                            )
                        qt_total_votos_computados,
                    vmz.sg_ue_uf,
                    vmz.cd_pleito,
                    vmz.cd_eleicao,
                    vmz.sg_ue,
                    vmz.sg_ue_mun,
                    vmz.cd_cargo_pergunta,
                    c.nm_cargo_neutro,
                    cp.cd_tipo_cargo_pergunta
      FROM voto_mun_zona vmz
           INNER JOIN votavel vt
               ON vmz.cd_pleito = vt.cd_pleito
              AND vmz.cd_eleicao = vt.cd_eleicao
              AND (vt.sg_ue_uf = 'BR'
                OR vmz.sg_ue_uf = vt.sg_ue_uf)
              AND vmz.sg_ue = vt.sg_ue
              AND vmz.cd_cargo_pergunta = vt.cd_cargo_pergunta
              AND vmz.nr_votavel = vt.nr_votavel
           LEFT JOIN cargo c
               ON vmz.cd_cargo_pergunta = c.cd_cargo
              AND vmz.cd_eleicao = c.cd_eleicao
              AND c.st_votavel = 'S'
           LEFT JOIN cargo_pergunta cp
               ON vmz.cd_cargo_pergunta = cp.cd_cargo_pergunta
              AND vmz.cd_eleicao = cp.cd_eleicao
              AND vmz.cd_pleito = cp.cd_pleito;