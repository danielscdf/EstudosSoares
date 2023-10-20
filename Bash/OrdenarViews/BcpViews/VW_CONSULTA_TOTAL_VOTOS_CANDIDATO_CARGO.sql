/* Formatted on 13/04/2021 11:18:18 (QP5 v5.252.13127.32847) */
CREATE OR REPLACE VIEW vw_consulta_total_votos_candidato_cargo
AS
     SELECT SUM (NVL (vmz.qt_votos_totalizados, 0)) qt_total_votos_totalizados,
            vmz.cd_eleicao,
            vmz.sg_ue_uf,
            vmz.sg_ue_mun,
            c.sq_candidato,
            vmz.nr_votavel,
            vmz.cd_cargo_pergunta,
						c.cd_situacao_totalizacao,
						st.nm_situacao_totalizacao,
						c.sq_ordem_suplencia
       FROM voto_mun_zona vmz
            JOIN candidato c
               ON (    c.cd_pleito = vmz.cd_pleito
                   AND c.cd_eleicao = vmz.cd_eleicao
                   AND c.sg_ue = vmz.sg_ue_mun
                   AND c.sg_ue_uf = vmz.sg_ue_uf
                   AND c.nr_cand = vmz.nr_votavel
                   AND c.cd_cargo = vmz.cd_cargo_pergunta)
						JOIN situacao_totalizacao st
						     ON c.cd_situacao_totalizacao = st.cd_situacao_totalizacao
   GROUP BY vmz.cd_eleicao,
            vmz.sg_ue_uf,
            vmz.sg_ue_mun,
            c.sq_candidato,
            vmz.nr_votavel,
            vmz.cd_cargo_pergunta,
						c.cd_situacao_totalizacao,
						st.nm_situacao_totalizacao,
						c.sq_ordem_suplencia;