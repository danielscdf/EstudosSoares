CREATE OR REPLACE VIEW vw_tabelas_basicas_coligacao AS
    SELECT
        c.cd_pleito,
        c.cd_eleicao,
        mz.sg_ue_uf,
        mz.sg_ue_mun,
        mz.nr_zona,
        c.sg_ue,
        c.sq_drap,
        le.cd_cargo,
        c.nm_coligacao
    FROM
        coligacao c
        JOIN partido_federacao_coligacao d ON ( c.cd_pleito = d.cd_pleito
                                      AND c.cd_eleicao = d.cd_eleicao
                                      AND c.sg_ue = d.sg_ue
                                      AND c.sq_drap = d.sq_drap )
    INNER JOIN legenda le
          ON le.cd_eleicao = d.cd_eleicao
          AND le.sg_ue = d.sg_ue
          AND le.sq_drap = d.sq_drap
    INNER JOIN mun_zona_eleicao mz
         ON mz.cd_pleito = c.cd_pleito
         AND mz.cd_eleicao = c.cd_eleicao
         AND c.sg_ue IN (mz.sg_ue_mun, mz.sg_ue_uf, 'BR');