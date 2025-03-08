CREATE OR REPLACE VIEW vw_ft_secoes_regiao
AS
    SELECT sq_dm_regiao,
           cd_pleito,
           cd_eleicao,
           cd_tipo_cargo_pergunta,
           qt_eleitores,
           qt_comparecimento,
           CASE
               WHEN qt_comparecimento = 0 THEN
                   '0,00'
               WHEN qt_comparecimento = qt_aptos_urnas_instaladas THEN
                   '100,00'
               ELSE
                   DECODE(TRIM(TO_CHAR(qt_comparecimento / qt_aptos_urnas_instaladas * 100, '990D00')), '100,00', '99,99', '0,00', '0,01', TRIM(TO_CHAR(qt_comparecimento / qt_aptos_urnas_instaladas * 100, '990D00')))
           END   pe_comparecimento,
           DECODE(qt_comparecimento, 0, 0, trunc(qt_comparecimento / qt_aptos_urnas_instaladas * 100, 9)) pe_comparecimento_real,
           qt_abstencao,
           CASE
               WHEN qt_abstencao = 0 THEN
                   '0,00'
               WHEN qt_abstencao = qt_aptos_urnas_instaladas THEN
                   '100,00'
               ELSE
                   DECODE(TRIM(TO_CHAR(qt_abstencao / qt_aptos_urnas_instaladas * 100, '990D00')), '100,00', '99,99', '0,00', '0,01', TRIM(TO_CHAR(qt_abstencao / qt_aptos_urnas_instaladas * 100, '990D00')))
           END pe_abstencao,
           DECODE(qt_abstencao, 0, 0, trunc(qt_abstencao / qt_aptos_urnas_instaladas * 100, 9)) pe_abstencao_real,
           qt_aptos_urnas_instaladas,
           CASE
               WHEN qt_aptos_urnas_instaladas = 0 THEN
                   '0,00'
               WHEN qt_aptos_urnas_instaladas = qt_eleitores THEN
                   '100,00'
               ELSE
                   DECODE(TRIM(TO_CHAR(qt_aptos_urnas_instaladas / qt_eleitores * 100, '990D00')), '100,00', '99,99', '0,00', '0,01', TRIM(TO_CHAR(qt_aptos_urnas_instaladas / qt_eleitores * 100, '990D00')))
           END   pe_aptos_urnas_instaladas,
           DECODE(qt_aptos_urnas_instaladas, 0, 0, trunc(qt_aptos_urnas_instaladas / qt_eleitores * 100, 9)) pe_aptos_urnas_instaladas_real,
           qt_aptos_urnas_nao_instaladas,
           CASE
               WHEN qt_aptos_urnas_nao_instaladas = 0 THEN
                   '0,00'
               WHEN qt_aptos_urnas_nao_instaladas = qt_eleitores THEN
                   '100,00'
               ELSE
                   DECODE(TRIM(TO_CHAR(qt_aptos_urnas_nao_instaladas / qt_eleitores * 100, '990D00')), '100,00', '99,99', '0,00', '0,01', TRIM(TO_CHAR(qt_aptos_urnas_nao_instaladas / qt_eleitores * 100, '990D00')))
           END   pe_aptos_urnas_nao_instaladas,
           DECODE(qt_aptos_urnas_nao_instaladas, 0, 0, trunc(qt_aptos_urnas_nao_instaladas / qt_eleitores * 100, 9)) pe_aptos_urnas_nao_instaladas_real,
           qt_aptos_apurados,
           CASE
               WHEN qt_aptos_apurados = 0 THEN
                   '0,00'
               WHEN qt_aptos_apurados = qt_aptos_urnas_instaladas THEN
                   '100,00'
               ELSE
                   DECODE(TRIM(TO_CHAR(qt_aptos_apurados / qt_aptos_urnas_instaladas * 100, '990D00')), '100,00', '99,99', '0,00', '0,01', TRIM(TO_CHAR(qt_aptos_apurados / qt_aptos_urnas_instaladas * 100, '990D00')))
           END   pe_aptos_apurados,
           DECODE(qt_aptos_apurados, 0, 0, trunc(qt_aptos_apurados / qt_aptos_urnas_instaladas * 100, 9)) pe_aptos_apurados_real,
           qt_aptos_nao_apurados,
           CASE
               WHEN qt_aptos_nao_apurados = 0 THEN
                   '0,00'
               WHEN qt_aptos_nao_apurados = qt_aptos_urnas_instaladas THEN
                   '100,00'
               ELSE
                   DECODE(TRIM(TO_CHAR(qt_aptos_nao_apurados / qt_aptos_urnas_instaladas * 100, '990D00')), '100,00', '99,99', '0,00', '0,01', TRIM(TO_CHAR(qt_aptos_nao_apurados / qt_aptos_urnas_instaladas * 100, '990D00')))
           END   pe_aptos_nao_apurados,
           DECODE(qt_aptos_nao_apurados, 0, 0, trunc(qt_aptos_nao_apurados / qt_aptos_urnas_instaladas * 100, 9)) pe_aptos_nao_apurados_real,
           qt_secoes,
           qt_secoes_totalizadas,
           CASE
               WHEN qt_secoes_totalizadas = 0 THEN
                   '0,00'
               WHEN qt_secoes_totalizadas = qt_secoes THEN
                   '100,00'
               ELSE
                   DECODE(TRIM(TO_CHAR(qt_secoes_totalizadas / qt_secoes * 100, '990D00')), '100,00', '99,99', '0,00', '0,01', TRIM(TO_CHAR(qt_secoes_totalizadas / qt_secoes * 100, '990D00')))
           END   pe_secoes_totalizadas,
           DECODE(qt_secoes_totalizadas, 0, 0, trunc(qt_secoes_totalizadas / qt_secoes * 100, 9)) pe_secoes_totalizadas_real,
           qt_secoes_nao_totalizadas,
           CASE
               WHEN qt_secoes_nao_totalizadas = 0 THEN
                   '0,00'
               WHEN qt_secoes_nao_totalizadas = qt_secoes THEN
                   '100,00'
               ELSE
                   DECODE(TRIM(TO_CHAR(qt_secoes_nao_totalizadas / qt_secoes * 100, '990D00')), '100,00', '99,99', '0,00', '0,01', TRIM(TO_CHAR(qt_secoes_nao_totalizadas / qt_secoes * 100, '990D00')))
           END   pe_secoes_nao_totalizadas,
           DECODE(qt_secoes_nao_totalizadas, 0, 0, trunc(qt_secoes_nao_totalizadas / qt_secoes * 100, 9)) pe_secoes_nao_totalizadas_real,
           qt_secoes_instaladas,
           CASE
               WHEN qt_secoes_instaladas = 0 THEN
                   '0,00'
               WHEN qt_secoes_instaladas = qt_secoes THEN
                   '100,00'
               ELSE
                   DECODE(TRIM(TO_CHAR(qt_secoes_instaladas / qt_secoes * 100, '990D00')), '100,00', '99,99', '0,00', '0,01', TRIM(TO_CHAR(qt_secoes_instaladas / qt_secoes * 100, '990D00')))
           END   pe_secoes_instaladas,
           DECODE(qt_secoes_instaladas, 0, 0, trunc(qt_secoes_instaladas / qt_secoes * 100, 9)) pe_secoes_instaladas_real,
           qt_secoes_nao_instaladas,
           CASE
               WHEN qt_secoes_nao_instaladas = 0 THEN
                   '0,00'
               WHEN qt_secoes_nao_instaladas = qt_secoes THEN
                   '100,00'
               ELSE
                   DECODE(TRIM(TO_CHAR(qt_secoes_nao_instaladas / qt_secoes * 100, '990D00')), '100,00', '99,99', '0,00', '0,01', TRIM(TO_CHAR(qt_secoes_nao_instaladas / qt_secoes * 100, '990D00')))
           END   pe_secoes_nao_instaladas,
           DECODE(qt_secoes_nao_instaladas, 0, 0, trunc(qt_secoes_nao_instaladas / qt_secoes * 100, 9)) pe_secoes_nao_instaladas_real,
           qt_secoes_apuradas,
           CASE
               WHEN qt_secoes_apuradas = 0 THEN
                   '0,00'
               WHEN qt_secoes_apuradas = qt_secoes_instaladas THEN
                   '100,00'
               ELSE
                   DECODE(TRIM(TO_CHAR(qt_secoes_apuradas / qt_secoes_instaladas * 100, '990D00')), '100,00', '99,99', '0,00', '0,01', TRIM(TO_CHAR(qt_secoes_apuradas / qt_secoes_instaladas * 100, '990D00')))
           END   pe_secoes_apuradas,
           DECODE(qt_secoes_apuradas, 0, 0, trunc(qt_secoes_apuradas / qt_secoes_instaladas * 100, 9)) pe_secoes_apuradas_real,
           qt_secoes_nao_apuradas,
           CASE
               WHEN qt_secoes_nao_apuradas = 0 THEN
                   '0,00'
               WHEN qt_secoes_nao_apuradas = qt_secoes_instaladas THEN
                   '100,00'
               ELSE
                   DECODE(TRIM(TO_CHAR(qt_secoes_nao_apuradas / qt_secoes_instaladas * 100, '990D00')), '100,00', '99,99', '0,00', '0,01', TRIM(TO_CHAR(qt_secoes_nao_apuradas / qt_secoes_instaladas * 100, '990D00')))
           END   pe_secoes_nao_apuradas,
           DECODE(qt_secoes_nao_apuradas, 0, 0, trunc(qt_secoes_nao_apuradas / qt_secoes_instaladas * 100, 9)) pe_secoes_nao_apuradas_real,
           qt_secoes_agregadas,
           dt_carga
      FROM ft_secoes_regiao;