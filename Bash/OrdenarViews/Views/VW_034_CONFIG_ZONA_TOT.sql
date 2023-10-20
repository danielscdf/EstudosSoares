CREATE OR REPLACE VIEW vw_034_config_zona_tot
AS
    WITH secoes_totalizadas
         AS (  SELECT SUM(CASE se.tp_situacao_totalizacao WHEN 'T' THEN 1 ELSE 0 END) qt_secoes_tot,
                      SUM(CASE se.tp_situacao_totalizacao WHEN 'T' THEN se.qt_aptos ELSE 0 END) qt_aptos_tot,
                      se.cd_pleito,
                      se.cd_eleicao,
                      se.sg_ue_uf,
                      se.sg_ue_mun
                 FROM secao_eleicao se
                WHERE se.tp_situacao_totalizacao = 'T'
             GROUP BY se.cd_pleito,
                      se.cd_eleicao,
                      se.sg_ue_uf,
                      se.sg_ue_mun)
      SELECT ue.cd_eleicao AS codigoeleicao,
             e.nm_eleicao,
             ue.sg_ue_uf,
             UP.sg_ue_superior AS uf,
             UP.sg_ue AS codigomunicipio,
             UP.nm_ue AS nomemunicipio,
             mze.nr_zona AS numerozona,
             mzp.nr_junta AS numerojunta,
             COUNT(mze.nr_zona)
                 OVER(
                      PARTITION BY ue.cd_pleito,
                                   ue.sg_ue_uf,
                                   ue.cd_eleicao,
                                   ue.sg_ue
                     )
                 AS qtd_zona,
             MAX(mze.st_totaliza)
                 OVER(
                      PARTITION BY ue.cd_pleito,
                                   ue.sg_ue_uf,
                                   ue.cd_eleicao,
                                   ue.sg_ue
                     )
                 AS mun_possui_zona_tot,
             ue.cd_pleito,
             mze.dt_gera_rel_amb_tot_hor_tse,
             mze.dt_gera_rel_amb_tot_hor_loc,
             mze.qt_aptos,
             NVL(st.qt_secoes_tot, 0) qt_secoes_tot,
             NVL(st.qt_aptos_tot, 0) qt_aptos_tot,
             mze.st_espelho_oficializacao,
             mze.st_totaliza,
             mze.st_zeresima
        FROM ue_eleicao ue,
             eleicao e,
             ue_processo UP,
             mun_zona_eleicao mze,
             mun_zona_processo mzp,
             secoes_totalizadas st
       WHERE ue.cd_processo_eleitoral = UP.cd_processo_eleitoral
         AND UP.cd_processo_eleitoral = mzp.cd_processo_eleitoral
         AND ue.cd_pleito = mze.cd_pleito
         AND ue.cd_pleito = e.cd_pleito
         AND ue.cd_eleicao = mze.cd_eleicao
         AND ue.cd_eleicao = e.cd_eleicao
         AND ue.sg_ue_uf = mzp.sg_ue_uf
         AND mzp.sg_ue_uf = mze.sg_ue_uf
         AND ue.sg_ue = UP.sg_ue
         AND UP.sg_ue = mzp.sg_ue_mun
         AND mzp.sg_ue_mun = mze.sg_ue_mun
         AND mze.nr_zona = mzp.nr_zona
         AND st.cd_pleito(+) = ue.cd_pleito
         AND st.cd_eleicao(+) = ue.cd_eleicao
         AND st.sg_ue_uf(+) = ue.sg_ue_uf
         AND st.sg_ue_mun(+) = ue.sg_ue
    ORDER BY ue.cd_eleicao, UP.sg_ue_superior, UP.nm_ue, mze.nr_zona, mzp.nr_junta;