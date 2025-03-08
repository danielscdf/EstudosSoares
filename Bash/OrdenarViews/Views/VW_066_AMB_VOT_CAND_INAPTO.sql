CREATE OR REPLACE VIEW VW_066_AMB_VOT_CAND_INAPTO AS
SELECT CI.CD_PLEITO,
       CI.CD_ELEICAO,
       ci.nr_cand,
			 ci.nm_candidato,
       sc.nm_situacao_candidato,
	    DECODE (ca.cd_cargo,
               2, 1,
               4, 3,
               9, 5,
               10, 5,
               12, 11,
               ca.cd_cargo)
          cd_cargo,
       ca.nm_cargo_neutro,
       ci.sg_ue,
       ci.nr_partido,
       p.sg_partido
  FROM candidato_inapto ci
       JOIN situacao_candidato sc
          ON (SC.CD_SITUACAO_CANDIDATO = CI.CD_SITUACAO_CANDIDATO_IMPORTA)
       JOIN partido p
          ON (    P.CD_PLEITO = CI.CD_PLEITO
              AND P.CD_ELEICAO = CI.CD_ELEICAO
              AND P.NR_PARTIDO = CI.NR_PARTIDO)
       JOIN cargo ca
          ON (CA.CD_ELEICAO = CI.CD_ELEICAO AND CA.CD_CARGO = CI.CD_CARGO);