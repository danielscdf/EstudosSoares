CREATE OR REPLACE VIEW vw_056_espelho_bu_eleicao_excl
AS
      SELECT se.cd_pleito,
             stp.sq_secao_pleito_exc,
             el.nr_turno,
             se.cd_eleicao,
             se.sg_ue_mun,
             se.sg_ue_uf,
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
             JOIN (SELECT DISTINCT secao_tp_cargo_perg_exc.cd_pleito,
                                   secao_tp_cargo_perg_exc.cd_eleicao,
                                   secao_tp_cargo_perg_exc.sg_ue_mun,
                                   secao_tp_cargo_perg_exc.nr_zona,
                                   secao_tp_cargo_perg_exc.nr_secao,
                                   secao_tp_cargo_perg_exc.sg_ue_uf,
                                   sq_secao_pleito_exc,
                                   MAX(DECODE(cd_tipo_cargo_pergunta,  1, qt_comparecimento,  3, qt_comparecimento,  0))
                                       OVER(
                                            PARTITION BY cd_eleicao,
                                                         sg_ue_mun,
                                                         nr_zona,
                                                         nr_secao
                                           )
                                       qt_votos_majoritario,
                                   MAX(DECODE(cd_tipo_cargo_pergunta, 2, qt_comparecimento, 0))
                                       OVER(
                                            PARTITION BY cd_eleicao,
                                                         sg_ue_mun,
                                                         nr_zona,
                                                         nr_secao
                                           )
                                       qt_votos_proporcional,
                                   MAX(qt_comparecimento)
                                       OVER(
                                            PARTITION BY cd_eleicao,
                                                         sg_ue_mun,
                                                         nr_zona,
                                                         nr_secao
                                           )
                                       qt_comparecimento
                     FROM secao_tp_cargo_perg_exc) stp
                 ON stp.cd_pleito = se.cd_pleito
                AND stp.cd_eleicao = se.cd_eleicao
                AND stp.sg_ue_uf = se.sg_ue_uf
                AND stp.sg_ue_mun = se.sg_ue_mun
                AND stp.nr_zona = se.nr_zona
                AND stp.nr_secao = se.nr_secao
    ORDER BY el.nr_ordem_impressao;