CREATE OR REPLACE VIEW vw_091_acompanhar_totalizacao_parcial_fila
AS
    SELECT a.cd_pleito,
           a.cd_eleicao,
           a.nr_nivel_prioridade,
           a.sg_ue_uf,
           aa.siglamun,
           u.nm_ue,
           TO_CHAR(EXTRACT(DAY FROM (SYSTIMESTAMP - ts_criacao_registro)) * 24, '00')||
           ':' ||
           TO_CHAR(EXTRACT(MINUTE FROM (SYSTIMESTAMP - ts_criacao_registro)), '00')||
           ':' ||
           TO_CHAR(TRUNC(EXTRACT(SECOND FROM (SYSTIMESTAMP - ts_criacao_registro))), '00')
               tempo_fila,
           ts_inicio_totalizacao,
           DECODE(
                  ts_inicio_totalizacao,
                  NULL, NULL,
                  TO_CHAR(EXTRACT(DAY FROM (SYSTIMESTAMP - ts_inicio_totalizacao)) * 60 * 24, '00')||
                  ':' ||
                  TO_CHAR(EXTRACT(MINUTE FROM (SYSTIMESTAMP - ts_inicio_totalizacao)), '00')||
                  ':' ||
                  TO_CHAR(TRUNC(EXTRACT(SECOND FROM (SYSTIMESTAMP - ts_inicio_totalizacao))), '00')
                 )
               tempo_execucao
      FROM fila_totalizacao a, TABLE(a.sg_ue_mun_list) aa, ue u
     WHERE u.sg_ue = aa.siglamun;