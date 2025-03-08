CREATE OR REPLACE VIEW vw_068_resumo_votacao_partidos
AS
   SELECT v.sq_drap sq_drap,
          v.nr_partido || ' - ' || v.sg_partido partido,
          v.votos_dados_partido,
          v.votos_validos_legenda_original,
          v.votos_validos_legenda,
          v.votos_validos_nominal,
          v.votos_anulados_anuladossj_legenda,
          v.votos_anulados_anuladossj_nominal,
          v.soma_votos_partido_candidato,
          v.cd_tipo_votavel_destinacao,
          v.destinacao_votos,
          v.tipo_destinacao,
          v.cd_tipo_votavel,
          v.nr_partido,
          v.sg_ue_uf,
          v.cd_pleito,
          v.cd_eleicao,
          v.sg_ue,
          v.cd_cargo_pergunta cd_cargo,
          c.nm_cargo_masculino,
          c.nm_cargo_neutro,
          DECODE (v.cd_tipo_votavel_destinacao,
                  4, v.soma_votos_partido_candidato,
                  0)
             validos_qe_qp,
          v.nm_federacao,
          v.sg_federacao,
          CASE
             WHEN v.tp_drap = 'C' THEN 'C'
             WHEN v.nr_federacao IS NOT NULL THEN 'F'
             ELSE 'P'
          END
             tp_agremiacao
     FROM (SELECT DISTINCT
                  SUM (
                     CASE
                        WHEN vt.cd_tipo_votavel = 4
                        THEN
                           vmz.qt_votos_computados
                        ELSE
                           0
                     END)
                  OVER (PARTITION BY vmz.sg_ue_uf,
                                     vmz.cd_pleito,
                                     vmz.cd_eleicao,
                                     vmz.sg_ue,
                                     vmz.cd_cargo_pergunta,
                                     vt.nr_partido)
                     votos_dados_partido,
                  SUM (
                     CASE
                        WHEN     vt.cd_tipo_votavel = 4
                             AND vt.cd_tipo_votavel_destinacao = 4
                        THEN
                           vmz.qt_votos_computados
                        ELSE
                           0
                     END)
                  OVER (PARTITION BY vmz.sg_ue_uf,
                                     vmz.cd_pleito,
                                     vmz.cd_eleicao,
                                     vmz.sg_ue,
                                     vmz.cd_cargo_pergunta,
                                     vt.nr_partido)
                     votos_validos_legenda_original,
                  SUM (
                     CASE
                        WHEN     vt.cd_tipo_votavel = 1
                             AND vt.cd_tipo_votavel_destinacao = 4
                        THEN
                           vmz.qt_votos_computados
                        ELSE
                           0
                     END)
                  OVER (PARTITION BY vmz.sg_ue_uf,
                                     vmz.cd_pleito,
                                     vmz.cd_eleicao,
                                     vmz.sg_ue,
                                     vmz.cd_cargo_pergunta,
                                     vt.nr_partido)
                     votos_validos_legenda,
                  SUM (
                     CASE
                        WHEN     vt.cd_tipo_votavel = 1
                             AND vt.cd_tipo_votavel_destinacao = 1
                        THEN
                           vmz.qt_votos_computados
                        ELSE
                           0
                     END)
                  OVER (PARTITION BY vmz.sg_ue_uf,
                                     vmz.cd_pleito,
                                     vmz.cd_eleicao,
                                     vmz.sg_ue,
                                     vmz.cd_cargo_pergunta,
                                     vt.nr_partido)
                     votos_validos_nominal,
                  SUM (
                     CASE
                        WHEN     vt.cd_tipo_votavel = 1
                             AND vt.cd_tipo_votavel_destinacao in (6,7)
                        THEN
                           vmz.qt_votos_computados
                        ELSE
                           0
                     END)
                  OVER (PARTITION BY vmz.sg_ue_uf,
                                     vmz.cd_pleito,
                                     vmz.cd_eleicao,
                                     vmz.sg_ue,
                                     vmz.cd_cargo_pergunta,
                                     vt.nr_partido)
                     votos_anulados_anuladossj_nominal,
                  SUM (
                     CASE
                        WHEN     vt.cd_tipo_votavel = 4
                             AND vt.cd_tipo_votavel_destinacao in (6,7)
                        THEN
                           vmz.qt_votos_computados
                        ELSE
                           0
                     END)
                  OVER (PARTITION BY vmz.sg_ue_uf,
                                     vmz.cd_pleito,
                                     vmz.cd_eleicao,
                                     vmz.sg_ue,
                                     vmz.cd_cargo_pergunta,
                                     vt.nr_partido)
                     votos_anulados_anuladossj_legenda,
                  SUM (
                     CASE
                        WHEN vt.cd_tipo_votavel = 4
                        THEN
                           NVL (vmz.qt_votos_computados, 0)
                        WHEN     vt.cd_tipo_votavel = 1
                             AND vt.cd_tipo_votavel_destinacao = 1
                        THEN
                           NVL (vmz.qt_votos_computados, 0)
                        WHEN     vt.cd_tipo_votavel = 1
                             AND vt.cd_tipo_votavel_destinacao = 4
                        THEN
                           NVL (vmz.qt_votos_computados, 0)
                        ELSE
                           0
                     END)
                  OVER (PARTITION BY vmz.sg_ue_uf,
                                     vmz.cd_pleito,
                                     vmz.cd_eleicao,
                                     vmz.sg_ue,
                                     vmz.cd_cargo_pergunta,
                                     vt.nr_partido)
                     soma_votos_partido_candidato,
                  vt.cd_tipo_votavel_destinacao,
                  tvd.nm_tipo_votavel destinacao_votos,
                  tvd.nm_tipo_destinacao_votos tipo_destinacao,
                  vt.cd_tipo_votavel,
                  vt.nr_partido,
                  vmz.sg_ue_uf,
                  vmz.cd_pleito,
                  vmz.cd_eleicao,
                  vmz.sg_ue,
                  vmz.cd_cargo_pergunta,
                  vmz.nr_votavel,
                  vt.sq_drap,
                  vt.sg_partido,
                  vt.nm_federacao,
                  vt.sg_federacao,
                  vt.nr_federacao,
                  vt.tp_drap
             FROM voto_mun_zona vmz
                  JOIN dm_votavel vt
                     ON     vmz.cd_pleito = vt.cd_pleito
                        AND vmz.cd_eleicao = vt.cd_eleicao
                        AND (vt.sg_ue_uf = 'BR' OR vmz.sg_ue_uf = vt.sg_ue_uf)
                        AND vmz.sg_ue = vt.sg_ue
                        AND vmz.cd_cargo_pergunta = vt.cd_cargo_pergunta
                        AND vmz.nr_votavel = vt.nr_votavel
                  JOIN tipo_votavel tvd
                     ON tvd.cd_tipo_votavel = vt.cd_tipo_votavel_destinacao)
          v
          JOIN cargo c
             ON     c.cd_eleicao = v.cd_eleicao + 0
                AND c.cd_cargo = v.cd_cargo_pergunta + 0
    WHERE /*(pi.st_dissidente = 'N' OR d.cd_situacao_drap IN (3,5,8) OR d.cd_tipo_decisao_judicial = 2)
      AND */
          v.cd_tipo_votavel = 4;