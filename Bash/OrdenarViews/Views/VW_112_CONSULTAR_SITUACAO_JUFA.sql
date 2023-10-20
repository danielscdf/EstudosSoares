CREATE OR REPLACE VIEW VW_112_CONSULTAR_SITUACAO_JUFA AS
SELECT
    ar.cd_pleito,
    ar.sg_ue_uf,
    ar.sg_ue_mun,
    ue.nm_ue,
    ar.nr_zona,
    ar.nr_secao,
    ar.ts_recebimento_hor_loc,
    ar.ts_sincronizacao,
    ar.dt_processamento_jufa,
	pc_utl_data_hora.fc_horario_local(pl.cd_processo_eleitoral ,ar.sg_ue_mun, ar.ts_sincronizacao) dt_sincronizacao_local
FROM
    arquivo_recebido ar
	JOIN pleito pl on (ar.cd_pleito = pl.cd_pleito)
    JOIN ue ON ( ar.sg_ue_mun = ue.sg_ue )
WHERE
    ar.cd_tipo_arquivo_recebido = 18
    AND   ar.cd_situacao_arquivo = 'v';