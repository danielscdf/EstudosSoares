/* Formatted on 11/11/2020 15:28:26 (QP5 v5.252.13127.32847) */
CREATE OR REPLACE VIEW vw_085_exp_votacao_secao
AS
 SELECT
    vs.cd_pleito,
    vs.cd_eleicao,
    vs.sg_ue_uf,
    vs.sg_ue_mun,
		ue.nm_ue,
    vs.nr_zona,
    vs.nr_secao,
    vs.cd_cargo_pergunta,
    vs.nr_votavel,
    nvl(vt.sq_candidato,vt.nr_votavel) sq_cand_resposta,
    vt.nm_tipo_votavel_destinacao,
    vs.qt_votos qt_votos_candidato_concorrente,
    vt.cd_tipo_votavel_destinacao
FROM voto_secao vs
INNER JOIN dm_votavel vt
      ON vs.cd_pleito = vt.cd_pleito
			AND vs.cd_eleicao = vt.cd_eleicao
			AND vs.sg_ue_uf IN (vt.sg_ue_uf,'BR')
			AND vs.sg_ue = vt.sg_ue
			AND vs.cd_cargo_pergunta = vt.cd_cargo_pergunta
			AND vs.nr_votavel = vt.nr_votavel
INNER JOIN pleito p
      ON vs.cd_pleito = p.cd_pleito
INNER JOIN ue_processo ue
      ON ue.cd_processo_eleitoral = p.cd_processo_eleitoral
			AND ue.sg_ue = vs.sg_ue;