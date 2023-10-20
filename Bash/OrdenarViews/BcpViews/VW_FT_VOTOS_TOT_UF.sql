CREATE OR REPLACE VIEW vw_ft_votos_tot_uf
AS
    SELECT sq_dm_uf,
           cd_pleito,
           sg_ue_uf,
           qt_votos_nominais,
           CASE
               WHEN qt_votos_nominais = 0 THEN
                   '0,00'
               WHEN qt_votos_nominais = qt_votos_validos THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_nominais / qt_votos_validos *
                                   100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_nominais / qt_votos_validos *
                                   100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_nominais,
           DECODE(
                  qt_votos_nominais,
                  0, 0,
                  TRUNC(qt_votos_nominais / qt_votos_validos * 100, 9)
                 ) pe_votos_nominais_real,
           qt_votos_legenda,
           CASE
               WHEN qt_votos_legenda = 0 THEN
                   '0,00'
               WHEN qt_votos_legenda = qt_votos_validos THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_legenda / qt_votos_validos * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_legenda / qt_votos_validos * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_legenda,
           DECODE(
                  qt_votos_legenda,
                  0, 0,
                  TRUNC(qt_votos_legenda / qt_votos_validos * 100, 9)
                 ) pe_votos_legenda_real,
           qt_votos_validos,
           CASE
               WHEN qt_votos_validos = 0 THEN
                   '0,00'
               WHEN qt_votos_validos = qt_vt_tot_todos_cand_resp THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_validos /
                                   qt_vt_tot_todos_cand_resp * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_validos /
                                   qt_vt_tot_todos_cand_resp * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_validos,
           DECODE
           (
               qt_votos_validos,
               0, 0,
               TRUNC(qt_votos_validos / qt_vt_tot_todos_cand_resp * 100, 9)
           )   pe_votos_validos_real,
           qt_votos_brancos,
           CASE
               WHEN qt_votos_brancos = 0 THEN
                   '0,00'
               WHEN qt_votos_brancos = qt_vt_comp_todos_votaveis THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_brancos /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_brancos /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_brancos,
           DECODE
           (
               qt_votos_brancos,
               0, 0,
               TRUNC(qt_votos_brancos / qt_vt_comp_todos_votaveis * 100, 9)
           )   pe_votos_brancos_real,
           qt_votos_nulos,
           CASE
               WHEN qt_votos_nulos = 0 THEN
                   '0,00'
               WHEN qt_votos_nulos = qt_votos_nulo_nulo_tecnico THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_nulos /
                                   qt_votos_nulo_nulo_tecnico * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_nulos /
                                   qt_votos_nulo_nulo_tecnico * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_nulos,
           DECODE(
                  qt_votos_nulos,
                  0, 0,
                  TRUNC(qt_votos_nulos / qt_votos_nulo_nulo_tecnico * 100, 9)
                 ) pe_votos_nulos_real,
           qt_votos_nulo_tecnico,
           CASE
               WHEN qt_votos_nulo_tecnico = 0 THEN
                   '0,00'
               WHEN qt_votos_nulo_tecnico = qt_votos_nulo_nulo_tecnico THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_nulo_tecnico /
                                   qt_votos_nulo_nulo_tecnico * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_nulo_tecnico /
                                   qt_votos_nulo_nulo_tecnico * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_nulo_tecnico,
           DECODE
           (
               qt_votos_nulo_tecnico,
               0, 0,
               TRUNC(
                     qt_votos_nulo_tecnico / qt_votos_nulo_nulo_tecnico *
                     100,
                     9
                    )
           )   pe_votos_nulo_tecnico_real,
           qt_votos_nulo_nulo_tecnico,
           CASE
               WHEN qt_votos_nulo_nulo_tecnico = 0 THEN
                   '0,00'
               WHEN qt_votos_nulo_nulo_tecnico = qt_vt_comp_todos_votaveis THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_nulo_nulo_tecnico /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_nulo_nulo_tecnico /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_nulo_nulo_tecnico,
           DECODE
           (
               qt_votos_nulo_nulo_tecnico,
               0, 0,
               TRUNC(
                     qt_votos_nulo_nulo_tecnico / qt_vt_comp_todos_votaveis
                     * 100,
                     9
                    )
           )   pe_votos_nulo_nulo_tecnico_real,
           qt_votos_anulados,
           CASE
               WHEN qt_votos_anulados = 0 THEN
                   '0,00'
               WHEN qt_votos_anulados = qt_vt_tot_todos_cand_resp THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_anulados /
                                   qt_vt_tot_todos_cand_resp * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_anulados /
                                   qt_vt_tot_todos_cand_resp * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_anulados,
           DECODE
           (
               qt_votos_anulados,
               0, 0,
               TRUNC(qt_votos_anulados / qt_vt_tot_todos_cand_resp * 100, 9)
           )   pe_votos_anulados_real,
           qt_votos_anulados_sub_judice,
           CASE
               WHEN qt_votos_anulados_sub_judice = 0 THEN
                   '0,00'
               WHEN qt_votos_anulados_sub_judice = qt_vt_tot_todos_cand_resp THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_anulados_sub_judice /
                                   qt_vt_tot_todos_cand_resp * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_anulados_sub_judice /
                                   qt_vt_tot_todos_cand_resp * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_anulados_sub_judice,
           DECODE
           (
               qt_votos_anulados_sub_judice,
               0, 0,
               TRUNC(
                     qt_votos_anulados_sub_judice /
                     qt_vt_tot_todos_cand_resp * 100,
                     9
                    )
           )   pe_votos_anulados_sub_judice_real,
           qt_votos_anul_apurado_sep,
           CASE
               WHEN qt_votos_anul_apurado_sep = 0 THEN
                   '0,00'
               WHEN qt_votos_anul_apurado_sep = qt_vt_comp_todos_votaveis THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_anul_apurado_sep /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_anul_apurado_sep /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_anul_apurado_sep,
           DECODE
           (
               qt_votos_anul_apurado_sep,
               0, 0,
               TRUNC(
                     qt_votos_anul_apurado_sep / qt_vt_comp_todos_votaveis *
                     100,
                     9
                    )
           )   pe_votos_anul_apurado_sep_real,
           qt_votos_sem_cand_para_votar,
           CASE
               WHEN qt_votos_sem_cand_para_votar = 0 THEN
                   '0,00'
               WHEN qt_votos_sem_cand_para_votar = qt_vt_comp_todos_votaveis THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_sem_cand_para_votar /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_votos_sem_cand_para_votar /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_votos_sem_cand_para_votar,
           DECODE
           (
               qt_votos_sem_cand_para_votar,
               0, 0,
               TRUNC(
                     qt_votos_sem_cand_para_votar /
                     qt_vt_comp_todos_votaveis * 100,
                     9
                    )
           )   pe_votos_sem_cand_para_votar_real,
           qt_vt_comp_todos_cand_resp,
           CASE
               WHEN qt_vt_comp_todos_cand_resp = 0 THEN
                   '0,00'
               WHEN qt_vt_comp_todos_cand_resp = qt_vt_comp_todos_votaveis THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_vt_comp_todos_cand_resp /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_vt_comp_todos_cand_resp /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_vt_comp_todos_cand_resp,
           DECODE
           (
               qt_vt_comp_todos_cand_resp,
               0, 0,
               TRUNC(
                     qt_vt_comp_todos_cand_resp / qt_vt_comp_todos_votaveis
                     * 100,
                     9
                    )
           )   pe_vt_comp_todos_cand_resp_real,
           qt_vt_tot_todos_cand_resp,
           CASE
               WHEN qt_vt_tot_todos_cand_resp = 0 THEN
                   '0,00'
               WHEN qt_vt_tot_todos_cand_resp = qt_vt_comp_todos_votaveis THEN
                   '100,00'
               ELSE
                   DECODE
                   (
                       TRIM
                       (
                           TO_CHAR(
                                   qt_vt_tot_todos_cand_resp /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       ),
                       '100,00', '99,99',
                       '0,00', '0,01',
                       TRIM
                       (
                           TO_CHAR(
                                   qt_vt_tot_todos_cand_resp /
                                   qt_vt_comp_todos_votaveis * 100,
                                   '990D00'
                                  )
                       )
                   )
           END pe_vt_tot_todos_cand_resp,
           DECODE
           (
               qt_vt_tot_todos_cand_resp,
               0, 0,
               TRUNC(
                     qt_vt_tot_todos_cand_resp / qt_vt_comp_todos_votaveis *
                     100,
                     9
                    )
           )   pe_vt_tot_todos_cand_resp_real,
           qt_vt_comp_todos_votaveis,
           qt_vt_tot_todos_votaveis,
           dt_ult_tot_parcial_sec_hor_loc,
           dt_ult_tot_parcial_sec_hor_tse,
           cd_cargo_pergunta,
           cd_eleicao,
           dt_carga,
           dt_ult_tot_final_hor_loc,
           dt_ult_tot_final_hor_tse,
           cd_tipo_cargo_pergunta
      FROM ft_votos_tot_uf;