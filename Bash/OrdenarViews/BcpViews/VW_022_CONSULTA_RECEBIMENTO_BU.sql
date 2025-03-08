CREATE OR REPLACE VIEW vw_022_consulta_recebimento_bu
AS
       SELECT sp.cd_pleito,
           sp.sg_ue_mun,
           UP.nm_ue,
           sp.sg_ue_uf,
           LPAD(sp.nr_zona, 4, '0') nr_zona,
           lv.nr_local,
           LPAD(lv.nr_local, 4, '0')||
           '-' ||
           lv.nm_local
               local_votacao,
           lv.ds_endereco,
           LPAD(ssp.nr_secao, 4, '0') nr_secao,
           sp.tp_situacao_secao_bu,
           DECODE(sp.tp_situacao_secao_bu,  'R', 'Recebida',  'N', 'Não recebida') situacao_bu,
           (SELECT COUNT(1)
              FROM pendencia_secao_pleito psp
             WHERE psp.cd_processo_eleitoral = sp.cd_processo_eleitoral
               AND psp.cd_pleito = sp.cd_pleito
               AND psp.sg_ue_uf = sp.sg_ue_uf
               AND psp.sg_ue_mun = sp.sg_ue_mun
               AND psp.nr_zona = sp.nr_zona
               AND psp.nr_secao = sp.nr_secao
               AND psp.st_pendencia = 'N')
               qtd_bu_pendente,
           (SELECT COUNT(1)
              FROM rejeicao r INNER JOIN tipo_arquivo_recebido ta ON (r.cd_tipo_arquivo_recebido = ta.cd_tipo_arquivo_recebido AND ta.cd_conteudo_arquivo = 1)
             WHERE r.cd_pleito = sp.cd_pleito
               AND r.sg_ue_uf = sp.sg_ue_uf
               AND r.sg_ue_mun = sp.sg_ue_mun
               AND r.nr_zona = sp.nr_zona
               AND r.nr_secao_mesa = sp.nr_secao
               )
               qtd_bu_rejeitado,
           DECODE(sp.cd_tipo_urna, 1, 1, 0) qtd_bu_valido,                                                                                                                                                                                                         --Alterado de seção recebida para seção apurada conforme evolução na RN0063
           tu.nm_tipo_urna,
           ov.nm_ori_votos,
           TO_CHAR(sp.dt_bu_recebido_hor_tse, 'DD/MM/YYYY HH24:MI:SS') dt_recebimento_hor_tse,
           TO_CHAR(sp.dt_bu_recebido_hor_loc, 'DD/MM/YYYY HH24:MI:SS') dt_recebimento_hor_loc,
           gm.sq_grupo_monitoramento,
           gm.nm_grupo_monitoramento
      FROM secao_processo ssp
           JOIN secao_pleito sp
               ON ssp.cd_processo_eleitoral = sp.cd_processo_eleitoral
              AND ssp.sg_ue_uf = sp.sg_ue_uf
              AND ssp.sg_ue_mun = sp.sg_ue_mun
              AND ssp.nr_zona = sp.nr_zona
              AND ssp.nr_secao = sp.nr_secao
           JOIN ue_processo UP
               ON UP.cd_processo_eleitoral = ssp.cd_processo_eleitoral
              AND UP.sg_ue = ssp.sg_ue_mun
           JOIN local_votacao lv
               ON lv.cd_processo_eleitoral = ssp.cd_processo_eleitoral
              AND lv.sg_ue_uf = ssp.sg_ue_uf
              AND lv.sg_ue_mun = ssp.sg_ue_mun
              AND lv.nr_zona = ssp.nr_zona
              AND lv.nr_local = ssp.nr_local
           LEFT JOIN tipo_urna tu ON sp.cd_tipo_urna = tu.cd_tipo_urna
           LEFT JOIN origem_votos ov ON ov.cd_ori_votos = sp.cd_ori_votos
		   LEFT JOIN origem_votos ov ON ov.cd_ori_votos = sp.cd_ori_votos
           LEFT JOIN monitoramento_local_votacao ml
                ON ssp.cd_processo_eleitoral = ml.cd_processo_eleitoral
                AND ssp.sg_ue_uf = ml.sg_ue_uf
                AND ssp.sg_ue_mun = ml.sg_ue_mun
                AND ssp.nr_zona = ml.nr_zona
                AND ssp.nr_local = ml.nr_local
           LEFT JOIN grupo_monitoramento gm
                ON ml.cd_processo_eleitoral = gm.cd_processo_eleitoral
            		AND ml.sq_grupo_monitoramento = gm.sq_grupo_monitoramento;