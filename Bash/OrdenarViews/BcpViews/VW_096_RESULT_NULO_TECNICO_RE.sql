CREATE OR REPLACE VIEW vw_096_result_nulo_tecnico_re
AS
SELECT dm.cd_pleito,
       dm.cd_eleicao,
       e.nm_eleicao,
       dm.cd_regiao,
       dm.nm_regiao,
       vt.cd_cargo_pergunta cd_cargo,
       vt.nm_cargo_pergunta nm_cargo_neutro,
       vt.nr_votavel,
       vt.nm_votavel nm_candidato,
       vt.cd_tipo_votavel_destinacao,
       vt.nm_tipo_votavel_destinacao,
       NVL(vv.qt_votos_computados_votavel,0) qt_votos_computados
FROM dm_regiao dm
INNER JOIN dm_votavel vt
      ON vt.cd_pleito = dm.cd_pleito
      AND vt.cd_eleicao = dm.cd_eleicao
      AND vt.sg_ue = 'BR'
      AND vt.sg_ue_uf = 'BR'
      AND vt.cd_tipo_votavel_destinacao = 8
LEFT JOIN ft_votos_votavel_regiao vv
      ON vv.cd_pleito = vt.cd_pleito
      AND vv.cd_eleicao = vt.cd_eleicao
      AND vv.sq_dm_regiao = dm.sq_dm_regiao
      AND vv.sq_dm_votavel = vt.sq_dm_votavel
INNER JOIN eleicao e
      ON e.cd_pleito = dm.cd_pleito
      AND e.cd_eleicao = dm.cd_eleicao;
