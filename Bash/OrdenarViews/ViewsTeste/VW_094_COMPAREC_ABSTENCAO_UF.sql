 CREATE OR REPLACE VIEW VW_094_COMPAREC_ABSTENCAO_UF
 AS
 SELECT DISTINCT se.cd_pleito,
                 se.cd_eleicao,
                 se.sg_ue_uf,
                 d.cd_cargo_pergunta cd_cargo_pergunta,
                 d.nm_cargo_pergunta nm_cargo_pergunta,
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
            FROM vw_ft_secoes_uf se
            JOIN dm_votavel d
              ON se.CD_PLEITO = d.CD_PLEITO
             AND se.CD_ELEICAO = d.CD_ELEICAO
             AND d.SG_UE_UF IN (se.SG_UE_UF, 'BR')
             AND se.CD_TIPO_CARGO_PERGUNTA = d.CD_TIPO_CARGO_PERGUNTA;