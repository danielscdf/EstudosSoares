CREATE OR REPLACE VIEW vw_063_arquivo_mesa_recebido AS
SELECT sg_ue_mun,
       cd_pleito,
       nm_ue,
       sg_ue_uf,
       nr_zona,
       nr_mesa_urna,
       NVL(URNA_CADASTRO, 'Não recebido') URNA_CADASTRO,
       NVL(LOG_URNA, 'Não recebido') LOG_URNA
FROM (
SELECT uj.sg_ue_mun,
      ue.nm_ue,
      ue.sg_ue_superior sg_ue_uf,
      uj.nr_zona,
      uj.cd_pleito,
      uj.nr_mesa ||'-'|| UJ.NR_URNA_MRJ nr_mesa_urna,
      ca.nm_conteudo_arquivo,
      sa.nm_situacao_arquivo
FROM urna_justificativa uj
INNER JOIN pleito p
      ON uj.cd_pleito = p.cd_pleito
INNER JOIN ue
      ON uj.sg_ue_uf = ue.sg_ue_superior
      AND uj.sg_ue_mun = ue.sg_ue
LEFT JOIN arquivo_recebido ar
     ON uj.cd_pleito = ar.cd_pleito
     AND uj.sg_ue_uf = ar.sg_ue_uf
     AND uj.sg_ue_mun = ar.sg_ue_mun
     AND uj.nr_zona = ar.nr_zona
     AND uj.nr_mesa || UJ.NR_URNA_MRJ = ar.nr_secao
LEFT JOIN situacao_arquivo sa
     ON ar.cd_situacao_arquivo = sa.cd_situacao_arquivo
LEFT JOIN tipo_arquivo_recebido ta
      ON ar.cd_tipo_arquivo_recebido = ta.cd_tipo_arquivo_recebido
LEFT JOIN conteudo_arquivo ca
     ON ta.cd_conteudo_arquivo = ca.cd_conteudo_arquivo
LEFT JOIN tipo_arquivo_recebido ta
      ON ar.cd_tipo_arquivo_recebido = ta.cd_tipo_arquivo_recebido
WHERE ta.cd_conteudo_arquivo IN (4,5,NULL)
      AND NOT EXISTS(SELECT 1
                     FROM ARQUIVO_RECEBIDO AR1
                     WHERE AR1.CD_PLEITO = AR.CD_PLEITO
                           AND AR1.SG_UE_UF = AR.SG_UE_UF
                           AND AR1.SG_UE_MUN = AR.SG_UE_MUN
                           AND AR1.NR_ZONA = AR.NR_ZONA
                           AND AR1.NR_SECAO = AR.NR_SECAO
                           AND AR1.CD_SITUACAO_ARQUIVO <> AR.CD_SITUACAO_ARQUIVO
                           AND AR1.CD_TIPO_ARQUIVO_RECEBIDO = AR.CD_TIPO_ARQUIVO_RECEBIDO
                           AND AR1.TS_RECEBIMENTO_HOR_TSE > AR.TS_RECEBIMENTO_HOR_TSE)
                                                ) ar3
PIVOT(
      MAX(nm_situacao_arquivo)
      FOR nm_conteudo_arquivo IN ('Resultado do Cadastro' AS URNA_CADASTRO, 'Log' AS LOG_URNA)
) pvt;