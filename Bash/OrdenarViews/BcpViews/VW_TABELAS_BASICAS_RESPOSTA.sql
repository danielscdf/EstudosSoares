CREATE OR REPLACE VIEW vw_tabelas_basicas_resposta AS
SELECT vt.cd_pleito,
        vt.cd_eleicao,
        mz.sg_ue_uf,
        vt.sg_ue,
        mz.sg_ue_mun,
        mz.nr_zona,
        vt.cd_cargo_pergunta cd_pergunta,
        pe.nm_pergunta,
        re.nr_resposta,
        re.nm_resposta
    FROM votavel vt
    INNER JOIN mun_zona_eleicao mz
         ON mz.cd_pleito = vt.cd_pleito
         AND mz.cd_eleicao = vt.cd_eleicao
         AND vt.sg_ue_uf IN (mz.sg_ue_uf, 'BR')
         AND vt.sg_ue IN (mz.sg_ue_mun, mz.sg_ue_uf, 'BR')
    INNER JOIN pergunta pe
          ON pe.cd_pleito = vt.cd_pleito
          AND pe.cd_eleicao = vt.cd_eleicao
          AND pe.cd_pergunta = vt.cd_cargo_pergunta
    INNER JOIN resposta re
          ON re.cd_pleito = vt.cd_pleito
          AND re.cd_eleicao = vt.cd_eleicao
          AND re.sg_ue = vt.sg_ue
          AND re.cd_pergunta = vt.cd_cargo_pergunta
          AND re.nr_resposta = vt.nr_votavel;
