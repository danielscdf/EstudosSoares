CREATE OR REPLACE VIEW vw_059_detal_vagas_obtidas
AS
SELECT vt.cd_pleito,
       vt.cd_eleicao,
       vt.sg_ue_uf,
       vt.sg_ue,
       vt.sq_drap,
       vt.nr_partido,
       vt.cd_cargo_pergunta cd_cargo,
       vt.nr_votavel nr_cand,
       vt.nm_votavel_urna nm_cand_urna,
       vt.nm_votavel nm_candidato,
       vt.cd_situacao_totalizacao,
       vt.nm_situacao_totalizacao
FROM dm_votavel vt
WHERE vt.cd_tipo_cargo_pergunta <> 3
      AND vt.cd_situacao_totalizacao IN (1,3)
      AND vt.cd_tipo_votavel = 1;
/
