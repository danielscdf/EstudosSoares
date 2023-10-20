CREATE OR REPLACE VIEW VW_066_AMB_VOT_CAND_COLIGACAO AS
SELECT c.cd_pleito,
       c.cd_eleicao,
       ca.nm_cargo_neutro cargo,
       UPPER (CO.NM_COLIGACAO) nome,
       pc_ad_legenda.fc_monta_legenda_tot(C.CD_PLEITO, C.CD_ELEICAO , C.SQ_DRAP , 'S') as sigla,
       ca.cd_cargo,
       C.SG_UE,
       C.SG_UE_UF,
       pc_ad_ue_processo.fc_nome_ue (
          p_cd_processo_eleitoral   => pc_ad_pleito.fc_retorna_processo (
                                         p_cd_pleito   => C.CD_PLEITO),
          p_sg_ue                   => C.SG_UE)
          nm_ue,
       SD.NM_SITUACAO_DRAP
  FROM coligacao co
       JOIN candidato c
          ON (    CO.CD_PLEITO = C.CD_PLEITO
              AND CO.CD_ELEICAO = C.CD_ELEICAO
              AND CO.SQ_DRAP = C.SQ_DRAP
              AND CO.SG_UE = C.SG_UE)
       JOIN cargo ca
          ON (CA.CD_ELEICAO = C.CD_ELEICAO AND CA.CD_CARGO = C.CD_CARGO)
       JOIN drap d
          ON (    D.CD_PLEITO = C.CD_PLEITO
              AND D.CD_ELEICAO = C.CD_ELEICAO
              AND D.SG_UE = C.SG_UE
              AND D.SQ_DRAP = C.SQ_DRAP
			  AND D.CD_SITUACAO_DRAP NOT IN (4, 7))
       JOIN situacao_drap sd ON (SD.CD_SITUACAO_DRAP = D.CD_SITUACAO_DRAP_IMPORTA);