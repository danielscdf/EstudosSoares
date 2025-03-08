CREATE OR REPLACE VIEW vw_tabelas_basicas_municipio AS
SELECT
    mz.cd_pleito,
    up.sg_ue_superior sg_ue_uf,
    up.sg_ue sg_ue_mun,
    up.nm_ue,
		mz.nr_zona,
		up.st_capital
FROM ue_processo up
INNER JOIN mun_zona_pleito mz
      ON mz.cd_processo_eleitoral = up.cd_processo_eleitoral
			AND mz.sg_ue_uf = up.sg_ue_superior
			AND mz.sg_ue_mun = up.sg_ue;
