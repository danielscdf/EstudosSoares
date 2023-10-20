/* Formatted on 26/11/2020 10:38:09 (QP5 v5.252.13127.32847) */
CREATE OR REPLACE VIEW vw_tabelas_basicas_partido_coligado
AS
       SELECT pc.cd_pleito,
                pc.cd_eleicao,
                mz.sg_ue_uf,
                mz.sg_ue_mun,
                mz.nr_zona,
                pc.sg_ue,
                pc.sq_drap,
                pc.nr_partido_federacao,
                NVL(fe.nm_federacao, p.nm_partido) nm_partido_federacao,
                NVL(fe.sg_federacao, p.sg_partido) sg_partido_federacao,
								le.cd_cargo,
                pc.st_dissidente,
                pc.st_apto
     FROM partido_federacao_coligacao pc
      JOIN partido p
         ON p.cd_pleito = pc.cd_pleito
         AND p.cd_eleicao = pc.cd_eleicao
         AND pc.nr_partido_federacao IN(p.nr_partido, p.nr_federacao)
      LEFT JOIN federacao fe
         ON fe.cd_pleito = pc.cd_pleito
         AND fe.cd_eleicao = pc.cd_eleicao
         AND fe.nr_federacao = p.nr_federacao
      INNER JOIN legenda le
         ON le.cd_eleicao = pc.cd_eleicao
         AND le.sg_ue = pc.sg_ue
         AND le.sq_drap = pc.sq_drap
    INNER JOIN mun_zona_eleicao mz
         ON mz.cd_pleito = pc.cd_pleito
         AND mz.cd_eleicao = pc.cd_eleicao
         AND pc.sg_ue IN (mz.sg_ue_mun, mz.sg_ue_uf, 'BR');