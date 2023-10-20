CREATE OR REPLACE VIEW vw_combo_partido_coligacao
AS
      SELECT DISTINCT ue.cd_pleito,
                      le.cd_eleicao,
                      co.nm_coligacao,
                      le.cd_cargo,
                      le.sg_ue,
                      partidos.nr_partido_federacao,
                      NVL(co.nm_coligacao, nvl(partidos.nm_federacao, partidos.nr_partido_federacao ||' - ' || partidos.sg_partido)) partido_coligacao,
                      NVL(co.nm_coligacao, nvl(partidos.nm_federacao,partidos.nr_partido_federacao ||' - '||partidos.nm_partido)) partido_coligacao_completo,
                      ue.sg_ue_uf,
                      le.sq_drap,
                      partidos.nm_federacao
        FROM legenda le
             JOIN ue_eleicao ue
                 ON ue.cd_eleicao = le.cd_eleicao
                AND ue.sg_ue = le.sg_ue
             LEFT JOIN coligacao co
                 ON le.cd_eleicao = co.cd_eleicao
                AND le.sg_ue = co.sg_ue
                AND le.sq_drap = co.sq_drap
             LEFT JOIN (SELECT pi.cd_pleito,
                               pi.cd_eleicao,
                               pi.sg_ue,
                               pi.sq_drap,
                               pi.nr_partido_federacao,
                               fe.nm_federacao,
                               pa.nm_partido,
                               pa.sg_partido
                          FROM drap_isolado pi
                               JOIN partido pa
                                   ON pi.cd_pleito = pa.cd_pleito
                                  AND pi.cd_eleicao = pa.cd_eleicao
                                  AND (pi.nr_partido_federacao = pa.nr_partido
                                      OR pi.nr_partido_federacao = pa.nr_federacao)
                               LEFT JOIN federacao fe
                                    ON fe.cd_pleito = pa.cd_pleito
                                    AND fe.cd_eleicao = pa.cd_eleicao
                                    AND fe.nr_federacao = pa.nr_federacao) partidos
                 ON partidos.cd_eleicao = le.cd_eleicao
                AND partidos.sg_ue = le.sg_ue
                AND partidos.sq_drap = le.sq_drap
		    ORDER BY LTRIM(co.nm_coligacao) ASC NULLS FIRST, nm_federacao NULLS FIRST, nr_partido_federacao;