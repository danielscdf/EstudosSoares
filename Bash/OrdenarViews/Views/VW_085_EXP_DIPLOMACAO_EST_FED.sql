CREATE OR REPLACE VIEW vw_085_exp_diplomacao_est_fed
AS
SELECT vv.cd_pleito,
       vv.cd_eleicao,
       p.dt_pleito,
       vv.sg_ue_uf,
       vt.sg_ue,
       vt.cd_cargo_pergunta cd_cargo,
       vt.nm_cargo_pergunta nm_cargo_neutro,
       CASE vt.sg_ue
            WHEN 'BR' THEN 'Tribunal Superior Eleitoral'
            ELSE 'Tribunal Regional Eleitoral '||vv.sg_ue_uf
       END tribunal,
       vt.nr_votavel nr_cand,
       vt.sq_candidato,
       vt.nm_votavel nm_candidato,
       vt.cd_situacao_totalizacao,
       vt.nm_situacao_totalizacao,
       vt.sq_ordem_suplencia,
       COALESCE(vt.nm_coligacao, vt.nm_federacao,vt.nr_partido || ' - ' ||vt.sg_partido) sg_partido_coligacao,
       vt.cd_tipo_votavel_destinacao,
       vt.nm_tipo_votavel_destinacao,
       vv.qt_votos_computados_votavel,
       vv.qt_votos_totalizados_votavel
FROM ft_votos_votavel_uf vv
INNER JOIN dm_votavel vt
     ON vt.cd_pleito = vv.cd_pleito
     AND vt.cd_eleicao = vv.cd_eleicao
     AND vt.sg_ue_uf IN (vv.sg_ue_uf,'BR')
     AND vt.sq_dm_votavel = vv.sq_dm_votavel
INNER JOIN pleito p
      ON p.cd_pleito = vt.cd_pleito;