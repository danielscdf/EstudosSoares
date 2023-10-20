CREATE OR REPLACE VIEW vw_tabelas_basicas_drap AS
    SELECT 
        d.cd_pleito,
        d.cd_eleicao,
        mz.sg_ue_uf,
        mz.sg_ue_mun,
        mz.nr_zona,
        d.sg_ue,
        d.sq_drap,
        sdi.nm_situacao_drap situacao_importacao,
        sde.nm_situacao_drap situacao_eleicao,
        sda.nm_situacao_drap situacao_atual,
        d.tp_drap
    FROM drap d
    INNER JOIN mun_zona_eleicao mz
         ON mz.cd_pleito = d.cd_pleito
         AND mz.cd_eleicao = d.cd_eleicao
         AND d.sg_ue IN (mz.sg_ue_mun, mz.sg_ue_uf, 'BR')
    JOIN situacao_drap sdi
         ON d.cd_situacao_drap_importa = sdi.cd_situacao_drap
    JOIN situacao_drap sde
         ON d.cd_situacao_drap_eleicao = sde.cd_situacao_drap
    JOIN situacao_drap sda
         ON d.cd_situacao_drap = sda.cd_situacao_drap;
