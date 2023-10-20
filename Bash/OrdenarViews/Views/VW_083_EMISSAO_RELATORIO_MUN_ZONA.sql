CREATE OR REPLACE VIEW vw_083_emissao_relatorio_mun_zona
AS
    SELECT
    m.cd_pleito,
    m.cd_eleicao,
    e.nm_eleicao,
    m.sg_ue_uf,
    upuf.nm_ue nm_uf,
    m.nr_zona,
    mp.nr_junta,
    m.sg_ue_mun,
    up.nm_ue,
    tr.cd_tipo_relatorio,
    tr.nm_tipo_relatorio,
    TO_CHAR(MAX(h.dt_emissao_hor_loc),'DD/MM/YYYY HH24:MI:SS') dt_emissao_hor_loc,
    MAX(h.dt_emissao_hor_tse) dt_emissao_hor_tse,
    CASE--RN0293
            WHEN tr.cd_tipo_relatorio = 110 THEN nvl(m.st_zeresima,'N')
            WHEN tr.cd_tipo_relatorio = 248 THEN m.st_emissao_junta
            WHEN MAX(h.dt_emissao_hor_tse) IS NULL THEN 'N'
            WHEN tr.cd_tipo_relatorio NOT IN (
                247
            )
                 AND MAX(h.dt_emissao_hor_tse) IS NOT NULL THEN 'S'
            WHEN tr.cd_tipo_relatorio = 247 THEN uee.st_emissao_resultado_tot
        END
    st_relatorio_emitido
FROM
    mun_zona_eleicao m
    JOIN eleicao e ON m.cd_eleicao = e.cd_eleicao
    JOIN pleito p ON m.cd_pleito = p.cd_pleito
    JOIN mun_zona_processo mp ON mp.cd_processo_eleitoral = p.cd_processo_eleitoral
    JOIN tipo_relatorio tr ON 1 = 1
                              AND mp.sg_ue_uf = m.sg_ue_uf
                              AND mp.sg_ue_mun = m.sg_ue_mun
                              AND mp.nr_zona = m.nr_zona
    JOIN ue_eleicao uee ON ( uee.cd_processo_eleitoral = mp.cd_processo_eleitoral
                             AND uee.cd_pleito = m.cd_pleito
                             AND uee.cd_eleicao = m.cd_eleicao
                             AND uee.sg_ue_uf = m.sg_ue_uf
                             AND uee.sg_ue = m.sg_ue_mun )
    JOIN ue_processo up ON up.cd_processo_eleitoral = p.cd_processo_eleitoral
                           AND up.sg_ue = m.sg_ue_mun
    JOIN ue_processo upuf ON upuf.cd_processo_eleitoral = p.cd_processo_eleitoral
                             AND upuf.sg_ue = m.sg_ue_uf
    LEFT JOIN historico_geral_relatorio h ON m.cd_pleito = h.cd_pleito
                                             AND m.cd_eleicao = nvl(h.cd_eleicao,m.cd_eleicao)
                                             AND m.sg_ue_uf = h.sg_ue_uf
                                             AND m.sg_ue_mun = nvl(h.sg_ue,m.sg_ue_mun)
                                             AND (
        m.nr_zona = h.nr_zona
        OR h.nr_zona IS NULL
    )
                                             AND tr.cd_tipo_relatorio = h.cd_tipo_relatorio
WHERE
    tr.cd_tipo_relatorio NOT IN (
        247
    )
    OR   m.st_totaliza = 'S'
GROUP BY
    m.cd_pleito,
    m.cd_eleicao,
    e.nm_eleicao,
    m.sg_ue_uf,
    h.cd_pleito,
    h.cd_eleicao,
    h.sg_ue_uf,
    h.sg_ue,
    uee.st_emissao_resultado_tot,
    upuf.nm_ue,
    m.nr_zona,
    mp.nr_junta,
    m.sg_ue_mun,
    up.nm_ue,
    tr.cd_tipo_relatorio,
    h.cd_tipo_relatorio,
    tr.nm_tipo_relatorio,
    m.st_zeresima,
    m.st_emissao_junta;