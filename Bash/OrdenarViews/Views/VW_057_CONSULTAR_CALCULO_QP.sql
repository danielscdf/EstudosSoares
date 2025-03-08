CREATE OR REPLACE VIEW VW_057_CONSULTAR_CALCULO_QP AS
SELECT qp.cd_eleicao,
       qp.sg_ue,
       qp.sg_ue_uf,
       qp.cd_cargo,
       qp.sq_drap,
       qp.qt_votos_nominais,
       qp.qt_votos_legenda,
       (qp.qt_votos_nominais + qp.qt_votos_legenda) qt_votos_validos,
       qp.qt_vagas_qp_obtida,
       qp.qt_cand_votacao_minima_qp qt_cando_10_qe,
       qp.qt_vagas_qp_preenchida,
       pc_ad_legenda.fc_monta_legenda_tot(p_cd_pleito     => e.cd_pleito,
                                          p_cd_eleicao    => qp.cd_eleicao,
                                          p_coligacao     => qp.sq_drap,
                                          p_numero        => 'S') sg_partido
  FROM quociente_partidario qp
	INNER JOIN eleicao e
	      ON qp.cd_eleicao = e.cd_eleicao
  order by NLSSORT(sg_partido, 'NLS_SORT=BINARY_AI');
