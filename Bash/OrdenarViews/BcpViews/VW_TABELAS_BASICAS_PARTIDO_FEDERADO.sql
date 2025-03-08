CREATE OR REPLACE VIEW vw_tabelas_basicas_partido_federado AS
SELECT mz.cd_pleito,
             le.cd_eleicao,
             mz.sg_ue_uf,
             mz.sg_ue_mun,
             mz.nr_zona,
             le.sg_ue,
             le.sq_drap,
             fe.nr_federacao,
             fe.nm_federacao,
             fe.sg_federacao,
             le.cd_cargo,
						 pa.nr_partido,
						 pa.sg_partido
     FROM legenda le
     LEFT JOIN drap_isolado pi
          ON pi.cd_eleicao = le.cd_eleicao
          AND pi.sg_ue = le.sg_ue
          AND pi.sq_drap = le.sq_drap
      LEFT JOIN partido_federacao_coligacao pc
           ON  pc.cd_eleicao = le.cd_eleicao
           AND pc.sg_ue = le.sg_ue
           AND pc.sq_drap = le.sq_drap
    INNER JOIN mun_zona_eleicao mz
         ON mz.cd_eleicao = le.cd_eleicao
         AND le.sg_ue IN (mz.sg_ue_mun, mz.sg_ue_uf, 'BR')
    INNER JOIN federacao fe
          ON fe.cd_pleito = mz.cd_pleito
          AND fe.cd_eleicao = le.cd_eleicao
          AND fe.nr_federacao IN (pi.nr_partido_federacao, pc.nr_partido_federacao)
		INNER JOIN partido pa
		      ON pa.cd_pleito = fe.cd_pleito
					AND pa.cd_eleicao = fe.cd_eleicao
					AND pa.nr_federacao = fe.nr_federacao;