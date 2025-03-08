CREATE OR REPLACE VIEW vw_secoes_uf_percent
AS
    SELECT cd_pleito,
           cd_eleicao,
           cd_tipo_cargo_pergunta,
           sg_ue_uf,
           qtd_eleitores,
           qtd_comparecimento,
           TO_CHAR(CASE WHEN qtd_aptos_urnas_instaladas = 0 THEN 0 WHEN qtd_comparecimento = 0 THEN 0 WHEN qtd_comparecimento / qtd_aptos_urnas_instaladas * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE TRUNC(qtd_comparecimento / qtd_aptos_urnas_instaladas * 100, 2) END, '990D00')
               pe_comparecimento,
           qtd_abstencao,
           TO_CHAR(CASE WHEN qtd_aptos_urnas_instaladas = 0 THEN 0 WHEN qtd_abstencao = 0 THEN 0 WHEN qtd_comparecimento / qtd_aptos_urnas_instaladas * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 100 - 0.01 ELSE 100 - TRUNC(qtd_comparecimento / qtd_aptos_urnas_instaladas * 100, 2) END, '990D00')
               pe_abstencao,
           qtd_aptos_urnas_instaladas,
           TO_CHAR(CASE WHEN qtd_eleitores = 0 THEN 0 WHEN qtd_aptos_urnas_instaladas = 0 THEN 0 WHEN qtd_aptos_urnas_instaladas / qtd_eleitores * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE TRUNC(qtd_aptos_urnas_instaladas / qtd_eleitores * 100, 2) END, '990D00') pe_aptos_urnas_instaladas,
           qtd_aptos_urnas_nao_instaladas,
           --TO_CHAR(CASE WHEN qtd_eleitores = 0 THEN 0 WHEN qtd_aptos_urnas_nao_instaladas = 0 THEN 0 WHEN qtd_aptos_urnas_instaladas / qtd_eleitores * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 100 - 0.01 ELSE 100 - (qtd_aptos_urnas_instaladas / qtd_eleitores * 100) END, '990D00')
           TO_CHAR(
                   CASE
                       WHEN qtd_eleitores = 0 THEN
                           0
                       WHEN qtd_aptos_urnas_nao_instaladas = 0 THEN
                           0
                       WHEN qtd_aptos_urnas_nao_instaladas + qtd_aptos_urnas_instaladas = qtd_eleitores
                        AND qtd_aptos_urnas_instaladas / qtd_eleitores * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN
                           100 - 0.01
                       WHEN qtd_aptos_urnas_nao_instaladas + qtd_aptos_urnas_instaladas = qtd_eleitores THEN
                           100 - TRUNC(qtd_aptos_urnas_instaladas / qtd_eleitores * 100, 2)
                       ELSE
                           100 - TRUNC(qtd_aptos_urnas_nao_instaladas / qtd_eleitores * 100, 2)
                   END,
                   '990D00'
                  )
               pe_aptos_urnas_nao_instaladas,
           qtd_aptos_apurados,
           TO_CHAR(CASE WHEN qtd_aptos_urnas_instaladas = 0 THEN 0 WHEN qtd_aptos_apurados = 0 THEN 0 WHEN qtd_aptos_apurados / qtd_aptos_urnas_instaladas * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE TRUNC(qtd_aptos_apurados / qtd_aptos_urnas_instaladas * 100, 2) END, '990D00')
               pe_aptos_apurados,
           qtd_aptos_nao_apurados,
           TO_CHAR(
                   CASE WHEN qtd_aptos_urnas_instaladas = 0 THEN 0 WHEN qtd_aptos_nao_apurados = 0 THEN 0 WHEN qtd_aptos_apurados / qtd_aptos_urnas_instaladas * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 100 - 0.01 ELSE 100 - TRUNC(qtd_aptos_apurados / qtd_aptos_urnas_instaladas * 100, 2) END,
                   '990D00'
                  )
               pe_aptos_nao_apurados,
           qtd_secoes,
           qtd_secoes_totalizadas,
           TO_CHAR(CASE WHEN qtd_secoes = 0 THEN 0 WHEN qtd_secoes_totalizadas = 0 THEN 0 WHEN qtd_secoes_totalizadas / qtd_secoes * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE TRUNC(qtd_secoes_totalizadas / qtd_secoes * 100, 2) END, '990D00') pe_secoes_totalizadas,
           qtd_secoes_nao_tot,
           TO_CHAR(CASE WHEN qtd_secoes = 0 THEN 0 WHEN qtd_secoes_nao_tot = 0 THEN 0 WHEN qtd_secoes_totalizadas / qtd_secoes * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 100 - 0.01 ELSE 100 - TRUNC(qtd_secoes_totalizadas / qtd_secoes * 100, 2) END, '990D00') pe_secoes_nao_totalizadas,
           qtd_secoes_instaladas,
           TO_CHAR(CASE WHEN qtd_secoes = 0 THEN 0 WHEN qtd_secoes_instaladas = 0 THEN 0 WHEN qtd_secoes_instaladas / qtd_secoes * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE TRUNC(qtd_secoes_instaladas / qtd_secoes * 100, 2) END, '990D00') pe_secoes_instaladas,
           qtd_secoes_nao_instaladas,
           TO_CHAR(CASE WHEN qtd_secoes = 0 THEN 0 WHEN qtd_secoes_nao_instaladas = 0 THEN 0 WHEN qtd_secoes_instaladas / qtd_secoes * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 100 - 0.01 ELSE 100 - TRUNC(qtd_secoes_instaladas / qtd_secoes * 100, 2) END, '990D00') pe_secoes_nao_instaladas,
           qtd_secoes_nao_apuradas,
           TO_CHAR(CASE WHEN qtd_secoes_instaladas = 0 THEN 0 WHEN qtd_secoes_nao_apuradas = 0 THEN 0 WHEN qtd_secoes_nao_apuradas / qtd_secoes_instaladas * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 0.01 ELSE TRUNC(qtd_secoes_nao_apuradas / qtd_secoes_instaladas * 100, 2) END, '990D00')
               pe_secoes_nao_apuradas,
           qtd_secoes_apuradas,
           TO_CHAR(CASE WHEN qtd_secoes_instaladas = 0 THEN 0 WHEN qtd_secoes_apuradas = 0 THEN 0 WHEN qtd_secoes_nao_apuradas / qtd_secoes_instaladas * 100 BETWEEN 0.0000000000000001 AND 0.001 THEN 100 - 0.01 ELSE 100 - TRUNC(qtd_secoes_nao_apuradas / qtd_secoes_instaladas * 100, 2) END, '990D00')
               pe_secoes_apuradas
      FROM vw_secoes_uf;