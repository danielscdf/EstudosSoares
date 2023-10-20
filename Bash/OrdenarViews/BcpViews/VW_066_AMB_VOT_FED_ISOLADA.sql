CREATE OR REPLACE VIEW VW_066_AMB_VOT_FED_ISOLADA AS
SELECT pi.CD_PLEITO,
       pi.CD_ELEICAO,
       cg.nm_cargo_neutro cargo,
       pc_ad_legenda.fc_monta_legenda_sigla_federacao(p_cd_pleito => pi.cd_pleito, p_cd_eleicao => pi.cd_eleicao, p_nr_federacao => fe.nr_federacao ) sigla,
       UPPER (fe.nm_federacao) nome,
       cg.cd_cargo,
       pi.SG_UE,
       utp.SG_UE_UF,
       ue.nm_ue,
			 sd.cd_situacao_drap,
       SD.NM_SITUACAO_DRAP
  FROM drap_isolado pi
  INNER JOIN legenda le
        ON le.cd_eleicao = pi.cd_eleicao
        AND le.sg_ue = pi.sg_ue
        AND le.sq_drap = pi.sq_drap
  INNER JOIN cargo cg
        ON cg.cd_eleicao = le.cd_eleicao
        AND cg.cd_cargo = le.cd_cargo
  INNER JOIN ue_tp_cargo_perg utp
        ON utp.cd_pleito = pi.cd_pleito
        AND utp.cd_eleicao = pi.cd_eleicao
        AND utp.sg_ue = pi.sg_ue
        AND utp.cd_tipo_cargo_pergunta = cg.cd_tipo_cargo_pergunta
  INNER JOIN pleito p
        ON p.cd_pleito = utp.cd_pleito
  INNER JOIN ue_processo ue
        ON ue.cd_processo_eleitoral = p.cd_processo_eleitoral
        AND ue.sg_ue = utp.sg_ue
  INNER JOIN federacao fe
        ON fe.cd_pleito = pi.cd_pleito
        AND fe.cd_eleicao = pi.cd_eleicao
        AND fe.nr_federacao = pi.nr_partido_federacao
  INNER JOIN drap d
        ON d.cd_pleito = pi.cd_pleito
        AND d.cd_eleicao = pi.cd_eleicao
        AND d.sg_ue = pi.sg_ue
        AND d.sq_drap = pi.sq_drap
				AND d.cd_situacao_drap not in (4, 7)
  INNER JOIN situacao_drap sd
        ON sd.cd_situacao_drap = d.cd_situacao_drap_importa;
