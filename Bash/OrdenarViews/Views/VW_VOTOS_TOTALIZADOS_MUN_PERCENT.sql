CREATE OR REPLACE VIEW vw_votos_totalizados_mun_percent
AS
    SELECT total_votos_nominais_validos,
           TO_CHAR(CASE WHEN total_votos_validos = 0 THEN 0 WHEN total_votos_nominais_validos = 0 THEN 0 WHEN total_votos_nominais_validos / total_votos_validos * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_votos_nominais_validos / total_votos_validos * 100 END, '990D00')
               pe_votos_nominais_validos,
           total_votos_brancos,
           TO_CHAR
           (
               CASE
                   WHEN qt_total_votos_computados = 0 THEN
                       0
                   WHEN total_votos_brancos = 0 THEN
                       0
                   ELSE
                       100 - (TO_CHAR(CASE WHEN total_votos_cand_concorrentes = 0 THEN 0 WHEN total_votos_cand_concorrentes / qt_total_votos_computados * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_votos_cand_concorrentes / qt_total_votos_computados * 100 END, '990D00') + TO_CHAR(
                       CASE WHEN soma_votos_nulos = 0 THEN 0 WHEN soma_votos_nulos / qt_total_votos_computados * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE soma_votos_nulos / qt_total_votos_computados * 100 END,
                       '990D00'
                                                                                                                                                                                                                                                                                                      ) +
                       TO_CHAR                                                                                                                                                                                                                                                                            (
                       CASE WHEN total_votos_anul_apurado_sep = 0 THEN 0 WHEN total_votos_anul_apurado_sep / qt_total_votos_computados * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_votos_anul_apurado_sep / qt_total_votos_computados * 100 END,
                       '990D00'
                                                                                                                                                                                                                                                                                                          ))
               END,
               '990D00'
           )
               pe_votos_brancos,
           soma_votos_nulos,
           TO_CHAR
           (
               CASE
                   WHEN qt_total_votos_computados = 0 THEN
                       0
                   WHEN soma_votos_nulos = 0 THEN
                       0
                   WHEN total_votos_brancos > 0
                    AND soma_votos_nulos / qt_total_votos_computados * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                       0.01
                   WHEN total_votos_brancos > 0 THEN
                       soma_votos_nulos / qt_total_votos_computados * 100
                   ELSE
                       100 - (TO_CHAR(CASE WHEN total_votos_cand_concorrentes = 0 THEN 0 WHEN total_votos_cand_concorrentes / qt_total_votos_computados * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_votos_cand_concorrentes / qt_total_votos_computados * 100 END, '990D00') + TO_CHAR(
                       CASE WHEN total_votos_anul_apurado_sep = 0 THEN 0 WHEN total_votos_anul_apurado_sep / qt_total_votos_computados * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_votos_anul_apurado_sep / qt_total_votos_computados * 100 END,
                       '990D00'
                                                                                                                                                                                                                                                                                                      ))
               END,
               '990D00'
           )
               pe_soma_votos_nulos,
           total_votos_legenda,
           TO_CHAR(CASE WHEN total_votos_validos = 0 THEN 0 WHEN total_votos_legenda = 0 THEN 0 WHEN total_votos_nominais_validos / total_votos_validos * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 100 - 0.01 ELSE 100 - (total_votos_nominais_validos / total_votos_validos * 100) END, '990D00')
               pe_votos_legenda,
           total_sem_cand_para_votar,
           TO_CHAR(CASE WHEN total_sem_cand_para_votar = 0 THEN 0 WHEN qt_total_votos_computados = 0 THEN 0 WHEN total_sem_cand_para_votar / qt_total_votos_computados * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_sem_cand_para_votar / qt_total_votos_computados * 100 END, '990D00')
               pe_votos_sem_cand_para_votar,
           total_votos_anulado,
           TO_CHAR(
                   CASE
                       WHEN total_votos_cand_concorrentes = 0 THEN
                           0
                       WHEN total_votos_anulado = 0 THEN
                           0
                       WHEN total_votos_anulado_sub_judice > 0
                        AND total_votos_anulado / total_votos_cand_concorrentes * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                           0.01
                       WHEN total_votos_anulado_sub_judice > 0 THEN
                           total_votos_anulado / total_votos_cand_concorrentes * 100
                       ELSE
                           100 - (TO_CHAR(CASE WHEN total_votos_validos = 0 THEN 0 WHEN total_votos_validos / total_votos_cand_concorrentes * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_votos_validos / total_votos_cand_concorrentes * 100 END, '990D00'))
                   END,
                   '990D00'
                  )
               pe_votos_anulado,
           total_votos_anulado_sub_judice,
           TO_CHAR
           (
               CASE
                   WHEN total_votos_cand_concorrentes = 0 THEN
                       0
                   WHEN total_votos_anulado_sub_judice = 0 THEN
                       0
                   ELSE
                       100 - (TO_CHAR(CASE WHEN total_votos_validos = 0 THEN 0 WHEN total_votos_validos / total_votos_cand_concorrentes * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_votos_validos / total_votos_cand_concorrentes * 100 END, '990D00') + TO_CHAR(
                       CASE WHEN total_votos_anulado = 0 THEN 0 WHEN total_votos_anulado / total_votos_cand_concorrentes * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_votos_anulado / total_votos_cand_concorrentes * 100 END,
                       '990D00'
                                                                                                                                                                                                                                                                                    ))
               END,
               '990D00'
           )
               pe_votos_anulado_sub_judice,
           total_votos_nulos,
           TO_CHAR(CASE WHEN soma_votos_nulos = 0 THEN 0 WHEN total_votos_nulos = 0 THEN 0 WHEN total_votos_nulos / soma_votos_nulos * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_votos_nulos / soma_votos_nulos * 100 END, '990D00') pe_votos_nulos,
           total_votos_nulo_tecnico,
           TO_CHAR(CASE WHEN soma_votos_nulos = 0 THEN 0 WHEN total_votos_nulo_tecnico = 0 THEN 0 WHEN total_votos_nulos / soma_votos_nulos * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 100 - 0.01 ELSE 100 - (total_votos_nulos / soma_votos_nulos * 100) END, '990D00') pe_votos_nulo_tecnico,
           total_votos_anul_apurado_sep,
           TO_CHAR(CASE WHEN qt_total_votos_computados = 0 THEN 0 WHEN total_votos_anul_apurado_sep = 0 THEN 0 WHEN total_votos_anul_apurado_sep / qt_total_votos_computados * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_votos_anul_apurado_sep / qt_total_votos_computados * 100 END, '990D00')
               pe_votos_anul_apurado_sep,
           total_votos_validos,
           TO_CHAR(CASE WHEN total_votos_cand_concorrentes = 0 THEN 0 WHEN total_votos_validos = 0 THEN 0 WHEN total_votos_validos / total_votos_cand_concorrentes * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_votos_validos / total_votos_cand_concorrentes * 100 END, '990D00')
               pe_votos_validos,
           total_votos_cand_concorrentes,
           TO_CHAR(
                   CASE WHEN qt_total_votos_computados = 0 THEN 0 WHEN total_votos_cand_concorrentes = 0 THEN 0 WHEN total_votos_cand_concorrentes / qt_total_votos_computados * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE total_votos_cand_concorrentes / qt_total_votos_computados * 100 END,
                   '990D00'
                  )
               pe_total_votos_cand_concorrentes,
           total_part_col,
           qt_total_votos_computados,
           qt_votos_computados_votavel,
           TO_CHAR(
                   CASE WHEN total_votos_cand_concorrentes = 0 THEN 0 WHEN qt_votos_computados_votavel = 0 THEN 0 WHEN qt_votos_computados_votavel / total_votos_cand_concorrentes * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE qt_votos_computados_votavel / total_votos_cand_concorrentes * 100 END,
                   '990D00'
                  )
               pe_votos_computados_votavel,
           TO_CHAR(CASE WHEN total_part_col = 0 THEN 0 WHEN qt_votos_computados_votavel = 0 THEN 0 WHEN qt_votos_computados_votavel / total_part_col * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE qt_votos_computados_votavel / total_part_col * 100 END, '990D00') pe_votos_computados_part_col,
           qt_votos_totalizados_votavel,
           sg_ue_uf,
           cd_pleito,
           cd_eleicao,
           sg_ue,
           sg_ue_mun,
           cd_cargo_pergunta,
           nr_votavel,
           cd_tipo_votavel_destinacao,
           cd_tipo_cargo_pergunta
      FROM vw_votos_totalizados_mun;