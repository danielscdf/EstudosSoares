CREATE OR REPLACE VIEW vw_016_consultar_pergunta
AS
SELECT vt.cd_pleito,
       vt.sg_ue_uf,
       vt.cd_eleicao,
       e.nm_eleicao,
       vt.sg_ue,
       ue.nm_ue,
       vt.cd_cargo_pergunta cd_pergunta,
       vt.nm_cargo_pergunta nm_pergunta,
       vt.nr_votavel nr_resposta,
       vt.nm_votavel nm_resposta
FROM dm_votavel vt
INNER JOIN pleito p
      ON p.cd_pleito = vt.cd_pleito
INNER JOIN ue_processo ue
      ON p.cd_processo_eleitoral = ue.cd_processo_eleitoral
      AND ue.sg_ue = vt.sg_ue
INNER JOIN eleicao e
      ON e.cd_eleicao = vt.cd_eleicao
WHERE vt.cd_tipo_cargo_pergunta = 3;
/
