CREATE OR REPLACE VIEW vw_091_acompanhar_totalizacao_parcial_concluidos
AS
    SELECT cd_pleito,
           cd_eleicao,
           sg_ue_uf,
           l.sg_ue_mun,
           u.nm_ue,
           TO_DATE(TO_CHAR(ts_log_ini_hor_loc, 'DD/MM/YYYY HH24:MI:SS'), 'DD/MM/YYYY HH24:MI:SS') inicio_local,
           TO_DATE(TO_CHAR(ts_log_ini_hor_tse, 'DD/MM/YYYY HH24:MI:SS'), 'DD/MM/YYYY HH24:MI:SS') inicio_tse,
           TRIM(TO_CHAR(EXTRACT(DAY FROM (ts_log_fim_hor_tse - ts_log_ini_hor_tse)) * 24, '9900'))||
           ':' ||
           TO_CHAR(EXTRACT(MINUTE FROM (ts_log_fim_hor_tse - ts_log_ini_hor_tse)), '00')||
           ':' ||
           TO_CHAR(TRUNC(EXTRACT(SECOND FROM (ts_log_fim_hor_tse - ts_log_ini_hor_tse))), '00')
               tempo_execucao
      FROM log_totalizacao l, ue u
     WHERE l.sg_ue_mun = u.sg_ue
       and l.tx_log in ('Totalização Parcial', 'Totalização Abrangência Estadual');