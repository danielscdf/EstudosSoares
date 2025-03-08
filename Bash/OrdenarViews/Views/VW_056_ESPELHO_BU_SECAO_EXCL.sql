CREATE OR REPLACE VIEW vw_056_espelho_bu_secao_excl
AS
    SELECT sp.cd_processo_eleitoral,
           pe.nm_processo_eleitoral,
           spl.sq_secao_pleito_exc,
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
           co.nr_urna cd_identificacao_ue,
           TO_CHAR(spl.dt_abertura, 'DD/MM/YYYY') dt_abertura_ue,
           TO_CHAR(spl.dt_abertura, 'HH24:MI:SS') hr_abertura_ue,
           TO_CHAR(spl.dt_encerramento, 'DD/MM/YYYY') dt_fechamento_ue,
           TO_CHAR(spl.dt_encerramento, 'HH24:MI:SS') hr_fechamento_ue,
           TO_CHAR(spl.dt_geracao_arquivo, 'DD/MM/YYYY') dt_geracao_arquivo,
           TO_CHAR(spl.dt_geracao_arquivo, 'HH24:MI:SS') hr_geracao_arquivo,
           TO_CHAR(spl.dt_bu_recebido_hor_loc, 'DD/MM/YYYY') dt_recebimento_hor_loc,
           TO_CHAR(spl.dt_bu_recebido_hor_loc, 'HH24:MI:SS') hr_recebimento_hor_loc,
           TO_CHAR(spl.dt_bu_recebido_hor_tse, 'DD/MM/YYYY') dt_recebimento_hor_tse,
           TO_CHAR(spl.dt_bu_recebido_hor_tse, 'HH24:MI:SS') hr_recebimento_hor_tse,
           TO_CHAR(spl.ts_emissao_bu, 'DD/MM/YYYY') dt_emissao,
           TO_CHAR(spl.ts_emissao_bu, 'HH24:MI:SS') hr_emissao,
           co.cd_flash_card,
           replace(SUBSTR(TO_CHAR(co.cd_carga_urna, '000G000G000G000G000G000G000G000'), 1, 32), ',', '.') cd_carga_urna_efetivada,
           TO_CHAR(co.dt_carga_urna, 'DD/MM/YYYY') dt_carga,
           TO_CHAR(co.dt_carga_urna, 'HH24:MI:SS') hr_carga,
           ov.nm_ori_votos,
           ov.sg_ori_votos,
           ov.cd_ori_votos,
           tu.nm_tipo_urna,
           replace(SUBSTR(TO_CHAR(co.cd_carga_urna, '000G000G000G000G000G000G000G000'), 26, 32), ',', '.') cd_resumo_correspondencia,
           tio.nm_tipo_operacao,
           spl.ds_motivo,
           TO_CHAR(spl.dt_exclusao_bu_hor_loc, 'DD/MM/YYYY') dt_operacao,
           TO_CHAR(spl.dt_exclusao_bu_hor_loc, 'HH24:MI:SS') hr_operacao,
		   max(se.qt_aptos) qtd_Aptos,
           stp.qt_comparecimento
      FROM secao_processo sp
           JOIN secao_pleito_exc spl
               ON sp.cd_processo_eleitoral = spl.cd_processo_eleitoral
              AND sp.sg_ue_uf = spl.sg_ue_uf
              AND sp.sg_ue_mun = spl.sg_ue_mun
              AND sp.nr_zona = spl.nr_zona
              AND sp.nr_secao = spl.nr_secao
			JOIN secao_eleicao se
                ON spl.cd_pleito = se.cd_pleito
                AND spl.sg_ue_uf = se.sg_ue_uf
                AND spl.sg_ue_mun = se.sg_ue_mun
                AND spl.nr_zona = se.nr_zona
                AND spl.nr_secao = se.nr_secao
           LEFT JOIN (SELECT DISTINCT secao_tp_cargo_perg_exc.cd_pleito,
                                   secao_tp_cargo_perg_exc.cd_eleicao,
                                   secao_tp_cargo_perg_exc.sg_ue_mun,
                                   secao_tp_cargo_perg_exc.nr_zona,
                                   secao_tp_cargo_perg_exc.nr_secao,
                                   secao_tp_cargo_perg_exc.sg_ue_uf,
                                   sq_secao_pleito_exc,                                                                     
                                   MAX(qt_comparecimento)
                                       OVER(
                                            PARTITION BY cd_eleicao,
                                                         sg_ue_mun,
                                                         nr_zona,
                                                         nr_secao
                                           )
                                       qt_comparecimento
                     FROM secao_tp_cargo_perg_exc) stp ON stp.cd_pleito = se.cd_pleito
                AND stp.cd_eleicao = se.cd_eleicao
                AND stp.sg_ue_uf = se.sg_ue_uf
                AND stp.sg_ue_mun = se.sg_ue_mun
                AND stp.nr_zona = se.nr_zona
                AND stp.nr_secao = se.nr_secao  
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
           LEFT JOIN correspondencia co
               ON co.cd_processo_eleitoral = spl.cd_processo_eleitoral
              AND co.sq_corresp = spl.sq_corresp_efetivada
           JOIN ue_processo UP
               ON UP.cd_processo_eleitoral = sp.cd_processo_eleitoral
              AND UP.sg_ue = sp.sg_ue_mun
           JOIN origem_votos ov ON ov.cd_ori_votos = spl.cd_ori_votos
           JOIN tipo_urna tu ON tu.cd_tipo_urna = spl.cd_tipo_urna
           LEFT JOIN tipo_operacao tio ON tio.cd_tipo_operacao = spl.cd_tipo_operacao
		   group by sp.cd_processo_eleitoral, pe.nm_processo_eleitoral, spl.sq_secao_pleito_exc, p.dt_pleito, spl.cd_pleito, sp.sg_ue_uf,
           sp.sg_ue_mun, UP.nm_ue, sp.nr_zona, lv.nr_local, sp.nr_secao, v_secao_agregada.secoes_agregadas, v_secao_agregada.qtd_secoes_agregadas,
           spl.nr_junta_apuradora,
           spl.nr_turma_apuradora,
           spl.qt_eleitores_bio_lib_codigo,
           co.nr_urna,
        spl.dt_abertura,
        spl.dt_abertura, 
        spl.dt_encerramento,
        spl.dt_encerramento,
        spl.dt_geracao_arquivo,
        spl.dt_geracao_arquivo, 
        spl.dt_bu_recebido_hor_loc,
        spl.dt_bu_recebido_hor_loc,
        spl.dt_bu_recebido_hor_tse,
        spl.dt_bu_recebido_hor_tse,
        spl.ts_emissao_bu,
        spl.ts_emissao_bu, 
        co.cd_flash_card,
        co.cd_carga_urna,
        co.dt_carga_urna, 
        co.dt_carga_urna,
        ov.nm_ori_votos,
        ov.sg_ori_votos,
        ov.cd_ori_votos,
        tu.nm_tipo_urna,
        co.cd_carga_urna,
        tio.nm_tipo_operacao,
        spl.ds_motivo,
        spl.dt_exclusao_bu_hor_loc,
        spl.dt_exclusao_bu_hor_loc,
        stp.qt_comparecimento;