CREATE OR REPLACE VIEW vw_040_resultado_votacao_zona
AS
  SELECT ca.nr_votavel numero,
       ca.nm_cargo_pergunta,
       ca.nm_votavel nm_candidato,
       decode(ca.nm_votavel_vice2, '', ca.nm_votavel_vice1, ca.nm_votavel_vice1 || ' / ' || ca.nm_votavel_vice2) nm_vice,
       nvl(ca.nm_votavel_urna, ca.nm_votavel) nm_cand_resposta_urna,
       ca.cd_tipo_cargo_pergunta,
       ca.cd_cargo_pergunta,
       ca.cd_eleicao,
       ca.cd_pleito,
       vv.sg_ue_uf,
       vv.nr_zona,
       vv.qt_votos_totalizados_votavel qtd_votos_totalizados_cand_resp,
       vv.qt_votos_computados_votavel qtd_votos_computados_cand_resp,
       vv.pe_votos_computados_votavel pe_votos_computados_cand_resp,
       vv.pe_total_vt_candidatos_partido pe_votos_computados_part_col,
       ca.nm_tipo_votavel_destinacao,
       ca.cd_situacao_totalizacao,
       ca.nm_situacao_totalizacao,
       vt.qt_vt_comp_todos_votaveis  qt_total_votos,
       vt.qt_votos_validos,
       vt.pe_votos_validos,
       vt.qt_votos_nominais,
       vt.pe_votos_nominais,
       vt.qt_votos_legenda,
       vt.pe_votos_legenda,
       vt.qt_votos_anulados_sub_judice,
       vt.pe_votos_anulados_sub_judice,
       vt.qt_votos_anulados,
       vt.pe_votos_anulados,
       vt.qt_votos_anul_apurado_sep qt_votos_anulado_apurado_sep,
       vt.pe_votos_anul_apurado_sep pe_votos_anulado_apurado_sep,
       vt.qt_votos_nulo_nulo_tecnico qt_total_votos_nulos,
       vt.pe_votos_nulo_nulo_tecnico pe_total_votos_nulos,
       vt.qt_votos_nulos,
       vt.pe_votos_nulos,
       vt.qt_votos_nulo_tecnico qt_votos_nulos_tecnicos,
       vt.pe_votos_nulo_tecnico pe_votos_nulos_tecnicos,
       vt.qt_votos_brancos,
       vt.pe_votos_brancos,
       vt.qt_votos_sem_cand_para_votar qt_votos_sem_cand_para_votar,
       vt.pe_votos_sem_cand_para_votar,
       se.qt_eleitores qtd_eleitores,
       se.qt_comparecimento qtd_comparecimento,
       se.pe_comparecimento,
       se.qt_abstencao qtd_abstencao,
       se.pe_abstencao,
       se.qt_aptos_urnas_instaladas qtd_aptos_secoes_funcionaram,
       se.pe_aptos_urnas_instaladas pe_aptos_secoes_funcionaram,
       se.qt_aptos_apurados qtd_aptos_apurados,
       se.pe_aptos_apurados,
       se.qt_aptos_nao_apurados qtd_aptos_nao_apurados,
       se.pe_aptos_nao_apurados,
       se.qt_aptos_urnas_nao_instaladas qtd_aptos_urnas_nao_instaladas,
       se.pe_aptos_urnas_nao_instaladas,
       se.qt_secoes qtd_secoes,
       se.qt_secoes_totalizadas qtd_secoes_totalizadas,
       se.pe_secoes_totalizadas,
       se.qt_secoes_nao_totalizadas qtd_secoes_nao_tot,
       se.pe_secoes_nao_totalizadas pe_secoes_nao_tot,
       se.qt_secoes_instaladas qtd_secoes_funcionaram,
       se.pe_secoes_instaladas pe_secoes_funcionaram,
       se.qt_secoes_apuradas qtd_secoes_apuradas,
       se.pe_secoes_apuradas,
       se.qt_secoes_nao_apuradas qtd_secoes_nao_apuradas,
       se.pe_secoes_nao_apuradas,
       se.qt_secoes_nao_instaladas qtd_secoes_nao_instaladas,
       se.pe_secoes_nao_instaladas,
       to_char(CASE WHEN vt.dt_ult_tot_parcial_sec_hor_tse > vt.dt_ult_tot_final_hor_tse OR vt.dt_ult_tot_final_hor_tse IS NULL
              THEN vt.dt_ult_tot_parcial_sec_hor_tse
              WHEN vt.dt_ult_tot_final_hor_tse > vt.dt_ult_tot_parcial_sec_hor_tse OR vt.dt_ult_tot_parcial_sec_hor_tse IS NULL
              THEN vt.dt_ult_tot_final_hor_tse
              END, 'DD/MM/YYYY - HH24:MI:SS') dt_ultimo_resultado_hor_tse,
       to_char(CASE WHEN vt.dt_ult_tot_parcial_sec_hor_loc > vt.dt_ult_tot_final_hor_loc OR vt.dt_ult_tot_final_hor_loc IS NULL
              THEN vt.dt_ult_tot_parcial_sec_hor_loc
              WHEN vt.dt_ult_tot_final_hor_loc > vt.dt_ult_tot_parcial_sec_hor_loc OR vt.dt_ult_tot_parcial_sec_hor_loc IS NULL
              THEN vt.dt_ult_tot_final_hor_loc
              END, 'DD/MM/YYYY - HH24:MI:SS') dt_ultimo_resultado_hor_loc,
       ca.nr_partido,
       ca.sq_drap,
       nvl(ca.nm_coligacao, nvl(ca.nm_federacao,ca.nm_partido)) nm_partido_coligacao,
       decode(ca.cd_situacao_totalizacao, 1, '*', 2, '*', 3, '*', 6, '*', NULL) st_eleito,
       vt.qt_vt_tot_todos_cand_resp total_votos_cand_concorrentes,
       vv.qt_total_vt_candidatos_partido total_part_col,
       vt.pe_vt_tot_todos_cand_resp pe_total_votos_cand_concorrentes,
       ca.sq_ordem_suplencia,
       nvl(ca.sq_classificacao,1) sq_classificacao,
       va.st_eleicao_mat_definida,
       CASE WHEN ca.nm_coligacao IS NOT NULL THEN 'C'
            WHEN ca.nm_federacao IS NOT NULL THEN 'F'
            ELSE 'P'
       END tp_agremiacao
