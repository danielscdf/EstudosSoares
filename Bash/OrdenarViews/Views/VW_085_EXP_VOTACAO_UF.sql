CREATE OR REPLACE VIEW vw_085_exp_votacao_uf
AS
SELECT dm.cd_pleito,
       dm.cd_eleicao,
       dm.sg_ue_uf,
       vt.cd_cargo_pergunta,
       vt.nr_votavel,
       nvl(vt.sq_candidato, vt.nr_votavel) sq_cand_resposta,
       vv.qt_votos_computados_votavel,
       vv.qt_votos_totalizados_votavel,
       vt.cd_tipo_votavel_destinacao,
       vt.nm_tipo_votavel_destinacao nm_tipo_destinacao_votos
FROM dm_uf dm
INNER JOIN ft_votos_votavel_uf vv
      ON vv.cd_pleito = dm.cd_pleito
      AND vv.cd_eleicao = dm.cd_eleicao
      AND vv.sg_ue_uf = dm.sg_ue_uf
      AND vv.sq_dm_uf = dm.sq_dm_uf
INNER JOIN dm_votavel vt
      ON vt.cd_pleito = vv.cd_pleito
      AND vt.cd_eleicao = vv.cd_eleicao
      AND vt.sg_ue_uf IN (vv.sg_ue_uf, 'BR')
      AND vt.sq_dm_votavel = vv.sq_dm_votavel;