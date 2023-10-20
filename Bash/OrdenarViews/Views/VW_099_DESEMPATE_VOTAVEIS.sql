CREATE OR REPLACE VIEW vw_099_desempate_votaveis
AS
SELECT d.cd_pleito,
       d.cd_eleicao,
       d.sg_ue_uf,
       d.sg_ue,
       ue.nm_ue,
       d.cd_cargo_pergunta,
			 d.nr_votavel,
       NVL(cg.nm_cargo_neutro, pe.nm_pergunta) nm_cargo_pergunta,
       d.qt_votos,
       nvl(ca.nm_cand_urna, re.nm_resposta) nm_cand_resposta,
       pa.nr_partido,
             DECODE(
                    cp.cd_tipo_cargo_pergunta,
                    3, NULL,
                    NVL(
                        (SELECT coligacao.nm_coligacao
                           FROM coligacao
                          WHERE coligacao.cd_pleito = ca.cd_pleito
                            AND coligacao.cd_eleicao = ca.cd_eleicao
                            AND coligacao.sg_ue = ca.sg_ue
                            AND coligacao.sq_drap = ca.sq_drap),
                        (SELECT nvl(fe.nm_federacao,partido.nm_partido)nm_partido
                           FROM partido
													 LEFT JOIN federacao fe
													      ON fe.cd_pleito = partido.cd_pleito
																AND fe.cd_eleicao = partido.cd_eleicao
																AND fe.nr_federacao = partido.nr_federacao
                          WHERE partido.cd_pleito = ca.cd_pleito
                            AND partido.cd_eleicao = ca.cd_eleicao
                            AND partido.nr_partido = ca.nr_partido)
                       )
                   )
                 nm_partido_coligacao,
        d.sq_classificacao,
        ca.dt_nascimento,
        d.ds_desempate
       
FROM desempate d
INNER JOIN pleito p
      ON d.cd_pleito = p.cd_pleito
INNER JOIN ue_processo ue
      ON ue.cd_processo_eleitoral = p.cd_processo_eleitoral
      AND ue.sg_ue = d.sg_ue
INNER JOIN cargo_pergunta cp
      ON cp.cd_pleito = d.cd_pleito
      AND cp.cd_eleicao = d.cd_eleicao
      AND cp.cd_cargo_pergunta = d.cd_cargo_pergunta
LEFT JOIN cargo cg
     ON cg.cd_eleicao = d.cd_eleicao
     AND cg.cd_cargo = d.cd_cargo_pergunta
LEFT JOIN candidato ca
     ON ca.cd_pleito = d.cd_pleito
     AND ca.cd_eleicao = d.cd_eleicao
     AND ca.sg_ue_uf = d.sg_ue_uf
     AND ca.sg_ue = d.sg_ue
     AND ca.cd_cargo = d.cd_cargo_pergunta
     AND ca.nr_cand = d.nr_votavel
LEFT JOIN partido pa
     ON pa.cd_pleito = ca.cd_pleito
     AND pa.cd_eleicao = ca.cd_eleicao
     AND pa.nr_partido = ca.nr_partido
LEFT JOIN pergunta pe
     ON pe.cd_pleito = d.cd_pleito
     AND pe.cd_eleicao = d.cd_eleicao
     AND pe.cd_pergunta = d.cd_cargo_pergunta
LEFT JOIN resposta re
     ON re.cd_pleito = d.cd_pleito
     AND re.cd_eleicao = d.cd_eleicao
     AND re.sg_ue_uf = d.sg_ue_uf
     AND re.sg_ue = d.sg_ue
		 AND re.nr_resposta = d.nr_votavel;