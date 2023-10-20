CREATE OR REPLACE VIEW vw_ft_votos_votavel_uf
AS
    SELECT sq_dm_uf,
           sq_dm_votavel,
           cd_pleito,
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
           sg_ue_uf,
           cd_eleicao,
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
      FROM ft_votos_votavel_uf;