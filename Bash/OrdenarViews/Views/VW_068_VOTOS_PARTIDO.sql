CREATE OR REPLACE VIEW vw_068_votos_partido
AS
    SELECT DISTINCT SUM(CASE WHEN vt.cd_tipo_votavel = 4 THEN vmz.qt_votos_computados ELSE 0 END)
                        OVER(
                             PARTITION BY vmz.sg_ue_uf,
                                          vmz.cd_pleito,
                                          vmz.cd_eleicao,
                                          vmz.sg_ue,
                                          vmz.cd_cargo_pergunta,
                                          vt.nr_partido
                            )
                        votos_dados_partido,
                    SUM(
                        CASE
                            WHEN vt.cd_tipo_votavel = 1
                             AND vt.cd_tipo_votavel_destinacao = 1 THEN
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
                                      vmz.cd_cargo_pergunta,
                                      vt.nr_partido
                        )
                        votos_validos_nominal,
                    SUM(
                        CASE
                            WHEN vt.cd_tipo_votavel = 1
                             AND vt.cd_tipo_votavel_destinacao = 4 THEN
                                vmz.qt_votos_computados
                            ELSE
                                0
                        END
                       )
                    OVER(
                         PARTITION BY vmz.sg_ue_uf,
                                      vmz.cd_pleito,
                                      vmz.cd_eleicao,
                                      vmz.sg_ue,
                                      vmz.cd_cargo_pergunta,
                                      vt.nr_partido
                        )
                        votos_validos_legenda,
                    SUM(
                        CASE
                            WHEN vt.cd_tipo_votavel = 4 THEN
                                NVL(vmz.qt_votos_computados, 0)
                            WHEN vt.cd_tipo_votavel = 1
                             AND vt.cd_tipo_votavel_destinacao = 1 THEN
                                NVL(vmz.qt_votos_computados, 0)
                            WHEN vt.cd_tipo_votavel = 1
                             AND vt.cd_tipo_votavel_destinacao = 4 THEN
                                NVL(vmz.qt_votos_computados, 0)
                            ELSE
                                0
                        END
                       )
                    OVER(
                         PARTITION BY vmz.sg_ue_uf,
                                      vmz.cd_pleito,
                                      vmz.cd_eleicao,
                                      vmz.sg_ue,
                                      vmz.cd_cargo_pergunta,
                                      vt.nr_partido
                        )
                        soma_votos_partido_candidato,
                    vt.cd_tipo_votavel_destinacao,
                    tvd.nm_tipo_votavel destinacao_votos,
					tvd.nm_tipo_destinacao_votos tipo_destinacao,
                    vt.cd_tipo_votavel,
                    vt.nr_partido,
                    vmz.sg_ue_uf,
                    vmz.cd_pleito,
                    vmz.cd_eleicao,
                    vmz.sg_ue,
                    vmz.cd_cargo_pergunta,
                    vmz.nr_votavel
      FROM voto_mun_zona vmz
           JOIN votavel vt
               ON vmz.cd_pleito = vt.cd_pleito
              AND vmz.cd_eleicao = vt.cd_eleicao
              AND (vt.sg_ue_uf = 'BR'
                OR vmz.sg_ue_uf = vt.sg_ue_uf)
              AND vmz.sg_ue = vt.sg_ue
              AND vmz.cd_cargo_pergunta = vt.cd_cargo_pergunta
              AND vmz.nr_votavel = vt.nr_votavel
           JOIN tipo_votavel tvd ON tvd.cd_tipo_votavel = vt.cd_tipo_votavel_destinacao;
