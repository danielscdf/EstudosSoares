CREATE OR REPLACE VIEW vw_090_consultar_historico
AS
    SELECT c.cd_pleito,
           c.sq_corresp,
           co.sg_ue_uf,
           c.sg_ue_mun_atual,
           UP.nm_ue,
           c.nr_zona_atual,
           DECODE(
                  co.nr_mesa,
                  NULL, LPAD(c.nr_secao_atual, 4, '0'),
                  co.nr_mesa ||
                  '/' ||
                  co.nr_urna
                 )
               nr_secao,
           TO_CHAR(c.dt_receb_corresp_hor_tse, 'DD/MM/YYYY HH24:MI:SS')
               dt_receb_corresp_hor_tse_formatada,
           TO_CHAR(c.dt_receb_corresp_hor_loc, 'DD/MM/YYYY HH24:MI:SS')
               dt_receb_corresp_hor_loc_formatada,
           c.dt_receb_corresp_hor_tse,
           c.dt_receb_corresp_hor_loc,
           co.nr_urna,
           pc_ad_correspondencia.fc_formata(co.cd_carga_urna, '.', 3)
               codigo_carga,
           TO_CHAR(co.dt_carga_urna, 'DD/MM/YYYY HH24:MI:SS')
               dt_carga_urna_formatada,
           co.dt_carga_urna,
           co.cd_flash_card,
           TO_CHAR(c.dt_receb_gedai, 'DD/MM/YYYY HH24:MI:SS')
               dt_receb_gedai_formatada,
           c.dt_receb_gedai,
           tc.cd_tipo_controle_corresp,
           tc.nm_tipo_controle_corresp,
           sc.cd_situacao_correspondencia,
           sc.nm_situacao_correspondencia,
           TO_CHAR(c.dt_historico_corresp_hor_loc, 'DD/MM/YYYY HH24:MI:SS')
               dt_historico_corresp_hor_loc_formatada,
           c.dt_historico_corresp_hor_loc,
           TO_CHAR(c.dt_historico_corresp_hor_tse, 'DD/MM/YYYY HH24:MI:SS')
               dt_historico_corresp_hor_tse_formatada,
           c.dt_historico_corresp_hor_tse,
           DECODE(
                  c.tp_correspondencia_atual,
                  'S', 'Seção',
                  'C', 'Contingência',
                  'M', 'MRJ',
                  ''
                 )
               tp_ue,
           DECODE(c.st_corresp_digitada,  'S', 'Sim',  'N', 'Não',  '')
               digitada,
           TO_CHAR(c.dt_atribuicao_secao_hor_loc, 'DD/MM/YYYY HH24:MI:SS')
               dt_atribuicao_secao_hor_loc_formatada,
           TO_CHAR(c.dt_atribuicao_secao_hor_tse, 'DD/MM/YYYY HH24:MI:SS')
               dt_atribuicao_secao_hor_tse_formatada,
           c.dt_atribuicao_secao_hor_loc,
           c.dt_atribuicao_secao_hor_tse,
           pc_ad_pleito.fc_retorna_ordem_pleito(p.cd_pleito)
               AS nr_turno
      FROM admtotcentral.historico_correspondencia c
           JOIN admtotcentral.correspondencia co
               ON c.sq_corresp = co.sq_corresp
           JOIN admtotcentral.pleito p ON c.cd_pleito = p.cd_pleito
           JOIN admtotcentral.ue_processo UP
               ON co.cd_processo_eleitoral = UP.cd_processo_eleitoral
              AND co.sg_ue_mun_atual = UP.sg_ue
              AND co.sg_ue_uf = UP.sg_ue_superior
           JOIN admtotcentral.tipo_controle_correspondencia tc
               ON c.cd_tipo_controle_corresp = tc.cd_tipo_controle_corresp
           JOIN admtotcentral.situacao_correspondencia sc
               ON sc.cd_situacao_correspondencia =
                  tc.cd_situacao_correspondencia;