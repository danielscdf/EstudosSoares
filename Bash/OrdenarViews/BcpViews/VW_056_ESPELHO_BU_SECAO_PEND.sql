CREATE OR REPLACE VIEW vw_056_espelho_bu_secao_pend
AS
    SELECT sp.cd_processo_eleitoral,
           pe.nm_processo_eleitoral,
           TO_CHAR(p.dt_pleito, 'DD/MM/YYYY') dt_pleito,
           spl.cd_pleito,
           sp.sg_ue_uf,
           sp.sg_ue_mun,
           sp.sg_ue_mun ||
           ' - ' ||
           UP.nm_ue
               municipio,
           sp.nr_zona,
           lv.nr_local,
           LPAD(sp.nr_secao, 4, '0') nr_secao,
           v_secao_agregada.secoes_agregadas,
           v_secao_agregada.qtd_secoes_agregadas,
           spl.nr_junta_apuradora,
           spl.nr_turma_apuradora,
           spl.qt_eleitores_bio_lib_codigo,                                                                                                                                                                                               --HABILITADOS POR ANO DE NASCIMENTO - Confirmar se ? a mesma informa??o
           coef.nr_urna cd_identificacao_ue_efet,
           coes.nr_urna cd_identificacao_ue_esp,
           TO_CHAR(spl.dt_abertura, 'DD/MM/YYYY') dt_abertura_ue,
           TO_CHAR(spl.dt_abertura, 'HH24:MI:SS') hr_abertura_ue,
           TO_CHAR(spl.dt_encerramento, 'DD/MM/YYYY') dt_fechamento_ue,
           TO_CHAR(spl.dt_encerramento, 'HH24:MI:SS') hr_fechamento_ue,
           TO_CHAR(spl.dt_geracao_arquivo, 'DD/MM/YYYY') dt_geracao_arquivo,
           TO_CHAR(spl.dt_geracao_arquivo, 'HH24:MI:SS') hr_geracao_arquivo,
           TO_CHAR(spl.dt_pendencia_hor_loc, 'DD/MM/YYYY') dt_recebimento_hor_loc,
           TO_CHAR(spl.dt_pendencia_hor_loc, 'HH24:MI:SS') hr_recebimento_hor_loc,
           TO_CHAR(spl.dt_pendencia_hor_tse, 'DD/MM/YYYY') dt_recebimento_hor_tse,
           TO_CHAR(spl.dt_pendencia_hor_tse, 'HH24:MI:SS') hr_recebimento_hor_tse,
           TO_CHAR(spl.dt_tratamento_pend_hor_loc, 'DD/MM/YYYY') dt_tratamento_hor_loc,
           TO_CHAR(spl.dt_tratamento_pend_hor_loc, 'HH24:MI:SS') hr_tratamento_hor_loc,
           TO_CHAR(spl.dt_tratamento_pend_hor_tse, 'DD/MM/YYYY') dt_tratamento_hor_tse,
           TO_CHAR(spl.dt_tratamento_pend_hor_tse, 'HH24:MI:SS') hr_tratamento_hor_tse,
           TO_CHAR(spl.ts_emissao_bu, 'DD/MM/YYYY') dt_emissao,
           TO_CHAR(spl.ts_emissao_bu, 'HH24:MI:SS') hr_emissao,
           coef.cd_flash_card cd_flash_card_efet,
           coes.cd_flash_card cd_flash_card_esp,
           SUBSTR(TO_CHAR(coef.cd_carga_urna, '000G000G000G000G000G000G000G000'), 1, 32) cd_carga_urna_efet,
           SUBSTR(TO_CHAR(coes.cd_carga_urna, '000G000G000G000G000G000G000G000'), 1, 32) cd_carga_urna_esp,
           TO_CHAR(coef.dt_carga_urna, 'DD/MM/YYYY') dt_carga_efet,
           TO_CHAR(coes.dt_carga_urna, 'DD/MM/YYYY') dt_carga_esp,
           TO_CHAR(coef.dt_carga_urna, 'HH24:MI:SS') hr_carga_efet,
           TO_CHAR(coes.dt_carga_urna, 'HH24:MI:SS') hr_carga_esp,
           ov.nm_ori_votos,
           ov.sg_ori_votos,
           ov.cd_ori_votos,
           tu.nm_tipo_urna,
           SUBSTR(TO_CHAR(coef.cd_carga_urna, '000G000G000G000G000G000G000G000'), 26, 32) cd_resumo_correspondencia_efet,
           SUBSTR(TO_CHAR(coes.cd_carga_urna, '000G000G000G000G000G000G000G000'), 26, 32) cd_resumo_correspondencia_esp,
           spl.sq_pendencia_secao_pleito,
           spl.st_pendencia situacao_pendencia,
           pc_ad_tipo_pend_secao_pleito.fc_monta_mensagem_pendencia(p_sq_pendencia_secao_pleito => spl.sq_pendencia_secao_pleito, p_cd_pleito => spl.cd_pleito) mensagem,
           spl.ds_motivo
      FROM secao_processo sp
           JOIN pendencia_secao_pleito spl
               ON sp.cd_processo_eleitoral = spl.cd_processo_eleitoral
              AND sp.sg_ue_uf = spl.sg_ue_uf
              AND sp.sg_ue_mun = spl.sg_ue_mun
              AND sp.nr_zona = spl.nr_zona
              AND sp.nr_secao = spl.nr_secao
           LEFT JOIN (  SELECT spa.cd_processo_eleitoral,
                               spa.nr_secao_principal,
                               spa.sg_ue_uf,
                               spa.sg_ue_mun,
                               spa.nr_zona,
                               COUNT(1) qtd_secoes_agregadas,
                               LISTAGG(LPAD(spa.nr_secao, 4, 0), ' / ') WITHIN GROUP (ORDER BY spa.nr_secao) secoes_agregadas
                          FROM secao_processo spa
                         WHERE spa.nr_secao_principal IS NOT NULL
                      GROUP BY spa.cd_processo_eleitoral,
                               spa.nr_secao_principal,
                               spa.sg_ue_uf,
                               spa.sg_ue_mun,
                               spa.nr_zona) v_secao_agregada
               ON v_secao_agregada.cd_processo_eleitoral = sp.cd_processo_eleitoral
              AND v_secao_agregada.sg_ue_mun = sp.sg_ue_mun
              AND v_secao_agregada.sg_ue_uf = sp.sg_ue_uf
              AND v_secao_agregada.nr_zona = sp.nr_zona
              AND v_secao_agregada.nr_secao_principal = sp.nr_secao
           JOIN processo_eleitoral pe ON sp.cd_processo_eleitoral = pe.cd_processo_eleitoral
           JOIN pleito p ON p.cd_pleito = spl.cd_pleito
           JOIN local_votacao lv
               ON (sp.cd_processo_eleitoral = lv.cd_processo_eleitoral
               AND sp.sg_ue_uf = lv.sg_ue_uf
               AND sp.sg_ue_mun = lv.sg_ue_mun
               AND sp.nr_zona = lv.nr_zona
               AND sp.nr_local = lv.nr_local)
           LEFT JOIN correspondencia coef
               ON coef.cd_processo_eleitoral = spl.cd_processo_eleitoral
              AND coef.sg_ue_uf = spl.sg_ue_uf
              AND coef.sq_corresp = spl.sq_corresp
           LEFT JOIN secao_pleito sep
               ON sep.cd_pleito = spl.cd_pleito
              AND sep.sg_ue_uf = spl.sg_ue_uf
              AND sep.sg_ue_mun = spl.sg_ue_mun
              AND sep.nr_zona = spl.nr_zona
              AND sep.nr_secao = spl.nr_secao
           LEFT JOIN correspondencia coes
               ON coes.cd_processo_eleitoral = sep.cd_processo_eleitoral
              AND coes.sg_ue_uf = sep.sg_ue_uf
              AND coes.sq_corresp = sep.sq_corresp_esperada
           JOIN ue_processo UP
               ON UP.cd_processo_eleitoral = sp.cd_processo_eleitoral
              AND UP.sg_ue = sp.sg_ue_mun
           JOIN origem_votos ov ON ov.cd_ori_votos = spl.cd_ori_votos
           JOIN tipo_urna tu ON tu.cd_tipo_urna = spl.cd_tipo_urna;