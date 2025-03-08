CREATE OR REPLACE VIEW VW_066_AMB_VOT_CAND_APTO as
SELECT c.cd_pleito,
       c.cd_eleicao,
       DECODE (c.cd_cargo,
               2, 1,
               4, 3,
               9, 5,
               10, 5,
               12, 11,
               c.cd_cargo)
          cdcargo,
       ca.st_votavel,
       c.nr_cand,
       ca.cd_cargo ordemx,
       ca.nm_cargo_neutro,
       ca.nm_cargo_neutro cargo,
       c.nm_candidato || ' (' || c.nm_cand_urna || ')' nomecandidato,
       DECODE (ca.st_votavel, 'N', '', c.nr_cand || ' - ') numcand,
       sc.nm_situacao_candidato,
       c.sg_ue,
       C.SG_UE_UF,
       ca.cd_cargo_superior cargoSup,
       CA.CD_TIPO_CARGO_PERGUNTA,
       CASE
          WHEN ca.cd_cargo_superior IS NOT NULL
          THEN
                '   '
             || ca.nm_cargo_neutro
             || ': '
             || c.nm_candidato
             || ' ('
             || c.nm_cand_urna
             || ')'
          ELSE
                c.nr_cand
             || ' - '
             || c.nm_candidato
             || ' ('
             || c.nm_cand_urna
             || ')'
       END
          AS NOME_CANDIDATO_FORMATADO,
       CASE
          WHEN ca.cd_cargo_superior IS NULL AND CA.CD_TIPO_CARGO_PERGUNTA = 1
          THEN
             1
          ELSE
             0
       END
          AS CHAPA_CAND,
       c.SQ_DRAP
  FROM cargo ca
       JOIN candidato c
          ON (CA.CD_ELEICAO = C.CD_ELEICAO AND CA.CD_CARGO = C.CD_CARGO)
       JOIN situacao_candidato sc
          ON (SC.CD_SITUACAO_CANDIDATO = C.CD_SITUACAO_CANDIDATO_IMPORTA)
 WHERE C.SQ_CAND_SUBSTITUIDO IS NULL;