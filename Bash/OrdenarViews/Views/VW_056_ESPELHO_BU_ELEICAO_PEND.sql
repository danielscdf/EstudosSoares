CREATE OR REPLACE VIEW vw_056_espelho_bu_eleicao_pend
AS
      SELECT stp.sq_pendencia_secao_pleito,
             se.cd_pleito,
             el.nr_turno,
             se.cd_eleicao,
             se.sg_ue_uf,
             se.sg_ue_mun,
             se.nr_zona,
             se.nr_secao,
             el.nm_eleicao,
             el.cd_tipo_eleicao,
             stp.qt_votos_majoritario,
             stp.qt_votos_proporcional,
             stp.qt_comparecimento,
             se.qt_aptos qt_aptos,
             se.qt_aptos - stp.qt_comparecimento qt_faltosos,
             el.nr_ordem_impressao
        FROM secao_eleicao se
             JOIN eleicao el
                 ON el.cd_pleito = se.cd_pleito
                AND el.cd_eleicao = se.cd_eleicao
             JOIN (SELECT DISTINCT ptp.cd_pleito,
                                   ptp.cd_eleicao,
                                   ps.sg_ue_mun,
                                   ps.nr_zona,
                                   ps.nr_secao,
                                   ps.sg_ue_uf,
                                   ps.sq_pendencia_secao_pleito,
                                   MAX(DECODE(ptp.cd_tipo_cargo_pergunta,  1, ptp.qt_comparecimento,  3, ptp.qt_comparecimento,  0))
                                       OVER(
                                            PARTITION BY ptp.cd_eleicao,
                                                         ps.sg_ue_mun,
                                                         ps.nr_zona,
                                                         ps.nr_secao,
                                                         ps.sq_pendencia_secao_pleito
                                           )
                                       qt_votos_majoritario,
                                   MAX(DECODE(ptp.cd_tipo_cargo_pergunta, 2, ptp.qt_comparecimento, 0))
                                       OVER(
                                            PARTITION BY ptp.cd_eleicao,
                                                         ps.sg_ue_mun,
                                                         ps.nr_zona,
                                                         ps.nr_secao,
                                                         ps.sq_pendencia_secao_pleito
                                           )
                                       qt_votos_proporcional,
                                   MAX(ptp.qt_comparecimento)
                                       OVER(
                                            PARTITION BY ptp.cd_eleicao,
                                                         ps.sg_ue_mun,
                                                         ps.nr_zona,
                                                         ps.nr_secao,
                                                         ps.sq_pendencia_secao_pleito
                                           )
                                       qt_comparecimento
                     FROM pendencia_secao_tp_cargo_perg ptp
                          JOIN pendencia_secao_pleito ps
                              ON ptp.cd_pleito = ps.cd_pleito
                             AND ptp.sq_pendencia_secao_pleito = ps.sq_pendencia_secao_pleito
                             AND ptp.sg_ue_uf = ps.sg_ue_uf) stp
                 ON stp.cd_pleito = se.cd_pleito
                AND stp.cd_eleicao = se.cd_eleicao
                AND stp.sg_ue_uf = se.sg_ue_uf
                AND stp.sg_ue_mun = se.sg_ue_mun
                AND stp.nr_zona = se.nr_zona
                AND stp.nr_secao = se.nr_secao
    ORDER BY el.nr_ordem_impressao;