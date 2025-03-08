CREATE OR REPLACE VIEW VW_023_SECAO_SITUACAO_TOT AS
SELECT se.cd_pleito,
          se.cd_eleicao,
					e.nm_eleicao,
          stcp.cd_tipo_cargo_pergunta,
					tc.nm_tipo_cargo_pergunta,
          UP.sg_ue_superior sg_ue_uf,
          se.sg_ue_mun,
          UP.nm_ue,
          LPAD(se.nr_zona, 4, '0') nr_zona,
          LPAD(ssp.nr_secao, 4, '0') nr_secao,
          LPAD(lv.nr_local, 4, '0')||
          '-' ||
          lv.nm_local
             local_votacao,
          lv.ds_endereco,
          lv.nr_local,
          se.tp_situacao_totalizacao,
          DECODE(se.tp_situacao_totalizacao,  'N', 'Não totalizada',  'T', 'Totalizada') situacao_totalizacao,
          se.qt_aptos qtd_aptos,
          stcp.qt_comparecimento qtd_comparecimento,
          DECODE(stcp.qt_comparecimento,  NULL, NULL,  se.qt_aptos - stcp.qt_comparecimento) qtd_abstencao,          
          TO_CHAR(se.dt_ult_tot_parcial_sec_hor_tse, 'DD/MM/YYYY HH24:MI:SS') dt_totalizacao_hor_tse,
          TO_CHAR(se.dt_ult_tot_parcial_sec_hor_loc, 'DD/MM/YYYY HH24:MI:SS') dt_totalizacao_hor_loc,
          (select count(1) 
             from pendencia_secao_pleito psp 
            where PSP.CD_PROCESSO_ELEITORAL = SSP.CD_PROCESSO_ELEITORAL 
              and PSP.CD_PLEITO = P.CD_PLEITO
              and PSP.SG_UE_UF = SSP.SG_UE_UF
              and PSP.SG_UE_MUN = SSP.SG_UE_MUN
              and PSP.NR_ZONA = SSP.NR_ZONA
              and PSP.NR_SECAO = SSP.NR_SECAO
              and PSP.ST_PENDENCIA = 'N') QTD_BU_PENDENTE,
          (select count(1)
             from rejeicao r
            where R.CD_PLEITO = P.CD_PLEITO
              and R.SG_UE_UF = SSP.SG_UE_UF
              and R.SG_UE_MUN = SSP.SG_UE_MUN
              and R.NR_ZONA = SSP.NR_ZONA
              and R.NR_SECAO_MESA = SSP.NR_SECAO) QTD_BU_REJEITADO,
          (select count(1)
             from secao_pleito sp
           where SP.CD_PROCESSO_ELEITORAL = SSP.CD_PROCESSO_ELEITORAL
             and SP.CD_PLEITO = P.CD_PLEITO
             and SP.SG_UE_UF = SSP.SG_UE_UF
             AND SP.SG_UE_MUN = SSP.SG_UE_MUN
             AND SP.NR_ZONA = SSP.NR_ZONA
             AND SP.NR_SECAO = SSP.NR_SECAO
             AND SP.TP_SITUACAO_SECAO_BU = 'R') QTD_BU_VALIDO   
     FROM secao_processo ssp
          JOIN pleito p ON p.cd_processo_eleitoral = ssp.cd_processo_eleitoral    
          JOIN secao_eleicao se
             ON se.sg_ue_mun = ssp.sg_ue_mun
            AND se.nr_zona = ssp.nr_zona
            AND se.nr_secao = ssp.nr_secao
            AND se.cd_pleito = p.cd_pleito
					JOIN eleicao e
					     ON se.cd_eleicao = e.cd_eleicao
          JOIN secao_tp_cargo_perg stcp
             ON stcp.cd_eleicao = se.cd_eleicao
            AND stcp.sg_ue_mun = se.sg_ue_mun
            AND stcp.nr_zona = se.nr_zona
            AND stcp.nr_secao = se.nr_secao
					JOIN tipo_cargo_pergunta tc
					     ON stcp.cd_tipo_cargo_pergunta = tc.cd_tipo_cargo_pergunta
          JOIN ue_processo UP
             ON UP.cd_processo_eleitoral = ssp.cd_processo_eleitoral
            AND UP.sg_ue = ssp.sg_ue_mun
          JOIN local_votacao lv
             ON lv.cd_processo_eleitoral = ssp.cd_processo_eleitoral
            AND lv.nr_zona = ssp.nr_zona
            AND lv.sg_ue_mun = ssp.sg_ue_mun
            AND lv.nr_local = ssp.nr_local;
