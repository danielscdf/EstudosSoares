CREATE OR REPLACE VIEW vw_085_exp_diplomacao_mun
AS
SELECT dm.cd_pleito,
       dm.cd_eleicao,
       p.dt_pleito,
       dm.sg_ue_uf,
       dm.sg_ue_mun,
       dm.nm_municipio nm_ue,
       vt.sg_ue,
       vt.cd_cargo_pergunta cd_cargo,
       vt.nm_cargo_pergunta,
       CASE vt.sg_ue
            WHEN 'BR' THEN 'Tribunal Superior Eleitoral'
            ELSE 'Tribunal Regional Eleitoral '||vt.sg_ue_uf
       END tribunal,
       vt.nr_votavel nr_cand,
       vt.sq_candidato,
       vt.nm_votavel,
       vt.cd_situacao_totalizacao,
       vt.nm_situacao_totalizacao,
       vt.sq_ordem_suplencia,
       COALESCE(vt.nm_coligacao, vt.nm_federacao, vt.nr_partido||' - '||vt.sg_partido) sg_partido_coligacao,
       vt.cd_tipo_votavel_destinacao,
       vt.nm_tipo_votavel_destinacao,
       vv.qt_votos_computados_votavel,
       vv.qt_votos_totalizados_votavel
FROM dm_municipio dm
INNER JOIN ft_votos_votavel_municipio vv
      ON vv.cd_pleito = dm.cd_pleito
      AND vv.cd_eleicao = dm.cd_eleicao
      AND vv.sg_ue_uf = dm.sg_ue_uf
      AND vv.sq_dm_municipio = dm.sq_dm_municipio
INNER JOIN dm_votavel vt
      ON vt.cd_pleito = dm.cd_pleito
      AND vt.cd_eleicao = dm.cd_eleicao
      AND vt.sg_ue_uf IN (dm.sg_ue_uf, 'BR')
      AND vt.sq_dm_votavel = vv.sq_dm_votavel
      AND vt.sq_dm_votavel = vv.sq_dm_votavel
      AND vt.cd_tipo_cargo_pergunta IN (1,2)
INNER JOIN pleito p
      ON dm.cd_pleito = p.cd_pleito;