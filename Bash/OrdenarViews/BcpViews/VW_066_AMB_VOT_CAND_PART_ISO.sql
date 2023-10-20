CREATE OR REPLACE VIEW VW_066_AMB_VOT_CAND_PART_ISO  AS
SELECT DISTINCT C.CD_PLEITO,
       C.CD_ELEICAO,
       ca.nm_cargo_neutro cargo,
       p.nr_partido || ' - ' || p.sg_partido sigla,
       UPPER (p.nm_partido) nome,
       ca.cd_cargo,
       C.SG_UE,
       C.SG_UE_UF,
       pc_ad_ue_processo.fc_nome_ue (
          p_cd_processo_eleitoral   => pc_ad_pleito.fc_retorna_processo (
                                         p_cd_pleito   => C.CD_PLEITO),
          p_sg_ue                   => C.SG_UE)
          nm_ue,
       SD.NM_SITUACAO_DRAP
  FROM partido p
       JOIN candidato c
          ON (    P.CD_PLEITO = C.CD_PLEITO
              AND P.CD_ELEICAO = C.CD_ELEICAO
              AND P.NR_PARTIDO = C.NR_PARTIDO)
       JOIN cargo ca
          ON (C.CD_ELEICAO = CA.CD_ELEICAO AND C.CD_CARGO = CA.CD_CARGO)
       JOIN drap_isolado pi
          ON (    PI.CD_PLEITO = C.CD_PLEITO
              AND PI.CD_ELEICAO = C.CD_ELEICAO
              AND PI.SG_UE = C.SG_UE
              AND PI.SQ_DRAP = C.SQ_DRAP)
       JOIN drap d
          ON (    D.CD_PLEITO = C.CD_PLEITO
              AND D.CD_ELEICAO = C.CD_ELEICAO
              AND D.SG_UE = C.SG_UE
              AND D.SQ_DRAP = C.SQ_DRAP)
       JOIN situacao_drap sd ON (SD.CD_SITUACAO_DRAP = D.CD_SITUACAO_DRAP_IMPORTA)
	WHERE p.nr_federacao IS NULL;