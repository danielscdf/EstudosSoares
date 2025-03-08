CREATE OR REPLACE VIEW vw_094_comparec_abstencao_mun
AS
    SELECT dm.cd_pleito,
           dm.cd_eleicao,
           dm.sg_ue_mun,
           dm.sg_ue_uf,
           NVL(cg.cd_cargo,pe.cd_pergunta) cd_cargo_pergunta,
           dm.nm_municipio nm_ue,
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
      FROM vw_ft_secoes_municipio se
      INNER JOIN dm_municipio dm
            ON se.cd_pleito = dm.cd_pleito
            AND se.cd_eleicao = dm.cd_eleicao
            AND se.sg_ue_uf = dm.sg_ue_uf
            AND se.sq_dm_municipio = dm.sq_dm_municipio
      LEFT JOIN cargo cg
           ON cg.cd_eleicao = se.cd_eleicao 
           AND cg.cd_tipo_cargo_pergunta = se.cd_tipo_cargo_pergunta
           AND cg.st_votavel = 'S'
      LEFT JOIN pergunta pe
           ON pe.cd_pleito = se.cd_pleito
           AND pe.cd_eleicao = se.cd_eleicao
	  JOIN (select distinct CD_CARGO_PERGUNTA, cd_eleicao, cd_pleito, sg_ue_uf, cd_tipo_cargo_pergunta from dm_votavel)  c
           ON C.CD_PLEITO = se.cd_pleito and C.CD_ELEICAO = cg.cd_eleicao and C.SG_UE_UF in (se.sg_ue_uf, 'BR') and C.CD_TIPO_CARGO_PERGUNTA = cg.cd_tipo_cargo_pergunta and c.cd_cargo_pergunta = cg.cd_cargo;