CREATE OR REPLACE  VIEW "ADMTOTCENTRAL".
  "VW_079_RESUMO_SECOES_MUN_ZONA" ("CD_PLEITO", "CD_ELEICAO",
  "CD_TIPO_CARGO_PERGUNTA", "SG_UE_UF", "SG_UE_MUN", "NR_ZONA", "NM_UE",
  "QTD_ELEITORES", "QTD_COMPARECIMENTO", "QTD_COMPARECIMENTO_URNA",
  "QTD_COMPARECIMENTO_SA", "QTD_COMPARECIMENTO_ANULADO",
  "QTD_COMPAR_ANULADO_APURADO_SEPAR", "QTD_COMPARECIMENTO_NAO_APURADO",
  "QTD_ABSTENCAO", "QTD_APTOS_URNAS_INSTALADAS",
  "QTD_APTOS_URNAS_NAO_INSTALADAS", "QTD_APTOS_APURADOS",
  "QTD_APTOS_NAO_APURADOS", "QTD_SECOES", "QTD_SECOES_AGREGADAS",
  "QTD_SECOES_TOTALIZADAS", "QTD_SECOES_NAO_TOT", "QTD_SECOES_INSTALADAS",
  "QTD_SECOES_NAO_INSTALADAS", "QTD_SECOES_ANULADA_APURADA_SEPARADA",
  "QTD_SECOES_ANULADA", "QTD_SECOES_NAO_APURADAS", "QTD_SECOES_APURADAS",
  "QTD_SECOES_APURADAS_URNA", "QTD_SECOES_APURADAS_SA")
AS
  SELECT
    se.cd_pleito,
    se.cd_eleicao,
    stp.cd_tipo_cargo_pergunta,
    sp.sg_ue_uf,
    se.sg_ue_mun,
    se.nr_zona,
    up.NM_UE ,
    SUM(se.qt_aptos) qtd_eleitores,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna            <> 5
        THEN stp.qt_comparecimento
        ELSE 0
      END ) qtd_comparecimento,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna  = 1
        AND sp.CD_ORI_VOTOS             <> 'C'
        THEN stp.qt_comparecimento
        ELSE 0
      END ) qtd_comparecimento_urna,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna   =1
        AND sp.CD_ORI_VOTOS             = 'C'
        THEN stp.qt_comparecimento
        ELSE 0
      END ) qtd_comparecimento_SA,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna             = 4
        THEN stp.qt_comparecimento
        ELSE 0
      END ) qtd_comparecimento_anulado,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna             = 3
        THEN stp.qt_comparecimento
        ELSE 0
      END ) qtd_compar_anulado_apurado_separ,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna             = 2
        THEN stp.qt_comparecimento
        ELSE 0
      END ) qtd_comparecimento_nao_apurado,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna            <> 5
        THEN se.qt_aptos
        ELSE 0
      END ) - SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna            <> 5
        THEN stp.qt_comparecimento
        ELSE 0
      END ) qtd_abstencao,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna            <> 5
        THEN se.qt_aptos
        ELSE 0
      END ) qtd_aptos_urnas_instaladas,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna             = 5
        THEN se.qt_aptos
        ELSE 0
      END ) qtd_aptos_urnas_nao_instaladas,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna NOT        IN (2, 5)
        THEN se.qt_aptos
        ELSE 0
      END ) qtd_aptos_apurados,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna             = 2
        THEN se.qt_aptos
        ELSE 0
      END ) qtd_aptos_nao_apurados,
    COUNT(sp.nr_secao) qtd_secoes,
    pc_ad_secao_agregada_eleicao.FC_QTD_SECOES_AGREGADAS(se.cd_pleito,
    se.cd_eleicao, sp.sg_ue_uf, se.sg_ue_mun, se.nr_zona) qtd_secoes_agregadas,
    SUM(DECODE(se.tp_situacao_totalizacao, 'T', 1, 0)) qtd_secoes_totalizadas,
    COUNT(sp.nr_secao) - SUM(DECODE(se.tp_situacao_totalizacao, 'T', 1, 0))
    qtd_secoes_nao_tot,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna            <> 5
        THEN 1
        ELSE 0
      END ) qtd_secoes_instaladas,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna             = 5
        THEN 1
        ELSE 0
      END ) qtd_secoes_nao_instaladas,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna             = 3
        THEN 1
        ELSE 0
      END ) qtd_secoes_anulada_apurada_separada,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna             = 4
        THEN 1
        ELSE 0
      END ) qtd_secoes_anulada,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna             = 2
        THEN 1
        ELSE 0
      END ) qtd_secoes_nao_apuradas,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna =1
        THEN 1
        ELSE 0
      END ) qtd_secoes_apuradas,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna =1
        AND sp.CD_ORI_VOTOS             <>'C'
        THEN 1
        ELSE 0
      END )qtd_secoes_apuradas_urna,
    SUM(
      CASE
        WHEN se.tp_situacao_totalizacao = 'T'
        AND sp.cd_tipo_urna = 1
        AND sp.CD_ORI_VOTOS             ='C'
        THEN 1
        ELSE 0
      END )qtd_secoes_apuradas_SA
  FROM
    secao_pleito sp
  JOIN secao_eleicao se
  ON
    sp.cd_pleito   = se.cd_pleito
  AND sp.sg_ue_uf  = se.sg_ue_uf
  AND sp.sg_ue_mun = se.sg_ue_mun
  AND sp.nr_zona   = se.nr_zona
  AND sp.nr_secao  = se.nr_secao
  JOIN SECAO_PROCESSO spp
  ON
    sp.CD_PROCESSO_ELEITORAL = spp.CD_PROCESSO_ELEITORAL
  AND sp.sg_ue_uf            = spp.sg_ue_uf
  AND sp.sg_ue_mun           = spp.sg_ue_mun
  AND sp.nr_zona             = spp.nr_zona
  AND sp.nr_secao            = spp.nr_secao
  JOIN UE_PROCESSO up
  ON
    SPP.CD_PROCESSO_ELEITORAL = up.CD_PROCESSO_ELEITORAL
  AND spp.SG_UE_MUN           = up.SG_UE
  JOIN secao_tp_cargo_perg stp
  ON
    se.cd_pleito    = stp.cd_pleito
  AND se.cd_eleicao = stp.cd_eleicao
  AND se.sg_ue_mun  = stp.sg_ue_mun
  AND se.sg_ue_uf   = stp.sg_ue_uf
  AND se.nr_zona    = stp.nr_zona
  AND se.nr_secao   = stp.nr_secao
  GROUP BY
    se.cd_pleito,
    se.cd_eleicao,
    stp.cd_tipo_cargo_pergunta,
    sp.sg_ue_uf,
    se.sg_ue_mun,
    se.nr_zona,
    up.NM_UE;