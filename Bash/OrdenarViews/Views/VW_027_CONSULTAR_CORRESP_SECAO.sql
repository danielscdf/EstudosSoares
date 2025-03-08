CREATE OR REPLACE VIEW vw_027_consultar_corresp_secao
AS
    SELECT pl.cd_processo_eleitoral,
           pl.cd_pleito,
           pl.sg_ue_uf,
           pl.sg_ue_mun,
           UP.nm_ue,
           pl.nr_zona,
           co.nr_mesa,
           LPAD(co.nr_urna, 8, '0') nr_urna_formatado,
           LPAD(pl.nr_secao, 4, '0') nr_secao,
           TO_CHAR(co.dt_receb_corresp_hor_tse, 'DD/MM/YYYY HH24:MI:SS') dt_receb_corresp_hor_tse,
           TO_CHAR(co.dt_receb_corresp_hor_loc, 'DD/MM/YYYY HH24:MI:SS') dt_receb_corresp_hor_loc,
           co.nr_urna,
           pc_ad_correspondencia.fc_formata(co.cd_carga_urna, '.', 3) codigo_carga,
           TO_CHAR(co.dt_carga_urna, 'DD/MM/YYYY HH24:MI:SS') dt_carga_urna,
           co.cd_flash_card,
           TO_CHAR(co.dt_receb_gedai, 'DD/MM/YYYY HH24:MI:SS') dt_receb_gedai,
           co.tp_correspondencia_atual,
           decode(co.tp_correspondencia_atual,'S','Seção') nm_correspondencia_atual,
           CAST(CASE WHEN co.sq_corresp IS NULL THEN 'N' ELSE 'R' END AS VARCHAR2(1)) st_correspondencia,
           lv.nr_local,
           lv.nm_local,
           lv.ds_endereco
      FROM secao_pleito pl
       JOIN ue_processo UP
           ON pl.cd_processo_eleitoral = UP.cd_processo_eleitoral
          AND pl.sg_ue_uf = UP.sg_ue_superior
          AND pl.sg_ue_mun = UP.sg_ue
       LEFT JOIN correspondencia co
           ON pl.cd_processo_eleitoral = co.cd_processo_eleitoral
          AND pl.sg_ue_uf = co.sg_ue_uf
          AND pl.sq_corresp_esperada = co.sq_corresp
          AND co.cd_situacao_correspondencia = 1
					AND co.tp_correspondencia_atual = 'S'
       JOIN secao_processo sp
           ON sp.cd_processo_eleitoral = pl.cd_processo_eleitoral
          AND sp.sg_ue_uf = pl.sg_ue_uf
          AND sp.sg_ue_mun = pl.sg_ue_mun
          AND sp.nr_zona = pl.nr_zona
          AND sp.nr_secao = pl.nr_secao
       JOIN local_votacao lv
           ON lv.cd_processo_eleitoral = sp.cd_processo_eleitoral
          AND lv.sg_ue_uf = sp.sg_ue_uf
          AND lv.sg_ue_mun = sp.sg_ue_mun
          AND lv.nr_zona = sp.nr_zona
          AND lv.nr_local = sp.nr_local;
/
