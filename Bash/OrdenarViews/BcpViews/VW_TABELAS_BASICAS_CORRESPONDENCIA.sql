CREATE OR REPLACE VIEW vw_tabelas_basicas_correspondencia
AS
    SELECT p.cd_pleito,
           c.sg_ue_uf,
           c.sg_ue_mun_atual,
           c.nr_zona_atual,
           NVL(TO_CHAR(c.nr_secao_atual), 'Contingência') nr_secao,
           c.nr_urna,
           c.cd_carga_urna,
           c.cd_flash_card,
           TO_CHAR(dt_carga_urna, 'dd/mm/yyyy hh24:mi:ss') dt_carga_urna
      FROM correspondencia c
           JOIN pleito p ON c.cd_processo_eleitoral = p.cd_processo_eleitoral
     WHERE c.cd_situacao_correspondencia = 1;