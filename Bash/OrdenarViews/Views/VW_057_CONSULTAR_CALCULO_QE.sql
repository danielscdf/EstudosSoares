CREATE OR REPLACE VIEW VW_057_CONSULTAR_CALCULO_QE
AS SELECT qe.cd_pleito,
       qe.cd_eleicao,
       qe.sg_ue,
       qe.sg_ue_uf,
       qe.cd_cargo,
       qe.qt_vagas_qe,
       qe.qt_votos_nominais,
       qe.qt_votos_legenda,
       (qe.qt_votos_nominais + qe.qt_votos_legenda) qt_votos_validos,
       qe.qt_votos_branco,
       qe.qt_votos_nulos + QE.QT_VOTOS_NULOS_TECNICOS qt_votos_nulos,
       qe.qt_votos_anulados,
       QE.QT_VOTOS_ANULADOS_SUBJUDICE,
       qe.qt_votos_apurados_separados,
       qe.vr_quociente_eleitoral,
       c.nm_cargo_neutro
  FROM quociente_eleitoral qe
  JOIN cargo c
    ON qe.cd_eleicao = c.cd_eleicao
   AND qe.cd_cargo = c.cd_cargo;