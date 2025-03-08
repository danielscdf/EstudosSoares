CREATE OR REPLACE VIEW vw_tabelas_basicas_secao AS
SELECT
    spr.cd_processo_eleitoral,
    p.cd_pleito,
		spr.sg_ue_uf,
    spr.sg_ue_mun,
    spr.nr_zona,
    spr.nr_secao,
    spr.nr_secao_principal,
    spr.nr_local,
    lv.nm_tipo_local_votacao,
    CASE
            WHEN spr.nr_secao_principal IS NULL THEN nvl( (
                SELECT DISTINCT
                    qt_aptos
                FROM
                    secao_eleicao se2
                    INNER JOIN eleicao el2 ON se2.cd_eleicao = el2.cd_eleicao
                WHERE
                    el2.cd_tipo_abrangencia = 0
                    AND   se2.cd_pleito = sp.cd_pleito
                    AND   se2.sg_ue_mun = sp.sg_ue_mun
                    AND   se2.nr_zona = sp.nr_zona
                    AND   se2.nr_secao = sp.nr_secao
            ),0)
            ELSE nvl( (
                SELECT DISTINCT
                    qt_aptos
                FROM
                    secao_agregada_eleicao sa
                    INNER JOIN eleicao el2 ON sa.cd_eleicao = el2.cd_eleicao
                WHERE
                    el2.cd_tipo_abrangencia = 0
                    AND   sa.cd_pleito = p.cd_pleito
                    AND   sa.sg_ue_mun = spr.sg_ue_mun
                    AND   sa.nr_zona = spr.nr_zona
                    AND   sa.nr_secao = spr.nr_secao
            ),0)
        END
    AS qtd_aptos_municipal,
    CASE
            WHEN spr.nr_secao_principal IS NULL THEN nvl( (
                SELECT DISTINCT
                    qt_aptos
                FROM
                    secao_eleicao se3
                    INNER JOIN eleicao el3 ON se3.cd_eleicao = el3.cd_eleicao
                WHERE
                    el3.cd_tipo_abrangencia = 1
                    AND   se3.cd_pleito = sp.cd_pleito
                    AND   se3.sg_ue_mun = sp.sg_ue_mun
                    AND   se3.nr_zona = sp.nr_zona
                    AND   se3.nr_secao = sp.nr_secao
            ),0)
            ELSE nvl( (
                SELECT DISTINCT
                    qt_aptos
                FROM
                    secao_agregada_eleicao sa
                    INNER JOIN eleicao el2 ON sa.cd_eleicao = el2.cd_eleicao
                WHERE
                    el2.cd_tipo_abrangencia = 1
                    AND   sa.cd_pleito = p.cd_pleito
                    AND   sa.sg_ue_mun = spr.sg_ue_mun
                    AND   sa.nr_zona = spr.nr_zona
                    AND   sa.nr_secao = spr.nr_secao
            ),0)
        END
    AS qtd_aptos_estadual,
    CASE
            WHEN spr.nr_secao_principal IS NULL THEN nvl( (
                SELECT DISTINCT
                    qt_aptos
                FROM
                    secao_eleicao se4
                    INNER JOIN eleicao el4 ON se4.cd_eleicao = el4.cd_eleicao
                WHERE
                    el4.cd_tipo_abrangencia = 2
                    AND   se4.cd_pleito = sp.cd_pleito
                    AND   se4.sg_ue_mun = sp.sg_ue_mun
                    AND   se4.nr_zona = sp.nr_zona
                    AND   se4.nr_secao = sp.nr_secao
            ),0)
            ELSE nvl( (
                SELECT DISTINCT
                    qt_aptos
                FROM
                    secao_agregada_eleicao sa
                    INNER JOIN eleicao el2 ON sa.cd_eleicao = el2.cd_eleicao
                WHERE
                    el2.cd_tipo_abrangencia = 2
                    AND   sa.cd_pleito = p.cd_pleito
                    AND   sa.sg_ue_mun = spr.sg_ue_mun
                    AND   sa.nr_zona = spr.nr_zona
                    AND   sa.nr_secao = spr.nr_secao
            ),0)
        END
    AS qtd_aptos_federal
FROM
    secao_processo spr
    INNER JOIN pleito p ON spr.cd_processo_eleitoral = p.cd_processo_eleitoral
    LEFT OUTER JOIN secao_pleito sp ON ( spr.cd_processo_eleitoral = sp.cd_processo_eleitoral
                                         AND p.cd_pleito = sp.cd_pleito
                                         AND spr.sg_ue_uf = sp.sg_ue_uf
                                         AND spr.sg_ue_mun = sp.sg_ue_mun
                                         AND spr.nr_zona = sp.nr_zona
                                         AND spr.nr_secao = sp.nr_secao )
    JOIN tipo_local_votacao lv ON ( lv.cd_tipo_local_votacao = spr.cd_tipo_local_votacao );
