CREATE OR REPLACE VIEW vw_027_consultar_corresp_efetivada AS
SELECT pl.Cd_Processo_Eleitoral,
       pl.cd_pleito,
       pl.sg_ue_uf,
       pl.sg_ue_mun,
       up.nm_ue,
       pl.nr_zona,
       lpad(pl.nr_secao, 4, '0') nr_secao,
       co.nr_urna,
       pc_ad_correspondencia.fc_formata(co.cd_carga_urna, '.', 3) codigo_carga,
       pl.sq_corresp_esperada,
       pl.sq_corresp_efetivada,
       to_char(co.dt_carga_urna, 'DD/MM/YYYY HH24:MI:SS') dt_carga_urna,
       co.cd_flash_card,
       co.tp_correspondencia_atual,
       decode(co.tp_correspondencia_atual, 'S', 'Seção', 'C', 'Contingência', '') nm_tipo_correspondencia_atual,
       pl.cd_tipo_urna,
       ov.sg_ori_votos,
       ov.nm_ori_votos,
       ov.cd_ori_votos,
       CASE
           WHEN ((co.tp_correspondencia_atual = 'C') AND (nvl(pl.sq_corresp_esperada, 0) <> nvl(pl.sq_corresp_efetivada, 0))) THEN
            '**'
           WHEN ((nvl(pl.sq_corresp_esperada, 0) <> nvl(pl.sq_corresp_efetivada, 0)) AND (pl.cd_ori_votos <> 'T')) THEN
            '*'
           ELSE
            ''
       END AS divergencia
FROM secao_pleito PL
JOIN ue_processo up
   ON pl.cd_processo_eleitoral = up.cd_processo_eleitoral
   AND pl.sg_ue_uf = up.sg_ue_superior
   AND pl.sg_ue_mun = up.sg_ue
INNER JOIN correspondencia co
   ON pl.cd_processo_eleitoral = co.cd_processo_eleitoral
   AND pl.sg_ue_uf = co.sg_ue_uf
   AND pl.sq_corresp_efetivada = co.sq_corresp
LEFT JOIN origem_votos ov
   ON ov.cd_ori_votos = pl.cd_ori_votos
LEFT JOIN tipo_urna tu
   ON tu.cd_tipo_urna = pl.cd_tipo_urna;
/
