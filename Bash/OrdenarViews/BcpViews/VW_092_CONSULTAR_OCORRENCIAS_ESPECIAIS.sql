CREATE OR REPLACE VIEW VW_092_CONSULTAR_OCORRENCIAS_ESPECIAIS AS
SELECT DISTINCT pl.cd_pleito,
     pl.sg_ue_uf,
     pl.sg_ue_mun,
     UP.nm_ue,
     pl.nr_zona,
     LPAD(pl.nr_secao, 4, '0') nr_secao,
     co.nr_urna,
     pc_ad_correspondencia.fc_formata(co.cd_carga_urna, '.', 3) cd_carga,
     TO_CHAR(co.dt_carga_urna,  'DD/MM/YYYY HH24:MI:SS') dt_carga,
     co.cd_flash_card cd_flash_card,
     pl.cd_tipo_urna,
     'Efetivada' tipo_correspondencia,
     OV.SG_ORI_VOTOS,
      CASE
             WHEN ( PL.CD_ORI_VOTOS IN ('B','C', 'R'))
             THEN
                OV.NM_ORI_VOTOS
             WHEN co.tp_correspondencia_atual = 'C' --Contingência
             THEN
                'Contingência'
             ELSE
                tu.nm_tipo_urna
          END
             AS Ocorrencia
FROM secao_pleito PL
JOIN pleito p
     ON pl.cd_pleito = p.cd_pleito
     AND pl.cd_processo_eleitoral = p.cd_processo_eleitoral
JOIN ue_processo UP
     ON p.cd_processo_eleitoral = UP.cd_processo_eleitoral
     AND pl.sg_ue_mun = UP.sg_ue
     AND pl.sg_ue_uf = up.sg_ue_superior
LEFT JOIN correspondencia co
     ON pl.cd_processo_eleitoral = co.cd_processo_eleitoral
     AND pl.Sg_Ue_Uf = co.sg_ue_uf
     AND pl.sq_corresp_efetivada = co.sq_corresp
     AND pl.sg_ue_uf = up.sg_ue_superior
LEFT JOIN origem_votos ov
     ON ov.cd_ori_votos = pl.cd_ori_votos
LEFT JOIN tipo_urna tu
     ON tu.cd_tipo_urna = pl.cd_tipo_urna
WHERE NVL(PL.SQ_CORRESP_ESPERADA, 0) <> NVL(PL.SQ_CORRESP_EFETIVADA, 1)
  AND PL.TP_SITUACAO_SECAO_BU = 'R'
UNION
SELECT DISTINCT pl.cd_pleito,
     pl.sg_ue_uf,
     pl.sg_ue_mun,
     UP.nm_ue,
     pl.nr_zona,
     LPAD(pl.nr_secao, 4, '0') nr_secao,
     co.nr_urna,
     pc_ad_correspondencia.fc_formata(co.cd_carga_urna, '.', 3) cd_carga,
     TO_CHAR(co.dt_carga_urna,  'DD/MM/YYYY HH24:MI:SS') dt_carga,
     co.cd_flash_card cd_flash_card,
     pl.cd_tipo_urna,
     'Esperada' tipo_correspondencia,
     NULL SG_ORI_VOTOS,
     NULL Ocorrencia
FROM secao_pleito PL
JOIN pleito p
     ON pl.cd_pleito = p.cd_pleito
     AND pl.cd_processo_eleitoral = p.cd_processo_eleitoral
JOIN ue_processo UP
     ON p.cd_processo_eleitoral = UP.cd_processo_eleitoral
     AND pl.sg_ue_mun = UP.sg_ue
     AND pl.sg_ue_uf = up.sg_ue_superior
LEFT JOIN correspondencia co
     ON pl.cd_processo_eleitoral = co.cd_processo_eleitoral
     AND pl.Sg_Ue_Uf = co.sg_ue_uf
     AND pl.sq_corresp_esperada = co.sq_corresp
     AND pl.sg_ue_uf = up.sg_ue_superior
WHERE NVL(PL.SQ_CORRESP_ESPERADA, 0) <> NVL(PL.SQ_CORRESP_EFETIVADA, 1)
  AND PL.TP_SITUACAO_SECAO_BU = 'R'
order by cd_pleito,
     sg_ue_uf,
     sg_ue_mun,
     nr_zona,
      nr_secao,
      tipo_correspondencia;