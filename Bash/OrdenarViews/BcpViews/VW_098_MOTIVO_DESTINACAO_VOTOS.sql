CREATE OR REPLACE VIEW vw_098_motivo_destinacao_votos
AS
   SELECT v.cd_pleito,
          v.cd_eleicao,
          v.sg_ue_uf,
          v.sg_ue,
          ue.nm_ue,
          v.cd_tipo_votavel,
          v.cd_cargo_pergunta,
          cg.nm_cargo_neutro,
          v.nr_votavel,
          c.nr_cand,
          c.nm_cand_urna,
          pa.nr_partido,
          pa.sg_partido,
          c.cd_situacao_candidato_eleicao,
          se.nm_situacao_candidato nm_situacao_candidato_eleicao,
          c.cd_situacao_candidato_atual,
          sa.nm_situacao_candidato nm_situacao_candidato_atual,
          tdj.cd_tipo_decisao_judicial cd_tipo_decisao_judicial_cand,
          tdj.nm_tipo_decisao_judicial nm_tipo_decisao_judicial_cand,
          vl.nm_coligacao,
          vl.tp_drap,
					vl.sq_drap,
          vl.cd_situacao_drap_eleicao,
          vl.nm_situacao_drap_eleicao,
          vl.cd_situacao_drap_atual,
          vl.nm_situacao_drap_atual,
          vl.cd_tipo_decisao_judicial_drap,
          vl.nm_tipo_decisao_judicial_drap,
          vl.st_apto,
          v.cd_tipo_votavel_destinacao,
          tv.nm_tipo_destinacao_votos,
          v.cd_motivo_destinacao_voto,
          md.nm_motivo_destinacao_voto
     FROM votavel v
          JOIN cargo cg
             ON     v.cd_cargo_pergunta = cg.cd_cargo
                AND v.cd_eleicao = cg.cd_eleicao
          LEFT JOIN candidato c
             ON     c.cd_pleito = v.cd_pleito
                AND c.cd_eleicao = v.cd_eleicao
                AND c.sg_ue_uf = v.sg_ue_uf
                AND c.sg_ue = v.sg_ue
                AND c.cd_cargo = v.cd_cargo_pergunta
                AND c.nr_cand = v.nr_votavel
                AND c.st_substituido = 'N'
          LEFT JOIN partido pa
             ON     pa.cd_pleito = v.cd_pleito
                AND pa.cd_eleicao = v.cd_eleicao
                AND pa.nr_partido = v.nr_votavel
                AND v.cd_tipo_votavel = 4
          LEFT JOIN tipo_votavel tv
             ON v.cd_tipo_votavel_destinacao = tv.cd_tipo_votavel
          LEFT JOIN motivo_destinacao_voto md
             ON md.cd_motivo_destinacao_voto = v.cd_motivo_destinacao_voto
          LEFT JOIN situacao_candidato sa
             ON c.cd_situacao_candidato_atual = sa.cd_situacao_candidato
          LEFT JOIN situacao_candidato se
             ON c.cd_situacao_candidato_eleicao = se.cd_situacao_candidato
          INNER JOIN pleito p ON v.cd_pleito = p.cd_pleito
          LEFT JOIN ue_processo ue
             ON     p.cd_processo_eleitoral = ue.cd_processo_eleitoral
                AND v.sg_ue = ue.sg_ue
          LEFT JOIN tipo_decisao_judicial tdj
             ON tdj.cd_tipo_decisao_judicial = c.cd_tipo_decisao_judicial
          LEFT JOIN
          (SELECT d.cd_pleito,
                  d.cd_eleicao,
                  d.sg_ue,
                  d.sq_drap,
                  d.tp_drap,
                  le.cd_cargo,
                  co.nm_coligacao,
                  NVL (pi.nr_partido_federacao, pc.nr_partido_federacao) nr_partido,
                  d.cd_situacao_drap_eleicao,
                  sde.nm_situacao_drap nm_situacao_drap_eleicao,
                  d.cd_situacao_drap cd_situacao_drap_atual,
                  sda.nm_situacao_drap nm_situacao_drap_atual,
                  d.cd_tipo_decisao_judicial cd_tipo_decisao_judicial_drap,
                  td.nm_tipo_decisao_judicial nm_tipo_decisao_judicial_drap,
                  pc.st_apto
             FROM drap d
                  INNER JOIN legenda le
                     ON     le.cd_eleicao = d.cd_eleicao
                        AND le.sg_ue = d.sg_ue
                        AND le.sq_drap = d.sq_drap
                  LEFT JOIN partido_federacao_coligacao pc
                     ON     d.cd_pleito = pc.cd_pleito
                        AND d.cd_eleicao = pc.cd_eleicao
                        AND d.sg_ue = pc.sg_ue
                        AND d.sq_drap = pc.sq_drap
                  LEFT JOIN coligacao co
                     ON     co.cd_pleito = pc.cd_pleito
                        AND co.cd_eleicao = pc.cd_eleicao
                        AND co.sg_ue = pc.sg_ue
                        AND co.sq_drap = pc.sq_drap
                  LEFT JOIN drap_isolado pi
                     ON     pi.cd_pleito = d.cd_pleito
                        AND pi.cd_eleicao = d.cd_eleicao
                        AND pi.sg_ue = d.sg_ue
                        AND pi.sq_drap = d.sq_drap
                  LEFT JOIN situacao_drap sda
                     ON sda.cd_situacao_drap = d.cd_situacao_drap
                  LEFT JOIN situacao_drap sde
                     ON sde.cd_situacao_drap = d.cd_situacao_drap_eleicao
                  LEFT JOIN tipo_decisao_judicial td
                     ON d.cd_tipo_decisao_judicial =
                           td.cd_tipo_decisao_judicial) vl
             ON     vl.cd_pleito = v.cd_pleito
                AND vl.cd_eleicao = v.cd_eleicao
                AND vl.sg_ue = v.sg_ue
                AND vl.cd_cargo = v.cd_cargo_pergunta
                AND vl.nr_partido = v.nr_votavel
                AND v.cd_tipo_votavel = 4
    WHERE v.nr_votavel NOT IN (93,
                               94,
                               95,
                               96,
                               97,
                               98,
                               99);