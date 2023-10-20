CREATE OR REPLACE view vw_secoes_br_percent
AS
SELECT s.cd_pleito,
       s.cd_eleicao,
       s.cd_tipo_cargo_pergunta,
			 sum(s.qtd_eleitores) qtd_eleitores,
			 sum(s.qtd_comparecimento) qtd_comparecimento,
       to_char(CASE
                    WHEN sum(s.qtd_aptos_urnas_instaladas) = 0 THEN
                     0
                    WHEN sum(s.qtd_comparecimento) = 0 THEN
                     0
                    WHEN sum(s.qtd_comparecimento) / sum(s.qtd_aptos_urnas_instaladas) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     0.01
                    ELSE
                     trunc(sum(s.qtd_comparecimento) / sum(s.qtd_aptos_urnas_instaladas) * 100, 2)
                END,
                '990D00') pe_comparecimento,
       sum(s.qtd_abstencao) qtd_abstencao,
       to_char(CASE
                    WHEN sum(s.qtd_aptos_urnas_instaladas) = 0 THEN
                     0
                    WHEN sum(s.qtd_abstencao) = 0 THEN
                     0
                    WHEN sum(s.qtd_comparecimento) / sum(s.qtd_aptos_urnas_instaladas) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     100 - 0.01
                    ELSE
                     100 - trunc(sum(s.qtd_comparecimento) / sum(s.qtd_aptos_urnas_instaladas) * 100, 2)
                END,
                '990D00') pe_abstencao,
       sum(s.qtd_aptos_urnas_instaladas)qtd_aptos_urnas_instaladas,
       to_char(CASE
                    WHEN sum(s.qtd_eleitores) = 0 THEN
                     0
                    WHEN sum(s.qtd_aptos_urnas_instaladas) = 0 THEN
                     0
                    WHEN sum(s.qtd_aptos_urnas_instaladas) / sum(s.qtd_eleitores) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     0.01
                    ELSE
                     trunc(sum(s.qtd_aptos_urnas_instaladas) / sum(s.qtd_eleitores) * 100, 2)
                END,
                '990D00') pe_aptos_urnas_instaladas,
       sum(s.qtd_aptos_urnas_nao_instaladas) qtd_aptos_urnas_nao_instaladas,
       to_char(CASE
                    WHEN sum(s.qtd_eleitores) = 0 THEN
                     0
                    WHEN sum(s.qtd_aptos_urnas_nao_instaladas) = 0 THEN
                     0
                    WHEN sum(s.qtd_aptos_urnas_nao_instaladas) + sum(s.qtd_aptos_urnas_instaladas) = sum(s.qtd_eleitores)
                         AND sum(s.qtd_aptos_urnas_instaladas) / sum(s.qtd_eleitores) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     100 - 0.01
                    WHEN sum(s.qtd_aptos_urnas_nao_instaladas) + sum(s.qtd_aptos_urnas_instaladas) = sum(s.qtd_eleitores) THEN
                     100 - trunc(sum(s.qtd_aptos_urnas_instaladas) / sum(s.qtd_eleitores) * 100, 2)
                    ELSE
                     100 - trunc(sum(s.qtd_aptos_urnas_nao_instaladas) / sum(s.qtd_eleitores) * 100, 2)
                END,
                '990D00') pe_aptos_urnas_nao_instaladas,
       sum(s.qtd_aptos_apurados) qtd_aptos_apurados,
       to_char(CASE
                    WHEN sum(s.qtd_aptos_urnas_instaladas) = 0 THEN
                     0
                    WHEN sum(s.qtd_aptos_apurados) = 0 THEN
                     0
                    WHEN sum(s.qtd_aptos_apurados) / sum(s.qtd_aptos_urnas_instaladas) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     0.01
                    WHEN sum(s.qtd_aptos_apurados) / sum(s.qtd_aptos_urnas_instaladas) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     100 - 0.01
                    ELSE
                     trunc(sum(s.qtd_aptos_apurados) / sum(s.qtd_aptos_urnas_instaladas) * 100, 2)
                END,
                '990D00') pe_aptos_apurados,
       sum(s.qtd_aptos_nao_apurados) qtd_aptos_nao_apurados,
       to_char(CASE
                    WHEN sum(s.qtd_aptos_urnas_instaladas) = 0 THEN
                     0
                    WHEN sum(s.qtd_aptos_nao_apurados) = 0 THEN
                     0
                    WHEN sum(s.qtd_aptos_apurados) / sum(s.qtd_aptos_urnas_instaladas) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     100 - 0.01
                    ELSE
                     100 - trunc(sum(s.qtd_aptos_apurados) / sum(s.qtd_aptos_urnas_instaladas) * 100, 2)
                END,
                '990D00') pe_aptos_nao_apurados,
       sum(s.qtd_secoes) qtd_secoes,
       sum(s.qtd_secoes_totalizadas) qtd_secoes_totalizadas,
       to_char(CASE
                    WHEN sum(s.qtd_secoes) = 0 THEN
                     0
                    WHEN sum(s.qtd_secoes_totalizadas) = 0 THEN
                     0
                    WHEN sum(s.qtd_secoes_totalizadas) / sum(s.qtd_secoes) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     0.01
                    ELSE
                     trunc(sum(s.qtd_secoes_totalizadas) / sum(s.qtd_secoes) * 100, 2)
                END,
                '990D00') pe_secoes_totalizadas,
       sum(s.qtd_secoes_nao_tot) qtd_secoes_nao_tot,
       to_char(CASE
                    WHEN sum(s.qtd_secoes) = 0 THEN
                     0
                    WHEN sum(s.qtd_secoes_nao_tot) = 0 THEN
                     0
                    WHEN sum(s.qtd_secoes_totalizadas) / sum(s.qtd_secoes) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     100 - 0.01
                    ELSE
                     100 - trunc(sum(s.qtd_secoes_totalizadas) / sum(s.qtd_secoes) * 100, 2)
                END,
                '990D00') pe_secoes_nao_totalizadas,
       sum(s.qtd_secoes_instaladas) qtd_secoes_instaladas,
       to_char(CASE
                    WHEN sum(s.qtd_secoes) = 0 THEN
                     0
                    WHEN sum(s.qtd_secoes_instaladas) = 0 THEN
                     0
                    WHEN sum(s.qtd_secoes_instaladas) / sum(s.qtd_secoes) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     0.01
                    ELSE
                     trunc(sum(s.qtd_secoes_instaladas) / sum(s.qtd_secoes) * 100, 2)
                END,
                '990D00') pe_secoes_instaladas,
       sum(s.qtd_secoes_nao_instaladas) qtd_secoes_nao_instaladas,
       to_char(CASE
                    WHEN sum(s.qtd_secoes) = 0 THEN
                     0
                    WHEN sum(s.qtd_secoes_nao_instaladas) = 0 THEN
                     0
                    WHEN sum(s.qtd_secoes_instaladas) / sum(s.qtd_secoes) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     100 - 0.01
                    ELSE
                     100 - trunc(sum(s.qtd_secoes_instaladas) / sum(s.qtd_secoes) * 100, 2)
                END,
                '990D00') pe_secoes_nao_instaladas,
       sum(s.qtd_secoes_nao_apuradas) qtd_secoes_nao_apuradas,
       to_char(CASE
                    WHEN sum(s.qtd_secoes_instaladas) = 0 THEN
                     0
                    WHEN sum(s.qtd_secoes_nao_apuradas) = 0 THEN
                     0
                    WHEN sum(s.qtd_secoes_nao_apuradas) / sum(s.qtd_secoes_instaladas) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     0.01
                    ELSE
                     trunc(sum(s.qtd_secoes_nao_apuradas) / sum(s.qtd_secoes_instaladas) * 100, 2)
                END,
                '990D00') pe_secoes_nao_apuradas,
       sum(s.qtd_secoes_apuradas) qtd_secoes_apuradas,
       to_char(CASE
                    WHEN sum(s.qtd_secoes_instaladas) = 0 THEN
                     0
                    WHEN sum(s.qtd_secoes_apuradas) = 0 THEN
                     0
                    WHEN sum(s.qtd_secoes_nao_apuradas) / sum(s.qtd_secoes_instaladas) * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                     100 - 0.01
                    ELSE
                     100 - trunc(sum(s.qtd_secoes_nao_apuradas) / sum(s.qtd_secoes_instaladas) * 100, 2)
                END,
                '990D00') pe_secoes_apuradas
FROM vw_secoes_uf_percent s
GROUP BY s.cd_pleito, s.cd_eleicao, s.cd_tipo_cargo_pergunta;