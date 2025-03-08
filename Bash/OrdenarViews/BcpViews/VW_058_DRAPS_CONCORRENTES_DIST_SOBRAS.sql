CREATE OR REPLACE VIEW vw_058_draps_concorrentes_dist_sobras
AS
    SELECT m.cd_pleito,
           m.cd_eleicao,
           m.sg_ue_uf,
           m.sg_ue,
           m.cd_cargo,
           pc_ad_legenda.fc_monta_legenda_tot(
                                              p_cd_pleito => m.cd_pleito,
                                              p_cd_eleicao => m.cd_eleicao,
                                              p_coligacao => m.sq_drap,
                                              p_numero => 'S'
                                             ) nm_partido_colig_fed,
           m.sq_drap,
           qp.qt_votos_legenda + qp.qt_votos_nominais qt_votos_validos,
           TO_CHAR
           (
               (qp.qt_votos_legenda + qp.qt_votos_nominais) / qe.
               vr_quociente_eleitoral * 100,
               '9990D00'
           )   pe_sobre_qe
      FROM media m
           JOIN quociente_eleitoral qe
               ON qe.cd_pleito = m.cd_pleito
              AND qe.cd_eleicao = m.cd_eleicao
              AND qe.sg_ue_uf = m.sg_ue_uf
              AND qe.sg_ue = m.sg_ue
              AND qe.cd_cargo = m.cd_cargo
           JOIN quociente_partidario qp
               ON qp.cd_eleicao = m.cd_eleicao
              AND qp.cd_cargo = m.cd_cargo
              AND qp.sg_ue_uf = m.sg_ue_uf
              AND qp.sg_ue = m.sg_ue
              AND qp.sq_drap = m.sq_drap
     WHERE m.nr_media = 1;