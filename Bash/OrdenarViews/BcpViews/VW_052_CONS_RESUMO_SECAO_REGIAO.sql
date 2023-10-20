CREATE OR REPLACE VIEW vw_052_cons_resumo_secao_regiao
AS
    WITH sa AS (SELECT COUNT(sae.nr_secao) qt_secoes_agregadas, sae.cd_eleicao, up.cd_regiao
               FROM secao_agregada_eleicao sae 
                             inner join ue_processo up on (up.cd_processo_eleitoral = sae.cd_processo_eleitoral and up.sg_ue = sae.sg_ue_uf) 
                             inner join regiao r on (r.cd_regiao = up.cd_regiao) 
               GROUP BY sae.cd_eleicao, up.cd_regiao)
    SELECT DISTINCT spp.cd_processo_eleitoral,
                    se.cd_pleito,
                    se.cd_eleicao,
                    e.nm_eleicao,
                    up.cd_regiao,
                    r.nm_regiao,
                    NVL(sa.qt_secoes_agregadas, 0) + COUNT(se.nr_secao)OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao) qt_secoes,
                    NVL(sa.qt_secoes_agregadas, 0) qt_secoes_agregadas,
                    REPLACE(TO_CHAR(SUM(DECODE(spp.tp_situacao_secao_bu, 'R', 1, 0)) OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao), '999G990'), ',', '.')||
                    CHR(10)||
                    '(' ||
                    LTRIM(
                          TO_CHAR(SUM(DECODE(spp.tp_situacao_secao_bu, 'R', 1, 0)) OVER (PARTITION BY spp.cd_pleito, up.cd_regiao) / COUNT(spp.nr_secao) OVER (PARTITION BY spp.cd_pleito,  up.cd_regiao) * 100, '900D00')||
                          '%)'
                         )
                        qt_secoes_recebidas,
                    REPLACE(TO_CHAR(SUM(DECODE(spp.tp_situacao_secao_bu, 'N', 1, 0)) OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao), '999G990'), ',', '.')||
                    CHR(10)||
                    '(' ||
                    LTRIM(
                          TO_CHAR(SUM(DECODE(spp.tp_situacao_secao_bu, 'N', 1, 0)) OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao) / COUNT(spp.nr_secao) OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao) * 100, '900D00')||
                          '%)'
                         )
                        qt_secoes_nao_recebidas,
                    REPLACE(TO_CHAR(SUM(DECODE(se.tp_situacao_totalizacao, 'T', 1, 0)) OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao), '999G990'), ',', '.')||
                    CHR(10)||
                    '(' ||
                    LTRIM(
                          TO_CHAR(SUM(DECODE(se.tp_situacao_totalizacao, 'T', 1, 0)) OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao) / COUNT(spp.nr_secao) OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao) * 100, '900D00')||
                          '%)'
                         )
                        qt_bu_totalizado,
                    REPLACE(TO_CHAR(SUM(DECODE(se.tp_situacao_totalizacao, 'N', 1, 0)) OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao), '999G990'), ',', '.')||
                    CHR(10)||
                    '(' ||
                    LTRIM(
                          TO_CHAR(SUM(DECODE(se.tp_situacao_totalizacao, 'N', 1, 0)) OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao) / COUNT(spp.nr_secao) OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao) * 100, '900D00')||
                          '%)'
                         )
                        qt_bu_nao_totalizado,
                    CASE SUM(DECODE(se.tp_situacao_totalizacao, 'T', 1, 0)) OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao) / COUNT(spp.nr_secao) OVER (PARTITION BY spp.cd_pleito, se.cd_eleicao, up.cd_regiao) * 100 WHEN 0 THEN 'N' WHEN 100 THEN 'T' ELSE 'P' END st_totalizacao,
                    (SELECT COUNT(DISTINCT tp2.cd_tipo_pendencia)
                       FROM pendencia_secao_pleito p2
                            INNER JOIN tipo_pendencia_secao_pleito tp2
                                ON p2.cd_pleito = tp2.cd_pleito
                               AND p2.sq_pendencia_secao_pleito = tp2.sq_pendencia_secao_pleito
                            INNER JOIN ue_processo up2 on (up2.cd_processo_eleitoral = p2.cd_processo_eleitoral and up2.sg_ue = p2.sg_ue_uf)   
                      WHERE spp.cd_pleito = p2.cd_pleito
                        AND up.cd_regiao = up2.cd_regiao
                        AND p2.st_pendencia = 'N')
                        qt_pendencia_bu,
                    (SELECT COUNT(DISTINCT r.nr_secao_mesa)
                       FROM rejeicao r
                            INNER JOIN secao_pleito sp2
                                ON r.cd_pleito = sp2.cd_pleito
                               AND r.sg_ue_uf = sp2.sg_ue_uf
                               AND r.sg_ue_mun = sp2.sg_ue_mun
                               AND r.nr_zona = sp2.nr_zona
                               AND r.nr_secao_mesa = sp2.nr_secao
                             INNER JOIN ue_processo up3 on (up3.cd_processo_eleitoral = sp2.cd_processo_eleitoral and up3.sg_ue = sp2.sg_ue_uf)  
                      WHERE spp.cd_pleito = r.cd_pleito
                        AND up.cd_regiao = up3.cd_regiao
                        AND sp2.tp_situacao_secao_bu = 'N'
                        AND NOT EXISTS
                                (SELECT 1
                                   FROM pendencia_secao_pleito psp2
                                   INNER JOIN ue_processo up4 on (up4.cd_processo_eleitoral = psp2.cd_processo_eleitoral and up4.sg_ue = psp2.sg_ue_uf)
                                  WHERE r.cd_pleito = psp2.cd_pleito
                                    AND r.sg_ue_uf = psp2.sg_ue_uf
                                    AND up4.cd_regiao = up.cd_regiao
                                    AND r.sg_ue_mun = psp2.sg_ue_mun
                                    AND r.nr_zona = psp2.nr_zona
                                    AND r.nr_secao_mesa = psp2.nr_secao
                                    AND psp2.st_pendencia = 'N'))
                        qt_bu_rejeitado,
                    (SELECT COUNT(*)
                       FROM pendencia_secao_pleito p2
                       INNER JOIN ue_processo up5 on (up5.cd_processo_eleitoral = p2.cd_processo_eleitoral and up5.sg_ue = p2.sg_ue_uf)
                      WHERE spp.cd_pleito = p2.cd_pleito
                        AND up5.cd_regiao = up.cd_regiao
                        AND p2.st_pendencia = 'N')
                        qt_bu_pendente
      FROM secao_pleito spp
           INNER JOIN secao_eleicao se
               ON spp.cd_pleito = se.cd_pleito
              AND spp.sg_ue_uf = se.sg_ue_uf
              AND spp.sg_ue_mun = se.sg_ue_mun
              AND spp.nr_zona = se.nr_zona
              AND spp.nr_secao = se.nr_secao
            INNER JOIN eleicao e ON se.cd_eleicao = e.cd_eleicao
            INNER JOIN ue_processo up on (up.cd_processo_eleitoral = spp.cd_processo_eleitoral and up.sg_ue = spp.sg_ue_uf)                
      LEFT JOIN sa
            ON sa.cd_eleicao = se.cd_eleicao
            AND sa.cd_regiao = up.cd_regiao
            INNER JOIN regiao r on (up.cd_regiao = r.cd_regiao);