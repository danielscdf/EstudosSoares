CREATE OR REPLACE VIEW vw_tabelas_basicas_partido AS
SELECT DISTINCT pa.cd_pleito,
                pa.cd_eleicao,
                mz.sg_ue_uf,
                mz.sg_ue_mun,
                mz.nr_zona,
                pa.nr_partido,
                pa.nm_partido,
                pa.sg_partido
FROM partido pa
INNER JOIN (SELECT pi.cd_pleito,
                   pi.cd_eleicao,
                   pi.sg_ue,
                   pi.nr_partido_federacao
            FROM drap_isolado pi
            UNION ALL
            SELECT pc.cd_pleito,
                   pc.cd_eleicao,
                   pc.sg_ue,
                   pc.nr_partido_federacao
            FROM partido_federacao_coligacao pc) pt
      ON pt.cd_pleito = pa.cd_pleito
      AND pt.cd_eleicao = pa.cd_eleicao
      AND pt.nr_partido_federacao IN(pa.nr_partido,pa.nr_federacao)
INNER JOIN mun_zona_eleicao mz
      ON mz.cd_pleito = pt.cd_pleito
      AND mz.cd_eleicao = pt.cd_eleicao
      AND pt.sg_ue IN (mz.sg_ue_mun, mz.sg_ue_uf, 'BR');