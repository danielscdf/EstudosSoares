CREATE OR REPLACE VIEW VW_088_RESULTADO_VOTACAO_SECAO
AS
SELECT se.cd_pleito,
       se.cd_eleicao,
       se.sg_ue_uf,
       se.sg_ue_mun,
       ue.nm_ue nm_municipio,
       se.nr_zona,
       se.nr_secao,
       vt.cd_cargo_pergunta,
       nvl(vt.nr_votavel,0) nr_votavel,
       vt.cd_tipo_votavel,
       vt.cd_tipo_votavel_destinacao,
       tvd.nm_tipo_destinacao_votos nm_tipo_votavel_destinacao,
       nvl(pe.nm_pergunta, cg.nm_cargo_neutro) nm_cargo_pergunta,
       nvl(re.nm_resposta, ca.nm_cand_urna) nm_candidato_resposta,
       sc.nm_situacao_candidato,
       nvl(vs.qt_votos,0) qt_votos
FROM secao_eleicao se
INNER JOIN pleito p
ON p.cd_pleito = se.cd_pleito
INNER JOIN ue_processo ue
ON ue.cd_processo_eleitoral = p.cd_processo_eleitoral
   AND ue.sg_ue = se.sg_ue_mun
INNER JOIN vaga va
ON va.cd_eleicao = se.cd_eleicao
   AND va.sg_ue IN(se.sg_ue_uf, se.sg_ue_mun,'BR')
LEFT JOIN cargo cg
ON cg.cd_eleicao = va.cd_eleicao
   AND cg.cd_cargo = va.cd_cargo_pergunta
LEFT JOIN pergunta pe
ON pe.cd_pleito = se.cd_pleito
   AND pe.cd_eleicao = se.cd_eleicao
   AND pe.cd_pergunta = va.cd_cargo_pergunta
LEFT JOIN voto_secao vs
     ON vs.cd_pleito = se.cd_pleito
     AND vs.cd_eleicao = se.cd_eleicao
     AND vs.sg_ue_uf = se.sg_ue_uf
     AND vs.sg_ue_mun = se.sg_ue_mun
     AND vs.sg_ue = va.sg_ue
     AND vs.nr_zona = se.nr_zona
     AND vs.nr_secao = se.nr_secao
     AND vs.cd_cargo_pergunta = va.cd_cargo_pergunta
LEFT JOIN votavel vt
ON vt.cd_pleito = vs.cd_pleito
   AND vt.cd_eleicao = vs.cd_eleicao
   AND vt.sg_ue_uf IN (vs.sg_ue_uf,'BR')
   AND vt.sg_ue = vs.sg_ue
   AND vt.cd_cargo_pergunta = vs.cd_cargo_pergunta
   AND vt.nr_votavel = vs.nr_votavel
LEFT JOIN tipo_votavel tvd
     ON vt.cd_tipo_votavel_destinacao = tvd.cd_tipo_votavel
LEFT JOIN candidato ca
ON ca.cd_pleito = vt.cd_pleito
   AND ca.cd_eleicao = vt.cd_eleicao
   AND ca.sg_ue_uf = vt.sg_ue_uf
   AND ca.sg_ue = vt.sg_ue
   AND ca.cd_cargo = vt.cd_cargo_pergunta
   AND ca.nr_cand = vt.nr_votavel
	 AND ca.sq_cand_substituido IS NULL
LEFT JOIN resposta re
ON re.cd_pleito = vt.cd_pleito
   AND re.cd_eleicao = vt.cd_eleicao
   AND re.sg_ue_uf = vt.sg_ue_uf
   AND re.sg_ue = vt.sg_ue
   AND re.cd_pergunta = vt.cd_cargo_pergunta
   AND re.nr_resposta = vt.nr_votavel
LEFT JOIN situacao_candidato sc
ON sc.cd_situacao_candidato = ca.cd_situacao_candidato_atual;
