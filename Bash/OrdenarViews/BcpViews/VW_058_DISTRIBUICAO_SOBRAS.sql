CREATE OR REPLACE VIEW vw_058_distribuicao_sobras
AS
    SELECT me.cd_pleito,
           qp.cd_eleicao,
           e.nm_eleicao,
           qp.sg_ue_uf,
           qp.sg_ue,
		   ue.nm_ue,
           qp.cd_cargo,
           cg.cd_tipo_cargo_pergunta,
           cg.nm_cargo_neutro,
           me.vr_media,
           me.nr_media,
           qp.vr_calculo_qp,
           pc_ad_legenda.fc_monta_legenda_tot(
                                              p_cd_pleito => me.cd_pleito,
                                              p_cd_eleicao => qp.cd_eleicao,
                                              p_coligacao => qp.sq_drap,
                                              p_numero => 'S'
                                             )
               nm_partido_coligacao,
           qp.qt_votos_nominais,
           qp.qt_votos_legenda,
           qp.qt_votos_legenda + qp.qt_votos_nominais qt_votos_validos,
           qp.qt_vagas_qp_obtida,
           qp.qt_vagas_qp_preenchida,
           SUM(qp.qt_vagas_qp_preenchida) over(PARTITION BY qp.cd_eleicao, qp.sg_ue_uf, qp.sg_ue, qp.cd_cargo, cg.cd_tipo_cargo_pergunta, me.nr_media)qt_total_vagas_preenchidas_qp,
           nvl(me.qt_vagas_media_obtida,0) qt_vagas_media_obtida,
           me.qt_vagas_media_preenchida,
           qp.qt_cand_sem_votacao_minima_media qt_cand_sem_votacao_minima,
           me.st_media,
           me.qt_cand_votacao_minima_media qt_cand_votacao_minima,
           v.qt_vagas
      FROM quociente_partidario qp
           INNER JOIN media me
               ON qp.cd_eleicao = me.cd_eleicao
              AND qp.sg_ue_uf = me.sg_ue_uf
              AND qp.sg_ue = me.sg_ue
              AND qp.cd_cargo = me.cd_cargo
              AND qp.sq_drap = me.sq_drap
					 INNER JOIN eleicao e
					       ON qp.cd_eleicao = e.cd_eleicao
					 INNER JOIN pleito p
					       ON e.cd_pleito = p.cd_pleito
					 INNER JOIN ue_processo ue
					       ON ue.cd_processo_eleitoral = p.cd_processo_eleitoral
								 AND ue.sg_ue = qp.sg_ue
           INNER JOIN cargo cg
               ON qp.cd_eleicao = cg.cd_eleicao
              AND qp.cd_cargo = cg.cd_cargo
           INNER JOIN drap d
               ON qp.cd_eleicao = d.cd_eleicao
              AND qp.sg_ue = d.sg_ue
              AND qp.sq_drap = d.sq_drap
           INNER JOIN vaga v
                 ON v.cd_eleicao = qp.cd_eleicao
                 AND v.sg_ue = qp.sg_ue
								 AND v.cd_cargo_pergunta = qp.cd_cargo;