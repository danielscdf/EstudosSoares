CREATE OR REPLACE VIEW vw_096_result_nulo_tecnico_br
AS
SELECT vt.cd_pleito,
       vt.cd_eleicao,
       e.nm_eleicao,
       vt.cd_cargo_pergunta cd_cargo,
       vt.nm_cargo_pergunta nm_cargo_neutro,
       vt.nr_votavel,
       vt.nm_votavel nm_candidato,
       vt.cd_tipo_votavel_destinacao,
       vt.nm_tipo_votavel_destinacao,
       NVL(vv.qt_votos_computados_votavel,0) qt_votos_computados
FROM dm_votavel vt
LEFT JOIN ft_votos_votavel_br vv
      ON vv.cd_pleito = vt.cd_pleito
      AND vv.cd_eleicao = vt.cd_eleicao
      AND vv.sq_dm_votavel = vt.sq_dm_votavel
INNER JOIN eleicao e
      ON e.cd_pleito = vt.cd_pleito
      AND e.cd_eleicao = vt.cd_eleicao
WHERE vt.cd_tipo_votavel_destinacao = 8;