FROM dm_votavel ca
INNER JOIN vaga va
     ON va.cd_eleicao = ca.cd_eleicao
     AND va.sg_ue = ca.sg_ue
     AND va.cd_cargo_pergunta = ca.cd_cargo_pergunta
INNER JOIN vw_ft_votos_votavel_zona vv
ON ca.cd_pleito = vv.cd_pleito
   AND ca.cd_eleicao = vv.cd_eleicao
   AND ca.sg_ue_uf IN (vv.sg_ue_uf, 'BR')
   AND ca.sq_dm_votavel = vv.sq_dm_votavel
INNER JOIN vw_ft_votos_tot_zona vt
ON vt.cd_pleito = vv.cd_pleito
   AND vt.cd_eleicao = vv.cd_eleicao
   AND vt.sg_ue_uf = vv.sg_ue_uf
   AND vt.cd_cargo_pergunta = ca.cd_cargo_pergunta
   AND vt.nr_zona = vv.nr_zona
INNER JOIN vw_ft_secoes_zona se
ON se.cd_pleito = vv.cd_pleito
   AND se.cd_eleicao = vv.cd_eleicao
   AND se.sg_ue_uf = vv.sg_ue_uf
   AND se.cd_tipo_cargo_pergunta = ca.cd_tipo_cargo_pergunta
   AND se.nr_zona = vv.nr_zona
WHERE ca.cd_tipo_votavel_destinacao <> 8
  AND ca.cd_tipo_votavel = 1;