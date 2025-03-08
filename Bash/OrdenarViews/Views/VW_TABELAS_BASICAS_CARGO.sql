CREATE OR REPLACE VIEW vw_tabelas_basicas_cargo AS
SELECT DISTINCT
        e.cd_pleito,
        cg.cd_eleicao,
        mz.sg_ue_uf,
        vt.sg_ue,
        mz.sg_ue_mun,
        mz.nr_zona,
        cg.cd_cargo cd_cargo,
        cg.nm_cargo_neutro
    FROM cargo cg
		INNER JOIN eleicao e
		      ON e.cd_eleicao = cg.cd_eleicao
    INNER JOIN votavel vt
          ON cg.cd_eleicao = vt.cd_eleicao
          AND vt.cd_cargo_pergunta IN( cg.cd_cargo, cg.cd_cargo_superior)
    INNER JOIN mun_zona_eleicao mz
         ON mz.cd_pleito = vt.cd_pleito
         AND mz.cd_eleicao = vt.cd_eleicao
         AND vt.sg_ue_uf IN (mz.sg_ue_uf, 'BR')
         AND vt.sg_ue IN (mz.sg_ue_mun, mz.sg_ue_uf, 'BR');
