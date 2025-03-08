CREATE OR REPLACE VIEW vw_094_comparec_abstencao_secao
AS
    SELECT DISTINCT se.cd_pleito,
                    se.cd_eleicao,
                    se.sg_ue_mun,
                    se.nr_zona,
                    se.nr_secao,
                    se.sg_ue_uf,
                    UP.nm_ue,
                    NVL(ca.cd_cargo, pe.cd_pergunta) cd_cargo_pergunta,
                    NVL(ca.nm_cargo_neutro, pe.nm_pergunta) nm_cargo_pergunta,
                    se.qt_aptos qtd_aptos,
                    stp.qt_comparecimento qtd_comparecimento,
                    TO_CHAR(CASE WHEN DECODE(sp.cd_tipo_urna, 5, 0, se.qt_aptos) = 0 THEN 0 WHEN stp.qt_comparecimento = 0 THEN 0 ELSE stp.qt_comparecimento / se.qt_aptos * 100 END, '990D00') pe_comparecimento,
                    DECODE(sp.cd_tipo_urna, 5, 0, se.qt_aptos) - stp.qt_comparecimento qtd_abstencao,
                    TO_CHAR(CASE WHEN DECODE(sp.cd_tipo_urna, 5, 0, se.qt_aptos) = 0 THEN 0 WHEN stp.qt_comparecimento = 0 THEN 0 ELSE (se.qt_aptos - stp.qt_comparecimento) / se.qt_aptos * 100 END, '990D00') pe_abstencao,
                    DECODE(sp.cd_tipo_urna, 5, se.qt_aptos, 0) qtd_aptos_urnas_nao_instaladas,
                    TO_CHAR(CASE WHEN DECODE(sp.cd_tipo_urna, 5, se.qt_aptos, 0) = 0 THEN 0 ELSE 100 END, '990D00') pe_aptos_urnas_nao_instaladas,
                    DECODE(sp.cd_tipo_urna,  5, 0,  2, 0,  se.qt_aptos) qtd_aptos_apurados,
                    TO_CHAR(CASE WHEN DECODE(sp.cd_tipo_urna,  5, 0,  2, 0,  se.qt_aptos) = 0 THEN 0 ELSE 100 END, '990D00') pe_aptos_apurados,
                    DECODE(sp.cd_tipo_urna, 2, se.qt_aptos, 0) qtd_aptos_nao_apurados,
                    TO_CHAR(CASE WHEN DECODE(sp.cd_tipo_urna, 2, se.qt_aptos, 0) = 0 THEN 0 ELSE 100 END, '990D00') pe_aptos_nao_apurados
      FROM secao_pleito sp
           JOIN secao_eleicao se
               ON sp.cd_pleito = se.cd_pleito
              AND sp.sg_ue_uf = se.sg_ue_uf
              AND sp.sg_ue_mun = se.sg_ue_mun
              AND sp.nr_zona = se.nr_zona
              AND sp.nr_secao = se.nr_secao
           JOIN secao_tp_cargo_perg stp
               ON se.cd_pleito = stp.cd_pleito
              AND se.cd_eleicao = stp.cd_eleicao
              AND se.sg_ue_uf = stp.sg_ue_uf
              AND se.sg_ue_mun = stp.sg_ue_mun
              AND se.nr_zona = stp.nr_zona
              AND se.nr_secao = stp.nr_secao
           LEFT JOIN cargo ca
               ON stp.cd_eleicao = ca.cd_eleicao
              AND stp.cd_tipo_cargo_pergunta = ca.cd_tipo_cargo_pergunta
              AND ca.st_votavel = 'S'
           JOIN pleito pl ON se.cd_pleito = pl.cd_pleito
           JOIN ue_processo UP
               ON UP.cd_processo_eleitoral = pl.cd_processo_eleitoral
              AND UP.sg_ue = se.sg_ue_mun
           LEFT JOIN pergunta pe
               ON pe.cd_pleito = se.cd_pleito
              AND pe.cd_eleicao = se.cd_eleicao
		 JOIN (select distinct CD_CARGO_PERGUNTA, cd_eleicao, cd_pleito, sg_ue_uf, cd_tipo_cargo_pergunta from dm_votavel)  c
           ON C.CD_PLEITO = se.cd_pleito and C.CD_ELEICAO = ca.cd_eleicao and C.SG_UE_UF in (se.sg_ue_uf, 'BR') and C.CD_TIPO_CARGO_PERGUNTA = ca.cd_tipo_cargo_pergunta and c.cd_cargo_pergunta = ca.cd_cargo;