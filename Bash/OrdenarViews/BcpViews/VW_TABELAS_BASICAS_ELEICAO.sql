CREATE OR REPLACE VIEW vw_tabelas_basicas_eleicao AS
SELECT
    p.cd_pleito,
    e.cd_eleicao,
    p.dt_pleito,
		mze.sg_ue_uf,
		mze.sg_ue_mun,
		mze.nr_zona,
    e.nm_eleicao,
    e.cd_tipo_abrangencia,
    t.nm_tipo_abrangencia,
    e.cd_tipo_eleicao,
    te.nm_tipo_eleicao,
    e.nr_turno,
    DECODE(f.st_fase, 'S', 'Simulado','O', 'Oficial') fase
FROM eleicao e
    JOIN fase f ON 1=1
    JOIN pleito p ON ( e.cd_pleito = p.cd_pleito )
	JOIN mun_zona_eleicao mze ON ( e.cd_pleito = mze.cd_pleito
                                       AND e.cd_eleicao = mze.cd_eleicao )
    JOIN tipo_abrangencia t ON ( e.cd_tipo_abrangencia = t.cd_tipo_abrangencia )
    JOIN tipo_eleicao te ON ( e.cd_tipo_eleicao = te.cd_tipo_eleicao );

