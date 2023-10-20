CREATE OR REPLACE VIEW vw_078_resumo_uf_federal
AS
    SELECT v.cd_pleito,
           v.cd_eleicao,
           v.cd_tipo_cargo_pergunta,
           'BR' sg_ue,
           'Brasil' nm_ue,
					 vt.cd_cargo_pergunta,
					 c.nm_cargo_neutro nm_cargo,
           v.qtd_eleitores,
           v.qtd_comparecimento,
           TO_CHAR(CASE WHEN qtd_aptos_urnas_instaladas = 0 THEN 0 WHEN qtd_comparecimento = 0 THEN 0 WHEN qtd_comparecimento / qtd_aptos_urnas_instaladas * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE TRUNC(qtd_comparecimento / qtd_aptos_urnas_instaladas * 100, 2) END, '990D00')
           pe_comparecimento,
           v.qtd_comparecimento_urna,
           v.qtd_comparecimento_sa,
           v.qtd_comparecimento_anulado,
           v.qtd_compar_anulado_apurado_separ,
           v.qtd_comparecimento_nao_apurado,
           v.qtd_abstencao,
           TO_CHAR(CASE WHEN qtd_aptos_urnas_instaladas = 0 THEN 0 WHEN qtd_abstencao = 0 THEN 0 WHEN qtd_comparecimento / qtd_aptos_urnas_instaladas * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 100 - 0.01 ELSE 100 - TRUNC(qtd_comparecimento / qtd_aptos_urnas_instaladas * 100, 2) END, '990D00')
           pe_abstencao,
           v.qtd_aptos_urnas_instaladas,
           v.qtd_aptos_urnas_nao_instaladas,
           v.qtd_aptos_apurados,
           v.qtd_aptos_nao_apurados,
           v.qtd_secoes,
           v.qtd_secoes_agregadas,
           v.qtd_secoes_totalizadas,
           v.qtd_secoes_nao_tot,
           v.qtd_secoes_instaladas,
           v.qtd_secoes_nao_instaladas,
           v.qtd_secoes_anulada_apurada_separada,
           v.qtd_secoes_anulada,
           v.qtd_secoes_nao_apuradas,
           v.qtd_secoes_apuradas,
           v.qtd_secoes_apuradas_urna,
           v.qtd_secoes_apuradas_sa,
           vt.qt_votos_nominais total_votos_nominais_validos,
           vt.pe_votos_nominais pe_votos_nominais_validos,
           vt.qt_votos_brancos total_votos_brancos,
           vt.pe_votos_brancos pe_votos_brancos,
           vt.qt_votos_nulos total_votos_nulos,
           vt.pe_votos_nulos pe_votos_nulos,
           vt.qt_votos_sem_cand_para_votar total_sem_cand_para_votar,
           vt.pe_votos_sem_cand_para_votar pe_votos_sem_cand_para_votar,
           vt.qt_votos_anulados total_votos_anulado,
           vt.pe_votos_anulados pe_votos_anulado,
           vt.qt_votos_anulados_sub_judice total_votos_anulado_sub_judice,
           vt.pe_votos_anulados_sub_judice pe_votos_anulado_sub_judice,
           vt.qt_votos_nulo_tecnico total_votos_nulo_tecnico,
           vt.pe_votos_nulo_tecnico pe_votos_nulo_tecnico,
           vt.qt_votos_anul_apurado_sep total_votos_anul_apurado_sep,
           vt.pe_votos_anul_apurado_sep pe_votos_anul_apurado_sep,
           vt.qt_votos_validos total_votos_validos,
           vt.pe_votos_validos pe_votos_validos,
           vt.qt_vt_comp_todos_votaveis qt_total_votos_computados,
           vt.qt_vt_tot_todos_cand_resp total_votos_cand_concorrentes,
           vt.pe_vt_tot_todos_cand_resp pe_total_votos_cand_concorrentes,
           vt.qt_votos_nulo_nulo_tecnico soma_votos_nulos,
           vt.pe_votos_nulo_nulo_tecnico pe_soma_votos_nulos,
           vt.qt_votos_legenda total_votos_legenda,
           vt.pe_votos_legenda pe_votos_legenda
      FROM (  SELECT se.cd_pleito,
                     se.cd_eleicao,
                     stp.cd_tipo_cargo_pergunta,
                     SUM(se.qt_aptos) qtd_eleitores,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna <> 5 THEN
                                 stp.qt_comparecimento
                             ELSE
                                 0
                         END
                        )
                         qtd_comparecimento,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 1
                              AND sp.cd_ori_votos <> 'C' THEN
                                 stp.qt_comparecimento
                             ELSE
                                 0
                         END
                        )
                         qtd_comparecimento_urna,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 1
                              AND sp.cd_ori_votos = 'C' THEN
                                 stp.qt_comparecimento
                             ELSE
                                 0
                         END
                        )
                         qtd_comparecimento_sa,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 4 THEN
                                 stp.qt_comparecimento
                             ELSE
                                 0
                         END
                        )
                         qtd_comparecimento_anulado,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 3 THEN
                                 stp.qt_comparecimento
                             ELSE
                                 0
                         END
                        )
                         qtd_compar_anulado_apurado_separ,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 2 THEN
                                 stp.qt_comparecimento
                             ELSE
                                 0
                         END
                        )
                         qtd_comparecimento_nao_apurado,
                     SUM(
                     CASE
                         WHEN se.tp_situacao_totalizacao = 'T'
                          AND sp.cd_tipo_urna <> 5 THEN
                         se.qt_aptos
                         ELSE
                         0
                     END
                        ) - SUM(
                     CASE
                         WHEN se.tp_situacao_totalizacao = 'T'
                            AND sp.cd_tipo_urna <> 5 THEN
                         stp.qt_comparecimento
                         ELSE
                         0
                     END
                               )
                         qtd_abstencao,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna <> 5 THEN
                                 se.qt_aptos
                             ELSE
                                 0
                         END
                        )
                         qtd_aptos_urnas_instaladas,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 5 THEN
                                 se.qt_aptos
                             ELSE
                                 0
                         END
                        )
                         qtd_aptos_urnas_nao_instaladas,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna NOT IN (2, 5) THEN
                                 se.qt_aptos
                             ELSE
                                 0
                         END
                        )
                         qtd_aptos_apurados,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 2 THEN
                                 se.qt_aptos
                             ELSE
                                 0
                         END
                        )
                         qtd_aptos_nao_apurados,
                     COUNT(sp.nr_secao) qtd_secoes,
                     pc_ad_secao_agregada_eleicao.fc_qtd_secoes_agregadas(se.cd_pleito, se.cd_eleicao) qtd_secoes_agregadas,
                     SUM(DECODE(se.tp_situacao_totalizacao, 'T', 1, 0)) qtd_secoes_totalizadas,
                     COUNT(sp.nr_secao) - SUM(DECODE(se.tp_situacao_totalizacao, 'T', 1, 0)) qtd_secoes_nao_tot,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna <> 5 THEN
                                 1
                             ELSE
                                 0
                         END
                        )
                         qtd_secoes_instaladas,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 5 THEN
                                 1
                             ELSE
                                 0
                         END
                        )
                         qtd_secoes_nao_instaladas,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 3 THEN
                                 1
                             ELSE
                                 0
                         END
                        )
                         qtd_secoes_anulada_apurada_separada,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 4 THEN
                                 1
                             ELSE
                                 0
                         END
                        )
                         qtd_secoes_anulada,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 2 THEN
                                 1
                             ELSE
                                 0
                         END
                        )
                         qtd_secoes_nao_apuradas,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 1 THEN
                                 1
                             ELSE
                                 0
                         END
                        )
                         qtd_secoes_apuradas,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 1
                              AND sp.cd_ori_votos <> 'C' THEN
                                 1
                             ELSE
                                 0
                         END
                        )
                         qtd_secoes_apuradas_urna,
                     SUM(
                         CASE
                             WHEN se.tp_situacao_totalizacao = 'T'
                              AND sp.cd_tipo_urna = 1
                              AND sp.cd_ori_votos = 'C' THEN
                                 1
                             ELSE
                                 0
                         END
                        )
                         qtd_secoes_apuradas_sa
                FROM secao_pleito sp
                     JOIN secao_eleicao se
                         ON sp.cd_pleito = se.cd_pleito
                        AND sp.sg_ue_uf = se.sg_ue_uf
                        AND sp.sg_ue_mun = se.sg_ue_mun
                        AND sp.nr_zona = se.nr_zona
                        AND sp.nr_secao = se.nr_secao
                     JOIN secao_processo spp
                         ON sp.cd_processo_eleitoral = spp.cd_processo_eleitoral
                        AND sp.sg_ue_uf = spp.sg_ue_uf
                        AND sp.sg_ue_mun = spp.sg_ue_mun
                        AND sp.nr_zona = spp.nr_zona
                        AND sp.nr_secao = spp.nr_secao
                     JOIN ue_processo UP
                         ON spp.cd_processo_eleitoral = UP.cd_processo_eleitoral
                        AND spp.sg_ue_uf = UP.sg_ue
                     JOIN secao_tp_cargo_perg stp
                         ON se.cd_pleito = stp.cd_pleito
                        AND se.cd_eleicao = stp.cd_eleicao
                        AND se.sg_ue_mun = stp.sg_ue_mun
                        AND se.sg_ue_uf = stp.sg_ue_uf
                        AND se.nr_zona = stp.nr_zona
                        AND se.nr_secao = stp.nr_secao
            GROUP BY se.cd_pleito,
                     se.cd_eleicao,
                     stp.cd_tipo_cargo_pergunta) v
           INNER JOIN vw_ft_votos_tot_br vt
                 ON vt.cd_pleito = v.cd_pleito
                 AND vt.cd_eleicao = v.cd_eleicao
                 AND vt.cd_tipo_cargo_pergunta = v.cd_tipo_cargo_pergunta
           LEFT JOIN cargo c
               ON vt.cd_cargo_pergunta = c.cd_cargo
              AND vt.cd_eleicao = c.cd_eleicao
              AND c.st_votavel = 'S';