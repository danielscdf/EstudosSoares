CREATE OR REPLACE VIEW vw_052_cons_resumo_secao_zona
AS
SELECT DISTINCT spp.cd_processo_eleitoral,
                    se.cd_pleito,
                    se.cd_eleicao,
                    e.nm_eleicao,
                    spp.sg_ue_uf,
                    spp.sg_ue_mun,
                    ue.nm_ue,
                    spp.nr_zona,
                    nvl(sa.qt_secoes_agregadas, 0) + COUNT(se.nr_secao)OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, spp.sg_ue_uf, spp.sg_ue_mun, spp.nr_zona) qt_secoes,
                    nvl(sa.qt_secoes_agregadas, 0)
                        qt_secoes_agregadas,
                    REPLACE(TO_CHAR(
                            SUM(DECODE(spp.tp_situacao_secao_bu, 'R', 1, 0))
                                OVER(
                                     PARTITION BY spp.cd_pleito,
                                                  se.cd_eleicao,
                                                  spp.sg_ue_uf,
                                                  spp.sg_ue_mun,
                                                  spp.nr_zona
                                    ),
                            '999G990'
                           ), ',', '.')||
                    CHR(10)||
                    '(' ||
                    LTRIM(
                          TO_CHAR(
                                  SUM(DECODE(spp.tp_situacao_secao_bu, 'R', 1, 0))
                                      OVER(
                                  PARTITION BY spp.cd_pleito,
                                  spp.sg_ue_uf,
                                  spp.sg_ue_mun,
                                  spp.nr_zona
                                          ) / COUNT(spp.nr_secao)
                                      OVER    (
                                  PARTITION BY spp.cd_pleito,
                                  spp.sg_ue_uf,
                                  spp.sg_ue_mun,
                                  spp.nr_zona
                                              ) * 100,
                                  '900D00'
                                 )||
                          '%)'
                         )
                        qt_secoes_recebidas,
                    REPLACE(TO_CHAR(
                            SUM(DECODE(spp.tp_situacao_secao_bu, 'N', 1, 0))
                                OVER(
                                     PARTITION BY spp.cd_pleito,
                                                  se.cd_eleicao,
                                                  spp.sg_ue_uf,
                                                  spp.sg_ue_mun,
                                                  spp.nr_zona
                                    ),
                            '999G990'
                           ), ',', '.')||
                    CHR(10)||
                    '(' ||
                    LTRIM(
                          TO_CHAR(
                                  SUM(DECODE(spp.tp_situacao_secao_bu, 'N', 1, 0))
                                      OVER(
                                  PARTITION BY spp.cd_pleito,
                                  se.cd_eleicao,
                                  spp.sg_ue_uf,
                                  spp.sg_ue_mun,
                                  spp.nr_zona
                                          ) / COUNT(spp.nr_secao)
                                      OVER    (
                                  PARTITION BY spp.cd_pleito,
                                  se.cd_eleicao,
                                  spp.sg_ue_uf,
                                  spp.sg_ue_mun,
                                  spp.nr_zona
                                              ) * 100,
                                  '900D00'
                                 )||
                          '%)'
                         )
                        qt_secoes_nao_recebidas,
                    REPLACE(TO_CHAR(
                            SUM(DECODE(se.tp_situacao_totalizacao, 'T', 1, 0))
                                OVER(
                                     PARTITION BY spp.cd_pleito,
                                                  se.cd_eleicao,
                                                  spp.sg_ue_uf,
                                                  spp.sg_ue_mun,
                                                  spp.nr_zona
                                    ),
                            '999G990'
                           ), ',', '.')||
                    CHR(10)||
                    '(' ||
                    LTRIM(
                          TO_CHAR(
                                  SUM(DECODE(se.tp_situacao_totalizacao, 'T', 1, 0))
                                      OVER(
                                  PARTITION BY spp.cd_pleito,
                                  se.cd_eleicao,
                                  spp.sg_ue_uf,
                                  spp.sg_ue_mun,
                                  spp.nr_zona
                                          ) / COUNT(spp.nr_secao)
                                      OVER    (
                                  PARTITION BY spp.cd_pleito,
                                  se.cd_eleicao,
                                  spp.sg_ue_uf,
                                  spp.sg_ue_mun,
                                  spp.nr_zona
                                              ) * 100,
                                  '900D00'
                                 )||
                          '%)'
                         )
                        qt_bu_totalizado,
                    REPLACE(TO_CHAR(
                            SUM(DECODE(se.tp_situacao_totalizacao, 'N', 1, 0))
                                OVER(
                                     PARTITION BY spp.cd_pleito,
                                                  se.cd_eleicao,
                                                  spp.sg_ue_uf,
                                                  spp.sg_ue_mun,
                                                  spp.nr_zona
                                    ),
                            '999G990'
                           ), ',', '.')||
                    CHR(10)||
                    '(' ||
                    LTRIM(
                          TO_CHAR(
                                  SUM(DECODE(se.tp_situacao_totalizacao, 'N', 1, 0))
                                      OVER(
                                  PARTITION BY spp.cd_pleito,
                                  se.cd_eleicao,
                                  spp.sg_ue_uf,
                                  spp.sg_ue_mun,
                                  spp.nr_zona
                                          ) / COUNT(spp.nr_secao)
                                      OVER    (
                                  PARTITION BY spp.cd_pleito,
                                  se.cd_eleicao,
                                  spp.sg_ue_uf,
                                  spp.sg_ue_mun,
                                  spp.nr_zona
                                              ) * 100,
                                  '900D00'
                                 )||
                          '%)'
                         )
                        qt_bu_nao_totalizado,
                    CASE SUM(DECODE(se.tp_situacao_totalizacao, 'T', 1, 0))
                             OVER(
                         PARTITION BY spp.cd_pleito,
                         se.cd_eleicao,
                         spp.sg_ue_uf,
                         spp.sg_ue_mun,
                         spp.nr_zona
                                 ) / COUNT(spp.nr_secao)
                             OVER    (
                         PARTITION BY spp.cd_pleito,
                         se.cd_eleicao,
                         spp.sg_ue_uf,
                         spp.sg_ue_mun,
                         spp.nr_zona
                                     ) * 100
                        WHEN 0 THEN 'N'
                        WHEN 100 THEN 'T'
                        ELSE 'P'
                    END
                        st_totalizacao,
                    psp.qt_pendencia_bu,
                    (SELECT COUNT(DISTINCT r.nr_secao_mesa)
                       FROM rejeicao r
                      WHERE spp.cd_pleito = r.cd_pleito
                        AND spp.sg_ue_uf = r.sg_ue_uf
                        AND spp.sg_ue_mun = r.sg_ue_mun
                        AND spp.nr_zona = r.nr_zona
                        AND NOT EXISTS
                                (SELECT 1
                                   FROM pendencia_secao_pleito psp2
                                  WHERE r.cd_pleito = psp2.cd_pleito
                                    AND r.sg_ue_uf = psp2.sg_ue_uf
                                    AND r.sg_ue_mun = psp2.sg_ue_mun
                                    AND r.nr_zona = psp2.nr_zona
                                    AND r.nr_secao_mesa = psp2.nr_secao
                                    AND psp2.st_pendencia = 'N')
                       AND NOT EXISTS (SELECT 1
                                      FROM secao_pleito sp2
                                        WHERE r.cd_pleito = sp2.cd_pleito
                                       AND r.sg_ue_uf = sp2.sg_ue_uf
                                       AND r.sg_ue_mun = sp2.sg_ue_mun
                                       AND r.nr_zona = sp2.nr_zona
                                       AND r.nr_secao_mesa = sp2.nr_secao
                                       AND sp2.tp_situacao_secao_bu = 'R'))
                        qt_bu_rejeitado,
                    psp.qt_bu_pendente
      FROM secao_pleito spp
           INNER JOIN ue_processo ue
               ON spp.cd_processo_eleitoral = ue.cd_processo_eleitoral
              AND spp.sg_ue_mun = ue.sg_ue
           INNER JOIN secao_eleicao se
               ON spp.cd_pleito = se.cd_pleito
              AND spp.sg_ue_uf = se.sg_ue_uf
              AND spp.sg_ue_mun = se.sg_ue_mun
              AND spp.nr_zona = se.nr_zona
              AND spp.nr_secao = se.nr_secao
           INNER JOIN eleicao e
                 ON se.cd_pleito = e.cd_pleito
                 AND se.cd_eleicao = e.cd_eleicao
      LEFT JOIN (SELECT COUNT(sae.nr_secao) qt_secoes_agregadas, sae.cd_eleicao, sae.sg_ue_uf, sae.sg_ue_mun, sae.nr_zona
               FROM secao_agregada_eleicao sae
               GROUP BY sae.cd_eleicao, sae.sg_ue_uf, sae.sg_ue_mun, sae.nr_zona) sa
            ON sa.cd_eleicao = se.cd_eleicao
            AND sa.sg_ue_uf = se.sg_ue_uf
            AND sa.sg_ue_mun = se.sg_ue_mun
            AND sa.nr_zona = se.nr_zona
      LEFT JOIN (SELECT p2.cd_pleito, p2.sg_ue_uf, p2.sg_ue_mun, p2.nr_zona, COUNT(DISTINCT tp2.cd_tipo_pendencia) qt_pendencia_bu, COUNT(DISTINCT p2.nr_secao) qt_bu_pendente
                 FROM pendencia_secao_pleito p2
                  INNER JOIN tipo_pendencia_secao_pleito tp2
                      ON p2.cd_pleito = tp2.cd_pleito
                     AND p2.sq_pendencia_secao_pleito = tp2.sq_pendencia_secao_pleito
                WHERE p2.st_pendencia = 'N'
                GROUP BY p2.cd_pleito, p2.sg_ue_uf, p2.sg_ue_mun, p2.nr_zona) psp
              ON spp.cd_pleito = psp.cd_pleito
              AND spp.sg_ue_uf = psp.sg_ue_uf
              AND spp.sg_ue_mun = psp.sg_ue_mun
              AND spp.nr_zona = psp.nr_zona;