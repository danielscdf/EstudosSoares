CREATE OR REPLACE VIEW 
  VW_079_RESUMO_MUN_ZONA
	AS
  SELECT DISTINCT
    v.CD_PLEITO,
    v.CD_ELEICAO,
    v.CD_TIPO_CARGO_PERGUNTA,
    v.SG_UE_UF,
    v.SG_UE_MUN,
    v.NR_ZONA,
    v.NM_UE,
     v.QTD_ELEITORES,v.QTD_COMPARECIMENTO, 
 TO_CHAR(CASE WHEN qtd_aptos_urnas_instaladas = 0 THEN 0 WHEN qtd_comparecimento = 0 THEN 0 WHEN qtd_comparecimento / qtd_aptos_urnas_instaladas * 100 
 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE qtd_comparecimento / qtd_aptos_urnas_instaladas * 100 END, '990D00') PE_COMPARECIMENTO,
	v.QTD_COMPARECIMENTO_URNA,v.QTD_COMPARECIMENTO_SA, 
	v.QTD_COMPARECIMENTO_ANULADO,v.QTD_COMPAR_ANULADO_APURADO_SEPAR,
	v.QTD_COMPARECIMENTO_NAO_APURADO, 
	v.QTD_ABSTENCAO,
	TO_CHAR(CASE WHEN qtd_aptos_urnas_instaladas = 0 THEN 0 WHEN qtd_abstencao = 0 THEN 0 WHEN qtd_comparecimento / qtd_aptos_urnas_instaladas * 100 
	BETWEEN 0.0000000000000001 AND 0.001 THEN 100 - 0.01 ELSE 100 - (qtd_comparecimento / qtd_aptos_urnas_instaladas * 100) END, '990D00') PE_ABSTENCAO,
	v.QTD_APTOS_URNAS_INSTALADAS,v.QTD_APTOS_URNAS_NAO_INSTALADAS, 
	v.QTD_APTOS_APURADOS,v.QTD_APTOS_NAO_APURADOS,v.QTD_SECOES,v.QTD_SECOES_AGREGADAS,
	v.QTD_SECOES_TOTALIZADAS,v.QTD_SECOES_NAO_TOT,
	v.QTD_SECOES_INSTALADAS, v.QTD_SECOES_NAO_INSTALADAS, 
	v.QTD_SECOES_ANULADA_APURADA_SEPARADA,v.QTD_SECOES_ANULADA,
	v.QTD_SECOES_NAO_APURADAS,v.QTD_SECOES_APURADAS, 
	v.QTD_SECOES_APURADAS_URNA, v.QTD_SECOES_APURADAS_SA,
	vt.qt_votos_nominais TOTAL_VOTOS_NOMINAIS_VALIDOS, vt.pe_votos_nominais PE_VOTOS_NOMINAIS_VALIDOS ,
	vt.qt_votos_brancos TOTAL_VOTOS_BRANCOS, vt.PE_VOTOS_BRANCOS,
	vt.qt_votos_nulos TOTAL_VOTOS_NULOS, vt.PE_VOTOS_NULOS,
	vt.qt_votos_sem_cand_para_votar TOTAL_SEM_CAND_PARA_VOTAR, vt.pe_votos_sem_cand_para_votar,
	vt.qt_votos_anulados TOTAL_VOTOS_ANULADO, vt.pe_votos_anulados PE_VOTOS_ANULADO ,
	vt.qt_votos_anulados_sub_judice TOTAL_VOTOS_ANULADO_SUB_JUDICE, vt.pe_votos_anulados_sub_judice PE_VOTOS_ANULADO_SUB_JUDICE ,
	vt.qt_votos_nulo_tecnico TOTAL_VOTOS_NULO_TECNICO, vt.PE_VOTOS_NULO_TECNICO,
	vt.qt_votos_anul_apurado_sep TOTAL_VOTOS_ANUL_APURADO_SEP, vt.PE_VOTOS_ANUL_APURADO_SEP,
	vt.qt_votos_validos TOTAL_VOTOS_VALIDOS, vt.PE_VOTOS_VALIDOS,
	vt.qt_vt_comp_todos_votaveis QT_TOTAL_VOTOS_COMPUTADOS,
	vt.qt_vt_tot_todos_votaveis QT_TOTAL_VOTOS_TOTALIZADOS,
	vt.qt_vt_tot_todos_cand_resp TOTAL_VOTOS_CAND_CONCORRENTES, vt.pe_vt_tot_todos_cand_resp PE_TOTAL_VOTOS_CAND_CONCORRENTES ,
	vt.qt_votos_nulo_nulo_tecnico SOMA_VOTOS_NULOS , vt.pe_votos_nulo_nulo_tecnico PE_SOMA_VOTOS_NULOS ,
	vt.qt_votos_legenda TOTAL_VOTOS_LEGENDA, vt.PE_VOTOS_LEGENDA,
	vt.CD_CARGO_PERGUNTA,
	c.NM_CARGO_NEUTRO AS NM_CARGO
		FROM
			VW_079_RESUMO_SECOES_MUN_ZONA v
		JOIN dm_mun_zona dm
				 ON dm.cd_pleito = v.cd_pleito
				 AND dm.cd_eleicao = v.cd_eleicao
				 AND dm.sg_ue_uf = v.sg_ue_uf
				 AND dm.sg_ue_mun = v.sg_ue_mun
				 AND dm.nr_zona = v.nr_zona
		INNER JOIN vw_ft_votos_tot_mun_zona vt
					ON vt.cd_pleito = dm.cd_pleito
					AND vt.cd_eleicao = dm.cd_eleicao
					AND vt.sg_ue_uf = dm.sg_ue_uf
					AND vt.sq_dm_mun_zona = dm.sq_dm_mun_zona
					AND vt.cd_tipo_cargo_pergunta = v.cd_tipo_cargo_pergunta
		 LEFT JOIN CARGO c ON 
							vt.cd_cargo_pergunta = c.CD_CARGO
							AND vt.cd_eleicao = c.cd_eleicao
							 AND c.ST_VOTAVEL = 'S';