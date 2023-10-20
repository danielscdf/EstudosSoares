CREATE OR REPLACE VIEW VW_077_CONSULTAR_RECURSOS_IMPUGNACOES AS 
SELECT
   mze.CD_ELEICAO,
	 e.nm_eleicao,
   mzpl.CD_PLEITO,
   mzpl.SG_UE_UF,
   mzpl.SG_UE_MUN,
   mzpl.NR_ZONA,
   mzp.NR_JUNTA,
	 mze.st_emissao_junta,
   ue.NM_UE,
   mze.QT_IMPUGNACOES,
   mze.QT_RECURSOS,
   mze.NM_JUIZ_ELEITORAL,
   mze.DS_MOTIVO,
   mze.NM_MUN_SEDE,
   mzpl.QT_SECOES,
   SUM(se.qt_aptos) QT_ELEITORES
FROM
   mun_zona_pleito mzpl 
   JOIN
      mun_zona_processo mzp 
      ON mzpl.cd_processo_eleitoral = mzp.cd_processo_eleitoral 
      AND mzpl.sg_ue_mun = mzp.sg_ue_mun 
      AND mzpl.nr_zona = mzp.nr_zona 
   JOIN
      mun_zona_eleicao mze 
      ON mze.cd_pleito = mzpl.cd_pleito 
      and mze.sg_ue_mun = mzpl.sg_ue_mun 
      AND mze.nr_zona = mzpl.nr_zona 
	 JOIN eleicao e
	      ON mze.cd_eleicao = e.cd_eleicao
   JOIN
      ue_processo ue 
      ON ue.sg_ue = mzp.sg_ue_mun 
      AND ue.cd_processo_eleitoral = mzp.cd_processo_eleitoral 
   JOIN
      secao_eleicao se 
      ON se.cd_eleicao = mze.cd_eleicao 
      AND se.cd_pleito = mze.cd_pleito 
      AND se.sg_ue_uf = mze.sg_ue_uf 
      AND se.sg_ue_mun = mze.sg_ue_mun 
      AND se.nr_zona = mze.nr_zona
GROUP BY
   mze.CD_ELEICAO, e.nm_eleicao, mzpl.CD_PLEITO, ue.NM_UE, mzpl.SG_UE_MUN, mzpl.NR_ZONA, mzp.nr_junta,
	 mze.st_emissao_junta, mzpl.CD_PROCESSO_ELEITORAL, mzpl.SG_UE_UF, mze.QT_IMPUGNACOES, mze.QT_RECURSOS, mze.NM_JUIZ_ELEITORAL, 
   mze.DS_MOTIVO, mze.NM_MUN_SEDE, mzpl.QT_SECOES;
