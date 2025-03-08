CREATE OR REPLACE VIEW vw_063_audit_arquivo_urna
AS
SELECT ar.cd_pleito,
       ar.sg_ue_uf,
       ar.sg_ue_mun,
       ue.nm_ue,
       ar.nr_zona,
       ar.nr_secao,
       ip.nm_pacote,
       ip.ts_transmissao_pacote,
       ip.nr_versao_transp,
       ip.nr_ip_origem,
       ip.id_usuario,
       ip.nm_sistema_operacional,
       ip.nm_navegador,
       ap.nm_arquivo,
			 ap.sq_arquivo_pacote,
       ap.ts_geracao_arquivo,
       ap.ts_leitura_arquivo,
       ar.ts_recebimento_hor_loc
FROM arquivo_recebido ar
INNER JOIN informacoes_pacote ip
      ON ip.cd_pleito = ar.cd_pleito
			AND ip.sg_ue_uf = ar.sg_ue_uf
			AND ip.sq_arquivo_recebido = ar.sq_arquivo_recebido
INNER JOIN arquivo_pacote ap
      ON ap.cd_pleito = ar.cd_pleito
			AND ap.sg_ue_uf = ar.sg_ue_uf
			AND ap.sq_informacoes_pacote = ip.sq_informacoes_pacote
INNER JOIN pleito p
      ON ar.cd_pleito = p.cd_pleito
INNER JOIN ue
      ON ue.sg_ue_superior = ar.sg_ue_uf
      AND ue.sg_ue = ar.sg_ue_mun;