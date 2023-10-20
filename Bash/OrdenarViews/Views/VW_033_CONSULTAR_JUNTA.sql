create or replace view VW_033_CONSULTAR_JUNTA AS
select M.CD_PROCESSO_ELEITORAL ,
       mp.cd_pleito,
    M.SG_UE_MUN, 
    M.SG_UE_UF,
    M.ST_NOTIFICA_ODIN, 
    U.NM_UE, 
    M.NR_ZONA, 
    M.NR_JUNTA
 from MUN_ZONA_PROCESSO m join UE_PROCESSO u on
     (M.CD_PROCESSO_ELEITORAL = U.CD_PROCESSO_ELEITORAL AND M.SG_UE_MUN = U.SG_UE)
INNER JOIN mun_zona_pleito mp
      ON mp.cd_processo_eleitoral = m.cd_processo_eleitoral
			AND mp.sg_ue_uf = m.sg_ue_uf
			AND mp.sg_ue_mun = m.sg_ue_mun
			AND mp.nr_zona = m.nr_zona;