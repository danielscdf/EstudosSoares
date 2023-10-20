CREATE OR REPLACE VIEW vw_094_comparec_abstencao_br
AS
    SELECT se.cd_pleito,
           se.cd_eleicao,
           NVL(cg.cd_cargo,pe.cd_pergunta) cd_cargo_pergunta,
           NVL(cg.nm_cargo_neutro,pe.nm_pergunta) nm_cargo_pergunta,
           se.qt_eleitores qtd_aptos,
           se.qt_comparecimento qtd_comparecimento,
           se.pe_comparecimento,
           se.qt_abstencao qtd_abstencao,
           se.pe_abstencao,
           se.qt_aptos_urnas_nao_instaladas qtd_aptos_urnas_nao_instaladas,
           se.pe_aptos_urnas_nao_instaladas,
           se.qt_aptos_apurados qtd_aptos_apurados,
           se.pe_aptos_apurados,
           se.qt_aptos_nao_apurados qtd_aptos_nao_apurados,
           se.pe_aptos_nao_apurados
      FROM vw_ft_secoes_br se
      LEFT JOIN cargo cg
           ON cg.cd_eleicao = se.cd_eleicao 
           AND cg.cd_tipo_cargo_pergunta = se.cd_tipo_cargo_pergunta
           AND cg.st_votavel = 'S'
      LEFT JOIN pergunta pe
           ON pe.cd_pleito = se.cd_pleito
           AND pe.cd_eleicao = se.cd_eleicao;