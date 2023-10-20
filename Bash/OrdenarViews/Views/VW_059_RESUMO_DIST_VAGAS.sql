CREATE OR REPLACE VIEW vw_059_resumo_dist_vagas
AS
SELECT qe.cd_pleito,
           qe.cd_eleicao,
           qe.sg_ue_uf,
           qe.sg_ue,
           ue.nm_ue,
           qe.cd_cargo,
           ca.cd_tipo_cargo_pergunta,
           ca.nm_cargo_neutro,
           NVL(qe.vr_quociente_eleitoral, 0) vr_quociente_eleitoral,
					 qp.sq_drap,
           pc_ad_legenda.fc_monta_legenda_tot(
                                              p_cd_pleito => qe.cd_pleito,
                                              p_cd_eleicao => qp.cd_eleicao,
                                              p_coligacao => qp.sq_drap,
                                              p_numero => 'S'
                                             ) NM_PARTIDO_COLIGACAO,       
           qp.qt_votos_nominais,
           qp.qt_votos_legenda,
           qp.qt_votos_legenda + qp.qt_votos_nominais qt_votos_validos,
           qp.qt_vagas_qp_preenchida,
           qp.qt_vagas_media_preenchida,
           qp.qt_vagas_qp_preenchida + qp.qt_vagas_media_preenchida qt_total_vagas
      FROM quociente_eleitoral qe
           INNER JOIN cargo ca
               ON qe.cd_cargo = ca.cd_cargo
              AND qe.cd_eleicao = ca.cd_eleicao
           INNER JOIN quociente_partidario qp
               ON qe.cd_eleicao = qp.cd_eleicao
              AND qe.sg_ue_uf = qp.sg_ue_uf
              AND qe.sg_ue = qp.sg_ue
              AND qe.cd_cargo = qp.cd_cargo
           INNER JOIN pleito p ON qe.cd_pleito = p.cd_pleito
           INNER JOIN ue_processo ue
               ON p.cd_processo_eleitoral = ue.cd_processo_eleitoral
              AND qe.sg_ue = ue.sg_ue
			  order by NLSSORT(NM_PARTIDO_COLIGACAO, 'NLS_SORT=BINARY_AI');
