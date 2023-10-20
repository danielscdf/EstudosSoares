CREATE OR REPLACE VIEW vw_085_exp_corresp_efetivada
AS
    SELECT pl.cd_pleito,
           pl.sg_ue_uf,
           pl.sg_ue_mun,
           UP.nm_ue,
           pl.nr_zona,
           LPAD(pl.nr_secao, 4, '0')
               nr_secao,
           ov.sg_ori_votos,
           ov.nm_ori_votos,
           ov.cd_ori_votos,
           co.nr_urna,
           pc_ad_correspondencia.fc_formata(cd_carga_urna, '.', 3)
               codigo_carga,
           SUBSTR(co.cd_carga_urna, LENGTH(co.cd_carga_urna) - 5, 6)
               cd_final_cd_carga_urna,
           TO_CHAR(co.dt_carga_urna, 'dd/mm/yyyy hh24:mi:ss')
               dt_carga_urna,
           co.cd_flash_card,
           CASE
               WHEN ((co.tp_correspondencia_origem = 'C')
                 AND (NVL(pl.sq_corresp_esperada, 0) <>
                      NVL(pl.sq_corresp_efetivada, 0))) THEN
                   '**'
               WHEN ((NVL(pl.sq_corresp_esperada, 0) <>
                      NVL(pl.sq_corresp_efetivada, 0))
                 AND (pl.cd_ori_votos <> 'T')) THEN
                   '*'
               WHEN (pl.cd_tipo_urna IN (2,
                                         3,
                                         4,
                                         5)) --(NVL (PL.SQ_CORRESP_EFETIVADA, 0) = 0)
                                             THEN
                   '***'
               ELSE
                   ''
           END
               AS divergencia
      FROM secao_pleito pl
           JOIN pleito p
               ON pl.cd_pleito = p.cd_pleito
              AND pl.cd_processo_eleitoral = p.cd_processo_eleitoral
           JOIN ue_processo UP
               ON p.cd_processo_eleitoral = UP.cd_processo_eleitoral
              AND pl.sg_ue_mun = UP.sg_ue
              AND pl.sg_ue_uf = UP.sg_ue_superior
           INNER JOIN correspondencia co
               ON pl.cd_processo_eleitoral = co.cd_processo_eleitoral
              AND pl.sg_ue_uf = co.sg_ue_uf
              AND pl.sq_corresp_efetivada = co.sq_corresp
           LEFT JOIN origem_votos ov ON ov.cd_ori_votos = pl.cd_ori_votos
           LEFT JOIN tipo_urna tu ON tu.cd_tipo_urna = pl.cd_tipo_urna;