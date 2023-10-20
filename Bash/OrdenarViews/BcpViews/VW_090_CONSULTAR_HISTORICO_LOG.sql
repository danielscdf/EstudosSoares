CREATE OR REPLACE VIEW vw_090_consultar_historico_log
AS
    SELECT l.cd_processo_eleitoral,
           l.cd_pleito,
           l.sg_ue_uf,
           l.nr_zona,
           l.tx_log
      FROM admtotcentral.log_geral_sistema l
     WHERE l.cd_tipo_log_sistema = 233;