CREATE OR REPLACE VIEW vw_secoes_regiao_percent
AS
      SELECT s.cd_pleito,
             s.cd_eleicao,
             s.cd_tipo_cargo_pergunta,
             ue.cd_regiao,
             r.nm_regiao,
             SUM(s.qtd_eleitores)
                 qtd_eleitores,
             SUM(s.qtd_comparecimento)
                 qtd_comparecimento,
             TO_CHAR
             (
                 CASE
                     WHEN SUM(s.qtd_aptos_urnas_instaladas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_comparecimento) = 0 THEN
                         0
                     WHEN SUM(s.qtd_comparecimento) / SUM(
                          s.qtd_aptos_urnas_instaladas
                                                         ) * 100 BETWEEN 0.0000000000000001
                                                                     AND 0.001 THEN
                         0.01
                     ELSE
                         TRUNC
                         (
                             SUM(s.qtd_comparecimento) / SUM(
                             s.qtd_aptos_urnas_instaladas
                                                            ) * 100,
                             2
                         )
                 END,
                 '990D00'
             )
                 pe_comparecimento,
             SUM(s.qtd_abstencao)
                 qtd_abstencao,
             TO_CHAR
             (
                 CASE
                     WHEN SUM(s.qtd_aptos_urnas_instaladas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_abstencao) = 0 THEN
                         0
                     WHEN SUM(s.qtd_comparecimento) / SUM(
                          s.qtd_aptos_urnas_instaladas
                                                         ) * 100 BETWEEN 0.0000000000000001
                                                                     AND 0.001 THEN
                         100 - 0.01
                     ELSE
                         100 - TRUNC
                         (
                         SUM       (s.qtd_comparecimento) / SUM(
                         s.qtd_aptos_urnas_instaladas
                                                               ) * 100,
                         2
                         )
                 END,
                 '990D00'
             )
                 pe_abstencao,
             SUM(s.qtd_aptos_urnas_instaladas)
                 qtd_aptos_urnas_instaladas,
             TO_CHAR
             (
                 CASE
                     WHEN SUM(s.qtd_eleitores) = 0 THEN
                         0
                     WHEN SUM(s.qtd_aptos_urnas_instaladas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_aptos_urnas_instaladas) / SUM(
                          s.qtd_eleitores
                                                                 ) * 100 BETWEEN 0.0000000000000001
                                                                             AND 0.001 THEN
                         0.01
                     ELSE
                         TRUNC
                         (
                             SUM(s.qtd_aptos_urnas_instaladas) / SUM(
                             s.qtd_eleitores
                                                                    ) * 100,
                             2
                         )
                 END,
                 '990D00'
             )
                 pe_aptos_urnas_instaladas,
             SUM(s.qtd_aptos_urnas_nao_instaladas)
                 qtd_aptos_urnas_nao_instaladas,
             TO_CHAR
             (
                 CASE
                     WHEN SUM(s.qtd_eleitores) = 0 THEN
                         0
                     WHEN SUM(s.qtd_aptos_urnas_nao_instaladas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_aptos_urnas_nao_instaladas) + SUM(
                          s.qtd_aptos_urnas_instaladas
                                                                     ) =
                          SUM(s.qtd_eleitores)
                      AND SUM(s.qtd_aptos_urnas_instaladas) / SUM(
                          s.qtd_eleitores
                                                                 ) * 100 BETWEEN 0.0000000000000001
                                                                             AND 0.001 THEN
                         100 - 0.01
                     WHEN SUM(s.qtd_aptos_urnas_nao_instaladas) + SUM(
                          s.qtd_aptos_urnas_instaladas
                                                                     ) =
                          SUM(s.qtd_eleitores) THEN
                         100 - TRUNC
                         (
                         SUM       (s.qtd_aptos_urnas_instaladas) / SUM(
                         s.qtd_eleitores
                                                                       ) *
                         100,
                         2
                         )
                     ELSE
                         100 - TRUNC
                         (
                         SUM       (s.qtd_aptos_urnas_nao_instaladas) / SUM(
                         s.qtd_eleitores
                                                                           )
                         * 100,
                         2
                         )
                 END,
                 '990D00'
             )
                 pe_aptos_urnas_nao_instaladas,
             SUM(s.qtd_aptos_apurados)
                 qtd_aptos_apurados,
             TO_CHAR
             (
                 CASE
                     WHEN SUM(s.qtd_aptos_urnas_instaladas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_aptos_apurados) = 0 THEN
                         0
                     WHEN SUM(s.qtd_aptos_apurados) / SUM(
                          s.qtd_aptos_urnas_instaladas
                                                         ) * 100 BETWEEN 0.0000000000000001
                                                                     AND 0.001 THEN
                         0.01
                     WHEN SUM(s.qtd_aptos_apurados) / SUM(
                          s.qtd_aptos_urnas_instaladas
                                                         ) * 100 BETWEEN 0.0000000000000001
                                                                     AND 0.001 THEN
                         100 - 0.01
                     ELSE
                         TRUNC
                         (
                             SUM(s.qtd_aptos_apurados) / SUM(
                             s.qtd_aptos_urnas_instaladas
                                                            ) * 100,
                             2
                         )
                 END,
                 '990D00'
             )
                 pe_aptos_apurados,
             SUM(s.qtd_aptos_nao_apurados)
                 qtd_aptos_nao_apurados,
             TO_CHAR
             (
                 CASE
                     WHEN SUM(s.qtd_aptos_urnas_instaladas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_aptos_nao_apurados) = 0 THEN
                         0
                     WHEN SUM(s.qtd_aptos_apurados) / SUM(
                          s.qtd_aptos_urnas_instaladas
                                                         ) * 100 BETWEEN 0.0000000000000001
                                                                     AND 0.001 THEN
                         100 - 0.01
                     ELSE
                         100 - TRUNC
                         (
                         SUM       (s.qtd_aptos_apurados) / SUM(
                         s.qtd_aptos_urnas_instaladas
                                                               ) * 100,
                         2
                         )
                 END,
                 '990D00'
             )
                 pe_aptos_nao_apurados,
             SUM(s.qtd_secoes)
                 qtd_secoes,
             SUM(s.qtd_secoes_totalizadas)
                 qtd_secoes_totalizadas,
             TO_CHAR
             (
                 CASE
                     WHEN SUM(s.qtd_secoes) = 0 THEN
                         0
                     WHEN SUM(s.qtd_secoes_totalizadas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_secoes_totalizadas) / SUM(s.qtd_secoes)
                          * 100 BETWEEN 0.0000000000000001
                                    AND 0.001 THEN
                         0.01
                     ELSE
                         TRUNC
                         (
                             SUM(s.qtd_secoes_totalizadas) / SUM(s.qtd_secoes)
                             * 100,
                             2
                         )
                 END,
                 '990D00'
             )
                 pe_secoes_totalizadas,
             SUM(s.qtd_secoes_nao_tot)
                 qtd_secoes_nao_tot,
             TO_CHAR
             (
                 CASE
                     WHEN SUM(s.qtd_secoes) = 0 THEN
                         0
                     WHEN SUM(s.qtd_secoes_nao_tot) = 0 THEN
                         0
                     WHEN SUM(s.qtd_secoes_totalizadas) / SUM(s.qtd_secoes)
                          * 100 BETWEEN 0.0000000000000001
                                    AND 0.001 THEN
                         100 - 0.01
                     ELSE
                         100 - TRUNC
                         (
                         SUM       (s.qtd_secoes_totalizadas) / SUM(
                         s.qtd_secoes
                                                                   ) * 100,
                         2
                         )
                 END,
                 '990D00'
             )
                 pe_secoes_nao_totalizadas,
             SUM(s.qtd_secoes_instaladas)
                 qtd_secoes_instaladas,
             TO_CHAR
             (
                 CASE
                     WHEN SUM(s.qtd_secoes) = 0 THEN
                         0
                     WHEN SUM(s.qtd_secoes_instaladas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_secoes_instaladas) / SUM(s.qtd_secoes) *
                          100 BETWEEN 0.0000000000000001
                                  AND 0.001 THEN
                         0.01
                     ELSE
                         TRUNC(
                               SUM(s.qtd_secoes_instaladas) / SUM(s.qtd_secoes)
                               * 100,
                               2
                              )
                 END,
                 '990D00'
             )
                 pe_secoes_instaladas,
             SUM(s.qtd_secoes_nao_instaladas)
                 qtd_secoes_nao_instaladas,
             TO_CHAR
             (
                 CASE
                     WHEN SUM(s.qtd_secoes) = 0 THEN
                         0
                     WHEN SUM(s.qtd_secoes_nao_instaladas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_secoes_instaladas) / SUM(s.qtd_secoes) *
                          100 BETWEEN 0.0000000000000001
                                  AND 0.001 THEN
                         100 - 0.01
                     ELSE
                         100 - TRUNC
                         (
                         SUM       (s.qtd_secoes_instaladas) / SUM(s.qtd_secoes
                         ) * 100,
                         2
                         )
                 END,
                 '990D00'
             )
                 pe_secoes_nao_instaladas,
             SUM(s.qtd_secoes_nao_apuradas)
                 qtd_secoes_nao_apuradas,
             TO_CHAR
             (
                 CASE
                     WHEN SUM(s.qtd_secoes_instaladas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_secoes_nao_apuradas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_secoes_nao_apuradas) / SUM(
                          s.qtd_secoes_instaladas
                                                              ) * 100 BETWEEN 0.0000000000000001
                                                                          AND 0.001 THEN
                         0.01
                     ELSE
                         TRUNC
                         (
                             SUM(s.qtd_secoes_nao_apuradas) / SUM(
                             s.qtd_secoes_instaladas
                                                                 ) * 100,
                             2
                         )
                 END,
                 '990D00'
             )
                 pe_secoes_nao_apuradas,
             SUM(s.qtd_secoes_apuradas)
                 qtd_secoes_apuradas,
             TO_CHAR
             (
                 CASE
                     WHEN SUM(s.qtd_secoes_instaladas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_secoes_apuradas) = 0 THEN
                         0
                     WHEN SUM(s.qtd_secoes_nao_apuradas) / SUM(
                          s.qtd_secoes_instaladas
                                                              ) * 100 BETWEEN 0.0000000000000001
                                                                          AND 0.001 THEN
                         100 - 0.01
                     ELSE
                         100 - TRUNC
                         (
                         SUM       (s.qtd_secoes_nao_apuradas) / SUM(
                         s.qtd_secoes_instaladas
                                                                    ) * 100,
                         2
                         )
                 END,
                 '990D00'
             )
                 pe_secoes_apuradas
        FROM vw_secoes_uf_percent s
             INNER JOIN pleito p ON s.cd_pleito = p.cd_pleito
             INNER JOIN ue_processo ue
                 ON p.cd_processo_eleitoral = ue.cd_processo_eleitoral
                AND s.sg_ue_uf = ue.sg_ue
                AND ue.sg_ue_superior = 'BR'
             INNER JOIN regiao r ON ue.cd_regiao = r.cd_regiao
    GROUP BY s.cd_pleito,
             s.cd_eleicao,
             s.cd_tipo_cargo_pergunta,
             ue.cd_regiao,
             r.nm_regiao;