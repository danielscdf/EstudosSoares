CREATE OR REPLACE VIEW vw_027_consultar_corresp_rejeitada
AS
      SELECT c.cd_processo_eleitoral,
             hc.cd_pleito,
             c.sg_ue_uf,
             c.sg_ue_mun_atual,
             up.nm_ue,
             c.nr_zona_atual,
             c.nr_mesa,
             lpad(c.nr_urna_mrj, 8, '0') nr_urna_mrj,
             lpad(c.nr_secao_atual, 4, '0') nr_secao,
             to_char(c.dt_receb_corresp_hor_tse, 'DD/MM/YYYY HH24:MI:SS') dt_receb_corresp_hor_tse,
             to_char(c.dt_receb_corresp_hor_loc, 'DD/MM/YYYY HH24:MI:SS') dt_receb_corresp_hor_loc,
             c.nr_urna,
             pc_ad_correspondencia.fc_formata(c.cd_carga_urna, '.', 3) codigo_carga,
             to_char(c.dt_carga_urna, 'DD/MM/YYYY HH24:MI:SS') dt_carga_urna,
             c.cd_flash_card,
             to_char(c.dt_receb_gedai, 'DD/MM/YYYY HH24:MI:SS') dt_receb_gedai,
             hc.cd_tipo_controle_corresp,
             tcc.nm_tipo_controle_corresp,
             'S' st_corresp_rejeitada,
             c.tp_correspondencia_atual,
             decode(c.tp_correspondencia_atual, 'S', 'Seção', 'C', 'Contingência', '') nm_tipo_correspondencia_atual
      FROM correspondencia c
      INNER JOIN historico_correspondencia hc
         ON hc.cd_processo_eleitoral = c.cd_processo_eleitoral
         AND hc.sq_corresp = c.sq_corresp
      INNER JOIN tipo_controle_correspondencia tcc
         ON tcc.cd_tipo_controle_corresp = hc.cd_tipo_controle_corresp
      INNER JOIN situacao_correspondencia scc
         ON scc.cd_situacao_correspondencia = tcc.cd_situacao_correspondencia
				 AND scc.cd_situacao_correspondencia = 2
      JOIN ue_processo up
         ON c.cd_processo_eleitoral = up.cd_processo_eleitoral
         AND c.sg_ue_mun_atual = up.sg_ue
         AND c.sg_ue_uf = up.sg_ue_superior;
/
