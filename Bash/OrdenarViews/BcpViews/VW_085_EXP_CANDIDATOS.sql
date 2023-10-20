/* Formatted on 12/11/2020 11:03:40 (QP5 v5.252.13127.32847) */
CREATE OR REPLACE VIEW vw_085_exp_candidatos
AS
   SELECT c.cd_pleito,
          c.cd_eleicao,
          c.sg_ue,
					ue.nm_ue,
          c.cd_cargo,
          c.sq_candidato,
          c.nr_cand,
          c.nr_partido,
          c.nm_cand_urna,
					c.dt_nascimento,
          c.cd_situacao_candidato_atual,
          c.cd_situacao_candidato_importa,
          c.cd_situacao_candidato_eleicao,
          c.cd_situacao_totalizacao,
					s.nm_sexo,
					td.nm_tipo_decisao_judicial,
					tv.nm_tipo_destinacao_votos
     FROM candidato c
		INNER JOIN pleito p
					ON c.cd_pleito = p.cd_pleito
		INNER JOIN ue_processo ue
					ON p.cd_processo_eleitoral = ue.cd_processo_eleitoral
					AND c.sg_ue = ue.sg_ue
		INNER JOIN sexo s
		      ON c.cd_sexo = s.cd_sexo
		LEFT JOIN tipo_decisao_judicial td
		     ON c.cd_tipo_decisao_judicial = td.cd_tipo_decisao_judicial
		INNER JOIN votavel vt
		      ON vt.cd_pleito = c.cd_pleito
					AND vt.cd_eleicao = c.cd_eleicao
					AND vt.sg_ue_uf = c.sg_ue_uf
					AND vt.sg_ue = c.sg_ue
					AND vt.cd_cargo_pergunta = c.cd_cargo
					AND vt.nr_votavel = c.nr_cand
		LEFT JOIN tipo_votavel tv
		     ON tv.cd_tipo_votavel = vt.cd_tipo_votavel_destinacao;