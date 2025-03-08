CREATE OR REPLACE VIEW vw_102_historico_corresp_bu
AS
SELECT DISTINCT hc.cd_pleito,
       hc.sg_ue_uf,
       hc.sg_ue_mun,
       ue.nm_ue,
       hc.nr_zona,
       hc.nr_secao,
       hc.sg_ue_mun_bu,
       hc.nr_zona_bu,
       hc.nr_secao_bu,
       hc.tp_carga_urna,
       decode(hc.tp_carga_urna,1,UNISTR('Se\00E7\00E3o'), 2,UNISTR('Urna de conting\00EAncia')) nm_tipo_carga,
       hc.nr_urna,
       pc_ad_correspondencia.fc_formata(hc.cd_carga_urna, '.', 3) cd_carga_urna,
       hc.cd_flash_card,
       hc.dt_carga_urna,
       co.sq_corresp,
       decode(sp.nr_hash_bu,'',UNISTR('N\00E3o'),'Sim') st_efetivada,
       e.nr_turno
FROM historico_correspondencia_bu hc
INNER JOIN pleito p
      ON hc.cd_pleito = p.cd_pleito
INNER JOIN eleicao e
      ON p.cd_pleito = e.cd_pleito
INNER JOIN ue_processo ue
      ON ue.cd_processo_eleitoral = p.cd_processo_eleitoral
      AND ue.sg_ue = hc.sg_ue_mun_bu
LEFT JOIN correspondencia co
      ON co.cd_processo_eleitoral = p.cd_processo_eleitoral
      AND co.sg_ue_uf = hc.sg_ue_uf
      AND co.cd_carga_urna = hc.cd_carga_urna
      AND co.nr_urna = hc.nr_urna
LEFT JOIN secao_pleito sp
     ON sp.cd_pleito = hc.cd_pleito
     AND sp.sg_ue_uf = hc.sg_ue_uf
     AND sp.sq_corresp_efetivada = co.sq_corresp;
