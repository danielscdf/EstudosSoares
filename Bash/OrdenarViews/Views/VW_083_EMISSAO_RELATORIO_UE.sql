CREATE OR REPLACE VIEW vw_083_emissao_relatorio_ue
AS
SELECT ue.cd_pleito,
        ue.cd_eleicao,
        e.nm_eleicao,
        ue.sg_ue,
        up.nm_ue nm_ue,
        tr.cd_tipo_relatorio,
        tr.nm_tipo_relatorio,
        TO_CHAR (hg.dt_emissao_hor_loc, 'DD/MM/YYYY HH24:MI:SS') dt_emissao_hor_loc,
        TO_CHAR (hg.dt_emissao_hor_tse, 'DD/MM/YYYY HH24:MI:SS') dt_emissao_hor_tse,
        CASE
           WHEN tr.cd_tipo_relatorio = 110 THEN
              NVL (ue.st_zeresima, 'N')
           WHEN tr.cd_tipo_relatorio = 247 THEN
              NVL(ue.st_emissao_resultado_tot,'N')
           WHEN hg.dt_emissao_hor_tse IS NOT NULL THEN
                'S'
           WHEN hg.dt_emissao_hor_tse IS NULL THEN
              'N'
        END
           st_relatorio_emitido
FROM ue_eleicao ue
INNER JOIN eleicao e
      ON e.cd_pleito = ue.cd_pleito
      AND e.cd_eleicao = ue.cd_eleicao
INNER JOIN ue_processo up
      ON ue.cd_processo_eleitoral = up.cd_processo_eleitoral
      AND ue.sg_ue = up.sg_ue
			AND LENGTH(ue.sg_ue) = 2
INNER JOIN tipo_relatorio tr
      ON tr.cd_tipo_relatorio IN (74,75,110,247)
LEFT JOIN (SELECT hg2.cd_pleito, hg2.cd_eleicao, hg2.sg_ue, hg2.cd_tipo_relatorio, MAX(hg2.dt_emissao_hor_tse) dt_emissao_hor_tse, MAX(hg2.dt_emissao_hor_loc) dt_emissao_hor_loc
          FROM historico_geral_relatorio hg2
          GROUP BY hg2.cd_pleito, hg2.cd_eleicao, hg2.sg_ue, hg2.cd_tipo_relatorio) hg
     ON hg.cd_pleito = ue.cd_pleito
     AND hg.cd_eleicao = ue.cd_eleicao
     AND hg.sg_ue = ue.sg_ue
     AND hg.cd_tipo_relatorio = tr.cd_tipo_relatorio;