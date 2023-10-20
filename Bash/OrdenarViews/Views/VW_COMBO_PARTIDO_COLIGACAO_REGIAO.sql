CREATE OR REPLACE VIEW vw_combo_partido_coligacao_regiao
AS
SELECT DISTINCT ca.cd_pleito,
                     ca.cd_eleicao,
                     co.nm_coligacao,
                     ca.cd_cargo,
                     UPR.CD_REGIAO,
                     NVL (co.sg_ue, pi.sg_ue) sg_ue,
                     NVL (co.nm_coligacao, pa.nm_partido) partido_coligacao,
                     ca.sg_ue_uf,
                     ca.sq_drap
       FROM partido pa
            INNER JOIN UE_PLEITO UP ON (UP.CD_PLEITO = PA.CD_PLEITO)
            INNER JOIN UE_PROCESSO UPR ON (UPR.CD_PROCESSO_ELEITORAL = UP.CD_PROCESSO_ELEITORAL AND UPR.SG_UE = UP.SG_UE_UF)
            INNER JOIN candidato ca
               ON     pa.cd_eleicao = ca.cd_eleicao
                  AND pa.nr_partido = ca.nr_partido
            LEFT JOIN partido_federacao_coligacao pc
               ON     pa.cd_eleicao = pc.cd_eleicao
                  AND pa.nr_partido = pc.nr_partido_federacao
            LEFT JOIN coligacao co
               ON     pc.cd_eleicao = co.cd_eleicao
                  AND pc.sg_ue = co.sg_ue
                  AND pc.sq_drap = co.sq_drap
            LEFT JOIN drap_isolado pi
               ON     pa.cd_eleicao = pi.cd_eleicao
                  AND pa.nr_partido = pi.nr_partido_federacao
   ORDER BY co.nm_coligacao;