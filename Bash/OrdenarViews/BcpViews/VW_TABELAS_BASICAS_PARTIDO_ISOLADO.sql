CREATE OR REPLACE VIEW vw_tabelas_basicas_partido_isolado AS
SELECT
		pi.cd_pleito,
		pi.cd_eleicao,
		mz.sg_ue_uf,
		mz.sg_ue_mun,
		mz.nr_zona,
		pi.sg_ue,
		pi.sq_drap,
		pi.nr_partido_federacao,
		NVL(fe.nm_federacao,p.nm_partido) nm_partido_federacao,
		nvl(fe.sg_federacao,p.sg_partido) sg_partido_federacao,
		le.cd_cargo,
		pi.st_dissidente
FROM
		drap_isolado pi
		JOIN partido p ON ( p.cd_pleito = pi.cd_pleito
												AND p.cd_eleicao = pi.cd_eleicao
												AND pi.nr_partido_federacao IN(p.nr_partido,p.nr_federacao) )
		LEFT JOIN federacao fe
				 ON fe.cd_pleito = p.cd_pleito
				 AND fe.cd_eleicao = p.cd_eleicao
				 AND fe.nr_federacao = p.nr_federacao
		INNER JOIN legenda le
					ON le.cd_eleicao = pi.cd_eleicao
					AND le.sg_ue = pi.sg_ue
					AND le.sq_drap = pi.sq_drap
		INNER JOIN mun_zona_eleicao mz
				 ON mz.cd_pleito = pi.cd_pleito
				 AND mz.cd_eleicao = pi.cd_eleicao
				 AND pi.sg_ue IN (mz.sg_ue_mun, mz.sg_ue_uf, 'BR');