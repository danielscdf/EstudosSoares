CREATE OR REPLACE VIEW VW_038_CONSULTAR_BU_REJEITADO
AS
SELECT rj.cd_pleito,
       rj.cd_tipo_arquivo_recebido,
       rj.sq_rejeicao,
       ue.cd_tipo_ue,
       rj.sg_ue_uf,
       rj.sg_ue_mun,
			 ue.nm_ue nm_municipio,
			 rj.nr_zona,
			 rj.nr_secao_mesa,
             rj.dt_rejeicao_hor_tse,
             rj.dt_rejeicao_hor_loc,
			 rj.ds_erro,
			 rj.cd_tipo_rejeicao,
			 tr.nm_tipo_rejeicao
FROM rejeicao rj
INNER JOIN pleito p
      ON rj.cd_pleito = p.cd_pleito
INNER JOIN ue_processo ue
      ON rj.sg_ue_mun = ue.sg_ue
      AND p.cd_processo_eleitoral = ue.cd_processo_eleitoral
INNER JOIN tipo_rejeicao tr
      ON rj.cd_tipo_rejeicao = tr.cd_tipo_rejeicao
INNER JOIN tipo_arquivo_recebido ta
      ON rj.cd_tipo_arquivo_recebido = ta.cd_tipo_arquivo_recebido
      AND ta.cd_conteudo_arquivo = 1;
