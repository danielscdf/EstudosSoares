CREATE OR REPLACE VIEW vw_ft_votos_votavel_zona
AS
    SELECT sq_dm_votavel,
           cd_pleito,
           cd_eleicao,
           sg_ue_uf,
           nr_zona,
           qt_votos_computados_votavel,
           CASE
               WHEN qt_votos_computados_votavel = 0 THEN
                   '0,00'
               WHEN qt_votos_computados_votavel = qt_vt_comp_todos_cand_resp THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_computados_votavel /
                                   qt_vt_comp_todos_cand_resp * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_computados_votavel /
                                   qt_vt_comp_todos_cand_resp * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_computados_votavel,
           DECODE
           (
               qt_votos_computados_votavel,
               0, 0,
               TRUNC(
                     qt_votos_computados_votavel /
                     qt_vt_comp_todos_cand_resp * 100,
                     9
                    )
           )   pe_votos_computados_votavel_real,
           qt_votos_totalizados_votavel,
           CASE
               WHEN qt_votos_totalizados_votavel = 0 THEN
                   '0,00'
               WHEN qt_votos_totalizados_votavel = qt_vt_tot_todos_votaveis THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_totalizados_votavel /
                                   qt_vt_tot_todos_votaveis * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_totalizados_votavel /
                                   qt_vt_tot_todos_votaveis * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_totalizados_votavel,
           DECODE
           (
               qt_votos_totalizados_votavel,
               0, 0,
               TRUNC(
                     qt_votos_totalizados_votavel / qt_vt_tot_todos_votaveis
                     * 100,
                     9
                    )
           )   pe_votos_totalizados_votavel_real,
           qt_total_vt_candidatos_partido,
           dt_carga,
           CASE
               WHEN qt_total_vt_candidatos_partido = 0 THEN
                   '0,00'
               WHEN qt_total_vt_candidatos_partido =
                    qt_vt_comp_todos_votaveis THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_total_vt_candidatos_partido /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_total_vt_candidatos_partido /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_total_vt_candidatos_partido,
           DECODE
           (
               qt_total_vt_candidatos_partido,
               0, 0,
               TRUNC(
                     qt_total_vt_candidatos_partido /
                     qt_vt_comp_todos_votaveis * 100,
                     9
                    )
           )   pe_total_vt_candidatos_partido_real,
           qt_vt_comp_todos_cand_resp,
           qt_vt_tot_todos_cand_resp,
           qt_vt_comp_todos_votaveis,
           qt_vt_tot_todos_votaveis
      FROM (  SELECT ft.sq_dm_votavel,
                     ft.cd_pleito,
                     ft.cd_eleicao,
                     ft.sg_ue_uf,
                     dm.nr_zona,
                     SUM(qt_votos_computados_votavel)
                         qt_votos_computados_votavel,
                     SUM(qt_votos_totalizados_votavel)
                         qt_votos_totalizados_votavel,
                     SUM(qt_total_vt_candidatos_partido)
                         qt_total_vt_candidatos_partido,
                     MAX(ft.dt_carga)
                         dt_carga,
                     SUM(qt_vt_comp_todos_cand_resp)
                         qt_vt_comp_todos_cand_resp,
                     SUM(qt_vt_tot_todos_cand_resp)
                         qt_vt_tot_todos_cand_resp,
                     SUM(qt_vt_comp_todos_votaveis)
                         qt_vt_comp_todos_votaveis,
                     SUM(qt_vt_tot_todos_votaveis)
                         qt_vt_tot_todos_votaveis
                FROM ft_votos_votavel_mun_zona ft
                     INNER JOIN dm_mun_zona dm
                         ON dm.cd_pleito = ft.cd_pleito
                        AND dm.cd_eleicao = ft.cd_eleicao
                        AND dm.sg_ue_uf = ft.sg_ue_uf
                        AND dm.sq_dm_mun_zona = ft.sq_dm_mun_zona
            GROUP BY ft.sq_dm_votavel,
                     ft.cd_pleito,
                     ft.cd_eleicao,
                     ft.sg_ue_uf,
                     dm.nr_zona) vw;