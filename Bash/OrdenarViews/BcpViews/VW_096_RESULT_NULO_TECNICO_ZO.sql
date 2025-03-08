CREATE OR REPLACE VIEW vw_096_result_nulo_tecnico_zo
AS
SELECT dm.cd_pleito,
       dm.cd_eleicao,
       e.nm_eleicao,
       dm.sg_ue_uf,
       dm.nr_zona,
       vt.cd_cargo_pergunta cd_cargo,
       vt.nm_cargo_pergunta nm_cargo_neutro,
       vt.nr_votavel,
       vt.nm_votavel nm_candidato,
       vt.cd_tipo_votavel_destinacao,
       vt.nm_tipo_votavel_destinacao,
       NVL(SUM(vv.qt_votos_computados_votavel),0) qt_votos_computados
FROM dm_mun_zona dm
INNER JOIN dm_votavel vt
      ON vt.cd_pleito = dm.cd_pleito
      AND vt.cd_eleicao = dm.cd_eleicao
      AND vt.sg_ue_uf IN (dm.sg_ue_uf,'BR')
      AND vt.sg_ue  IN (dm.sg_ue_mun, dm.sg_ue_uf,'BR')
      AND vt.cd_tipo_votavel_destinacao = 8
LEFT JOIN ft_votos_votavel_mun_zona vv
      ON vt.cd_pleito = vv.cd_pleito
      AND vt.cd_eleicao = vv.cd_eleicao
      AND vt.sg_ue_uf IN(vv.sg_ue_uf,'BR')
      AND dm.sq_dm_mun_zona = vv.sq_dm_mun_zona
      AND vt.sq_dm_votavel = vv.sq_dm_votavel
INNER JOIN eleicao e
      ON e.cd_pleito = dm.cd_pleito
      AND e.cd_eleicao = dm.cd_eleicao
WHERE dm.cd_pleito = 8455
      AND dm.cd_eleicao = 9661
			AND dm.sg_ue_uf = 'SP'
GROUP BY dm.cd_pleito,
       dm.cd_eleicao,
       e.nm_eleicao,
       dm.sg_ue_uf,
       dm.nr_zona,
       vt.cd_cargo_pergunta,
       vt.nm_cargo_pergunta,
       vt.nr_votavel,
       vt.nm_votavel,
       vt.cd_tipo_votavel_destinacao,
       vt.nm_tipo_votavel_destinacao;