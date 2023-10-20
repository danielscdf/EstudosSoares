CREATE OR REPLACE VIEW vw_candidato
AS
SELECT c.cd_pleito, c.cd_eleicao, c.sg_ue_uf, c.sg_ue, ue.nm_ue, c.cd_cargo, c.sq_candidato, c.nr_cand, c.nr_partido, c.nm_cand_urna
FROM candidato c
INNER JOIN ue
      ON ue.sg_ue = c.sg_ue
INNER JOIN cargo cg
      ON cg.cd_eleicao = c.cd_eleicao
			AND cg.cd_cargo = c.cd_cargo;