CREATE OR REPLACE VIEW VW_CANDIDATO_RESPOSTA
(
   CD_PLEITO,
   SG_UE,
   CD_ELEICAO,
   CD_CARGO_PERGUNTA,
   NR_VOTAVEL,
   NR_PARTIDO,
   NM_CANDIDATO_RESPOSTA,
   NM_CAND_URNA_RESPOSTA,
   SQ_CANDIDATO_RESPOSTA,
   CD_TIPO_VOTAVEL,
   ST_SUBSTITUIDO,
   SQ_CANDIDATO,
   CD_SITUACAO_TOTALIZACAO,
   DT_NASCIMENTO,
   SQ_DRAP,
   NR_CAND,
   NM_CANDIDATO,
   NM_RESPOSTA,
   CD_SITUACAO_CANDIDATO,
   TP_DECISAO_JUDICIAL,
   SQ_CAND_SUBSTITUIDO,
   CD_TIPO_VOTAVEL_DESTINO
)
   BEQUEATH DEFINER
AS
   SELECT V.CD_PLEITO,
          V.SG_UE,
          V.CD_ELEICAO,
          V.CD_CARGO_PERGUNTA,
          V.NR_VOTAVEL,
          V.NR_PARTIDO,
          CT.NM_CANDIDATO,
          CT.NM_CAND_URNA,
          CT.SQ_CANDIDATO,
          V.CD_TIPO_VOTAVEL,
          CT.ST_SUBSTITUIDO,
          CT.SQ_CANDIDATO,
          CT.CD_SITUACAO_TOTALIZACAO,
          CT.DT_NASCIMENTO,
          CT.SQ_DRAP,
          CT.NR_CAND,
          CT.NM_CANDIDATO,
          NULL,
          CT.CD_SITUACAO_CANDIDATO_ATUAL,
          CT.CD_TIPO_DECISAO_JUDICIAL,
          CT.SQ_CAND_SUBSTITUIDO,
          V.CD_TIPO_VOTAVEL_DESTINACAO
     FROM VOTAVEL V
          JOIN CANDIDATO CT
             ON (    V.CD_PLEITO = CT.CD_PLEITO
                 AND V.CD_ELEICAO = CT.CD_ELEICAO
                 AND V.SG_UE = CT.SG_UE
                 AND V.CD_CARGO_PERGUNTA = CT.CD_CARGO
                 AND V.NR_VOTAVEL = CT.NR_CAND)
   UNION
   SELECT /*+ index(R PK_RESPOSTA)*/
         V.CD_PLEITO,
          V.SG_UE,
          V.CD_ELEICAO,
          V.CD_CARGO_PERGUNTA,
          V.NR_VOTAVEL,
          V.NR_PARTIDO,
          R.NM_RESPOSTA,
          R.NM_RESPOSTA NM_CAND_URNA_RESPOSTA,
          R.NR_RESPOSTA SQ_CANDIDATO_RESPOSTA,
          V.CD_TIPO_VOTAVEL,
          NULL,
          NULL,
          R.CD_SITUACAO_TOTALIZACAO CD_SITUACAO_TOTALIZACAO,
          NULL,
          NULL,
          NULL,
          NULL,
          R.NM_RESPOSTA,
          NULL,
          NULL,
          NULL,
          V.CD_TIPO_VOTAVEL_DESTINACAO
     FROM VOTAVEL V
          JOIN RESPOSTA R
             ON (    V.CD_PLEITO = R.CD_PLEITO
                 AND V.CD_ELEICAO = R.CD_ELEICAO
                 AND V.SG_UE = R.SG_UE
                 AND V.CD_CARGO_PERGUNTA = R.CD_PERGUNTA
                 AND V.NR_VOTAVEL = R.NR_RESPOSTA)
   UNION
   SELECT V.CD_PLEITO,
          V.SG_UE,
          V.CD_ELEICAO,
          V.CD_CARGO_PERGUNTA,
          V.NR_VOTAVEL,
          V.NR_PARTIDO,
          NULL,
          NULL,
          NULL,
          V.CD_TIPO_VOTAVEL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          V.CD_TIPO_VOTAVEL_DESTINACAO
     FROM VOTAVEL V
    WHERE V.CD_TIPO_VOTAVEL <> 1;
