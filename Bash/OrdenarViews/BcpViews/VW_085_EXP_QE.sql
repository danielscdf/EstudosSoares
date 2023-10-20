CREATE OR REPLACE VIEW vw_085_exp_qe
AS
SELECT qp.cd_eleicao,
       qp.sg_ue_uf,
       qp.sg_ue,
			 ue.nm_ue,
       qp.cd_cargo,
       sum(vg.qt_vagas) qt_vagas,
       sum(qp.qt_votos_nominais) qt_votos_nominais,
       sum(qp.qt_votos_legenda) qt_votos_legenda,
       sum(qp.qt_votos_nominais) + sum(qp.qt_votos_legenda) qt_votos_validos,
       sum(qe.vr_quociente_eleitoral) vr_quociente_eleitoral,
       sum(qe.qt_votos_branco) qt_votos_branco,
       sum(qe.qt_votos_nulos) + sum(qe.qt_votos_nulos_tecnicos) qt_votos_nulos,
       sum(qe.qt_votos_anulados) qt_votos_anulados,
       sum(qe.qt_votos_anulados_subjudice) qt_votos_anulados_subjudice,
       sum(qe.qt_votos_apurados_separados) qt_votos_apurados_separados
  FROM quociente_partidario qp
  INNER JOIN vaga vg
        ON vg.cd_eleicao = qp.cd_eleicao
        AND vg.sg_ue = qp.sg_ue
        AND vg.cd_cargo_pergunta = qp.cd_cargo
  INNER JOIN quociente_eleitoral qe
        ON qe.cd_eleicao = qp.cd_eleicao
        AND qe.sg_ue_uf = qp.sg_ue_uf
        AND qe.sg_ue = qp.sg_ue
        AND qe.cd_cargo = qp.cd_cargo
  INNER JOIN pleito p
        ON qe.cd_pleito = p.cd_pleito
  INNER JOIN ue_processo ue
        ON p.cd_processo_eleitoral = ue.cd_processo_eleitoral
        AND qp.sg_ue = ue.sg_ue
  GROUP BY qp.cd_eleicao,
       qp.sg_ue_uf,
       qp.sg_ue,
			 ue.nm_ue,
       qp.cd_cargo;