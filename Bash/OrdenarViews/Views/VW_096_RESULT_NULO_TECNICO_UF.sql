CREATE OR REPLACE VIEW vw_096_result_nulo_tecnico_uf
AS
SELECT dm.cd_pleito,
       dm.cd_eleicao,
       e.nm_eleicao,
       dm.sg_ue_uf,
       vt.cd_cargo_pergunta cd_cargo,
       vt.nm_cargo_pergunta nm_cargo_neutro,
       vt.nr_votavel,
       vt.nm_votavel nm_candidato,
       vt.cd_tipo_votavel_destinacao,
       vt.nm_tipo_votavel_destinacao,
       NVL(vv.qt_votos_computados_votavel,0) qt_votos_computados
FROM dm_uf dm
INNER JOIN dm_votavel vt
      ON vt.cd_pleito = dm.cd_pleito
      AND vt.cd_eleicao = dm.cd_eleicao
      AND vt.sg_ue_uf IN (dm.sg_ue_uf,'BR')
      AND vt.sg_ue  IN (dm.sg_ue_uf,'BR')
      AND vt.cd_tipo_votavel_destinacao = 8
LEFT JOIN ft_votos_votavel_uf vv
      ON vt.cd_pleito = vv.cd_pleito
      AND vt.cd_eleicao = vv.cd_eleicao
      AND vt.sg_ue_uf IN(vv.sg_ue_uf,'BR')
      AND dm.sq_dm_uf = vv.sq_dm_uf
      AND vt.sq_dm_votavel = vv.sq_dm_votavel
INNER JOIN eleicao e
      ON e.cd_pleito = dm.cd_pleito
      AND e.cd_eleicao = dm.cd_eleicao;