CREATE OR REPLACE VIEW vw_108_consultar_evolucao_parciais
AS
    SELECT hvp.cd_pleito,
           hvp.sg_ue_uf,
           hvp.cd_eleicao,
           DECODE(hvp.sg_ue, hvp.sg_ue_uf, NULL, hvp.sg_ue) sg_ue_mun,
           hvp.cd_cargo_pergunta,
           hvp.nr_votavel nr_cand_resp,
           cand_resp.nm_cand_resp nm_cand_resp,
           hvp.ts_calculo ts_bu_recebido,
           TRUNC(
                 SUM(hvp.qt_votos)
                     OVER(
                 PARTITION BY hvp.cd_pleito,
                 hvp.sg_ue_uf,
                 hvp.cd_eleicao,
                 hvp.sg_ue,
                 hvp.cd_cargo_pergunta,
                 hvp.ts_calculo,
                 hvp.nr_votavel
                         ) / SUM(hvp.qt_votos)
                     OVER    (
                 PARTITION BY hvp.cd_pleito,
                 hvp.sg_ue_uf,
                 hvp.cd_eleicao,
                 hvp.sg_ue,
                 hvp.cd_cargo_pergunta,
                 hvp.ts_calculo
                             ) * 100,
                 2
                )
               pe_votos_cand_resposta,
							 vt.ds_cor_grafico
      FROM historico_votacao_parcial hvp
           JOIN (SELECT c.cd_pleito,
                        c.cd_eleicao,
                        c.cd_cargo cd_cargo_pergunta,
                        c.sg_ue_uf,
                        c.sg_ue,
                        c.nr_cand nr_votavel,
                        c.nm_cand_urna nm_cand_resp
                   FROM candidato c
                 UNION
                 SELECT r.cd_pleito,
                        r.cd_eleicao,
                        r.cd_pergunta,
                        r.sg_ue_uf,
                        r.sg_ue,
                        r.nr_resposta,
                        r.nm_resposta
                   FROM resposta r) cand_resp
               ON cand_resp.cd_pleito = hvp.cd_pleito
              AND cand_resp.cd_eleicao = hvp.cd_eleicao
              AND cand_resp.sg_ue_uf = hvp.sg_ue_uf
              AND cand_resp.sg_ue = hvp.sg_ue
              AND cand_resp.cd_cargo_pergunta = hvp.cd_cargo_pergunta
              AND cand_resp.nr_votavel = hvp.nr_votavel
						 JOIN votavel vt
						      ON hvp.cd_pleito = vt.cd_pleito
									AND hvp.cd_eleicao = vt.cd_eleicao
									AND hvp.sg_ue_uf = vt.sg_ue_uf
									AND hvp.sg_ue = vt.sg_ue
									AND hvp.cd_cargo_pergunta = vt.cd_cargo_pergunta
									AND hvp.nr_votavel = vt.nr_votavel;