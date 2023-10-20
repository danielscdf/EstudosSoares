CREATE OR REPLACE VIEW vw_secoes_mun
AS
      SELECT se.cd_pleito,
             se.cd_eleicao,
             stp.cd_tipo_cargo_pergunta,
             sp.sg_ue_uf,
             se.sg_ue_mun,
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
                      AND sp.cd_tipo_urna NOT IN (2, 5) THEN
                         1
                     ELSE
                         0
                 END
                )
                 qtd_secoes_apuradas
        FROM secao_pleito sp
             JOIN secao_eleicao se
                 ON sp.cd_pleito = se.cd_pleito
                AND sp.sg_ue_uf = se.sg_ue_uf
                AND sp.sg_ue_mun = se.sg_ue_mun
                AND sp.nr_zona = se.nr_zona
                AND sp.nr_secao = se.nr_secao
             JOIN secao_tp_cargo_perg stp
                 ON se.cd_pleito = stp.cd_pleito
                AND se.cd_eleicao = stp.cd_eleicao
                AND se.sg_ue_mun = stp.sg_ue_mun
                AND se.sg_ue_uf = stp.sg_ue_uf
                AND se.nr_zona = stp.nr_zona
                AND se.nr_secao = stp.nr_secao
    GROUP BY se.cd_pleito,
             se.cd_eleicao,
             stp.cd_tipo_cargo_pergunta,
             sp.sg_ue_uf,
             se.sg_ue_mun;