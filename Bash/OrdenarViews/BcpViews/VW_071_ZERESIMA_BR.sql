CREATE OR REPLACE VIEW vw_071_zeresima_br
AS SELECT vw.cd_pleito,
       vw.cd_eleicao,
       'BR' sg_ue_uf,
       vw.cd_cargo_pergunta,
       vw.nr_votavel,
       vw.cd_tipo_votavel,
       'Brasil' nm_uf,
       vw.nm_cargo_pergunta,
       vw.nm_coligacao,
       vw.nm_candidato_resposta,
       vw.nm_vice_candidato,
       vw.nm_situacao_vice,
       vw.nm_decisao_judicial_vice,
       vw.nm_cand_urna,
       vw.nm_situacao_candidato,
       vw.cd_tipo_decisao_judicial,
       vw.nm_tipo_decisao_judicial,
       vw.qt_votos,
       SUM(CASE
               WHEN vw.cd_tipo_votavel IS NOT NULL THEN
                1
               ELSE
                0
           END) over(PARTITION BY vw.cd_pleito, vw.cd_eleicao) qt_total_chapas,
       SYSDATE dt_atualizacao,
       vw.nm_federacao
FROM (SELECT vt.cd_pleito,
       vt.cd_eleicao,
       vt.cd_cargo_pergunta,
       vt.nr_votavel,
       vt.cd_tipo_votavel,
       vt.nm_cargo_pergunta,
       vt.nm_coligacao,
       vt.nm_votavel nm_candidato_resposta,
       CASE WHEN vt.nm_votavel_vice2 IS NOT NULL THEN vt.nm_votavel_vice1||' / '||vt.nm_votavel_vice2
            ELSE vt.nm_votavel_vice1
       END nm_vice_candidato,
       CASE WHEN vt.nm_situacao_votavel_vice2_atual IS NOT NULL THEN vt.nm_situacao_votavel_vice1_atual||' / '||vt.nm_situacao_votavel_vice2_atual
            ELSE vt.nm_situacao_votavel_vice1_atual
       END nm_situacao_vice,
       CASE WHEN vt.nm_tipo_decisao_judicial_vice2 IS NOT NULL THEN vt.nm_tipo_decisao_judicial_vice1||' / '||vt.nm_tipo_decisao_judicial_vice2
            ELSE vt.nm_tipo_decisao_judicial_vice1
       END nm_decisao_judicial_vice,
       vt.nm_votavel_urna nm_cand_urna,
       vt.nm_situacao_votavel_atual nm_situacao_candidato,
       vt.cd_tipo_decisao_judicial,
       vt.nm_tipo_decisao_judicial,
       nvl(vv.qt_votos_computados_votavel, 0) qt_votos,
       vt.nm_federacao
FROM dm_votavel vt
LEFT JOIN ft_votos_votavel_br vv
      ON vv.cd_pleito = vt.cd_pleito
      AND vv.cd_eleicao = vt.cd_eleicao
      AND vv.sq_dm_votavel = vt.sq_dm_votavel
       )vw;