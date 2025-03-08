CREATE OR REPLACE VIEW vw_064_situacao_part_coligacao
AS
SELECT d.cd_pleito,
           d.cd_eleicao,
           d.sg_ue,
           d.sq_drap,
           d.tp_drap,
           cp.cd_tipo_cargo_pergunta,
           cp.nm_cargo_neutro,
           cp.st_votavel,
           NULL nm_coligacao,
           d.cd_tipo_decisao_judicial,
           DECODE(
                  d.cd_tipo_decisao_judicial,
                  NULL, NULL,
                  (SELECT tipo_decisao_judicial.nm_tipo_decisao_judicial
                     FROM tipo_decisao_judicial
                    WHERE tipo_decisao_judicial.cd_tipo_decisao_judicial = d.cd_tipo_decisao_judicial)
                 )
               nm_tipo_decisao_judicial,
           d.cd_situacao_drap,
           sd.nm_situacao_drap,
           d.cd_situacao_drap_eleicao,
           sdele.nm_situacao_drap nm_situacao_drap_ele,
           d.cd_situacao_drap_importa,
           simp.nm_situacao_drap nm_situacao_importacao,
           p1.nr_partido,
           p1.nm_partido,
           NULL sg_partido_coligacao,
           p1.sg_partido,
           NULL st_apto,
           NULL cd_tipo_votavel_destinacao,
           CASE WHEN v.cd_tipo_votavel_destinacao IS NULL
               THEN
               '*'                  
              ELSE
              DECODE(
                      cp.cd_tipo_cargo_pergunta,
                      1, '*',
                      DECODE(
                             pi.st_dissidente,
                             'S', pc_neg_destinacao_votos.fc_nome_destino_voto_partido(
                                                                                       p_cd_eleicao => d.cd_eleicao,
                                                                                       p_tp_drap => d.tp_drap,
                                                                                       p_cd_tp_decisao_judicial => d.cd_tipo_decisao_judicial,
                                                                                       p_cd_situacao_drap => d.cd_situacao_drap,
                                                                                       p_cd_situacao_drap_eleicao => d.cd_situacao_drap_eleicao,
                                                                                       p_st_apto => NULL
                                                                                      ),
                             pc_ad_tipo_votavel.fc_busca_nm_destinacao_votos(p_cd_tipo_votavel => v.cd_tipo_votavel_destinacao)
                            )
                     )
              END nm_tipo_votavel,
           CASE WHEN v.cd_tipo_votavel_destinacao IS NULL
               THEN
               '*'
               ELSE
               DECODE(
                      cp.cd_tipo_cargo_pergunta,
                      1, '*',
                      DECODE(
                             pi.st_dissidente,
                             'S', pc_neg_destinacao_votos.fc_motivo_destino_voto_partido(
                                                                                         p_cd_eleicao => d.cd_eleicao,
                                                                                         p_tp_drap => d.tp_drap,
                                                                                         p_cd_tp_decisao_judicial => d.cd_tipo_decisao_judicial,
                                                                                         p_cd_situacao_drap => d.cd_situacao_drap,
                                                                                         p_cd_situacao_drap_eleicao => d.cd_situacao_drap_eleicao,
                                                                                         p_st_apto => NULL
                                                                                        ),
                             pc_ad_motivo_destinacao_voto.fc_nm_motivo_destinacao_votos(p_cd_motivo_destinacao_voto => v.cd_motivo_destinacao_voto)
                            )
                     )
               
               END nm_motivo_destinacao_voto,
           l.cd_cargo,
           pi.st_dissidente,
                     fe.nm_federacao,
                     fe.sg_federacao,
             CASE WHEN fe.nm_federacao IS NOT NULL THEN 'F'
                  ELSE 'P'
            END tp_agremiacao
      FROM drap d
           JOIN drap_isolado pi
               ON (d.cd_pleito = pi.cd_pleito
               AND d.cd_eleicao = pi.cd_eleicao
               AND d.sg_ue = pi.sg_ue
               AND d.sq_drap = pi.sq_drap)                     
           LEFT JOIN partido p1
               ON (p1.cd_pleito = pi.cd_pleito
               AND p1.cd_eleicao = pi.cd_eleicao
               AND (p1.nr_partido = pi.nr_partido_federacao
                                 OR p1.nr_federacao = pi.nr_partido_federacao))
           LEFT JOIN federacao fe
                ON fe.cd_pleito = p1.cd_pleito
                AND fe.cd_eleicao = p1.cd_eleicao
                AND fe.nr_federacao = p1.nr_federacao
           JOIN legenda l
               ON d.cd_eleicao = l.cd_eleicao
              AND d.sg_ue = l.sg_ue
              AND d.sq_drap = l.sq_drap
           JOIN cargo cp
               ON cp.cd_eleicao = l.cd_eleicao
              AND cp.cd_cargo = l.cd_cargo
           JOIN situacao_drap sd ON (d.cd_situacao_drap = sd.cd_situacao_drap)
           JOIN situacao_drap sdele ON (d.cd_situacao_drap_eleicao = sdele.cd_situacao_drap)
           JOIN situacao_drap simp ON (d.cd_situacao_drap_importa = simp.cd_situacao_drap)
           LEFT JOIN votavel v
               ON d.cd_pleito = v.cd_pleito
              AND d.cd_eleicao = v.cd_eleicao
              AND d.sg_ue = v.sg_ue
              AND p1.nr_partido = v.nr_votavel
              AND l.cd_cargo = v.cd_cargo_pergunta
    UNION
    SELECT d.cd_pleito,
           d.cd_eleicao,
           d.sg_ue,
           d.sq_drap,
           d.tp_drap,
           cp.cd_tipo_cargo_pergunta,
           cp.nm_cargo_neutro,
           cp.st_votavel,
           c.nm_coligacao,
           d.cd_tipo_decisao_judicial,
           DECODE(
                  d.cd_tipo_decisao_judicial,
                  NULL, NULL,
                  (SELECT tipo_decisao_judicial.nm_tipo_decisao_judicial
                     FROM tipo_decisao_judicial
                    WHERE tipo_decisao_judicial.cd_tipo_decisao_judicial = d.cd_tipo_decisao_judicial)
                 )
               nm_tipo_decisao_judicial,
           d.cd_situacao_drap,
           sd.nm_situacao_drap,
           d.cd_situacao_drap_eleicao,
           sdele.nm_situacao_drap nm_situacao_drap_ele,
           d.cd_situacao_drap_importa,
           simp.nm_situacao_drap nm_situacao_importacao,
           p.nr_partido,
           p.nm_partido,
           pc_ad_legenda.fc_monta_legenda_tot(p_cd_pleito => d.cd_pleito, p_cd_eleicao => d.cd_eleicao, p_coligacao => d.sq_drap) sg_partido_coligacao,
           p.sg_partido,
           pc.st_apto,
           NULL cd_tipo_votavel_destinacao,
           CASE WHEN v.cd_tipo_votavel_destinacao IS NULL
               THEN
               '*'
               ELSE 
               DECODE(
                      cp.cd_tipo_cargo_pergunta,
                      1, '*',
                      DECODE(
                             pc.st_dissidente,
                             'S', pc_neg_destinacao_votos.fc_nome_destino_voto_partido(
                                                                                       p_cd_eleicao => d.cd_eleicao,
                                                                                       p_tp_drap => d.tp_drap,
                                                                                       p_cd_tp_decisao_judicial => d.cd_tipo_decisao_judicial,
                                                                                       p_cd_situacao_drap => d.cd_situacao_drap,
                                                                                       p_cd_situacao_drap_eleicao => d.cd_situacao_drap_eleicao,
                                                                                       p_st_apto => pc.st_apto
                                                                                      ),
                             pc_ad_tipo_votavel.fc_busca_nm_destinacao_votos(p_cd_tipo_votavel => v.cd_tipo_votavel_destinacao)
                            )
                     )
               
              END nm_tipo_votavel,
           CASE WHEN v.cd_tipo_votavel_destinacao IS NULL
               THEN
               '*'
               ELSE
               DECODE(
                      cp.cd_tipo_cargo_pergunta,
                      1, '*',
                      DECODE(
                             pc.st_dissidente,
                             'S', pc_neg_destinacao_votos.fc_motivo_destino_voto_partido(
                                                                                         p_cd_eleicao => d.cd_eleicao,
                                                                                         p_tp_drap => d.tp_drap,
                                                                                         p_cd_tp_decisao_judicial => d.cd_tipo_decisao_judicial,
                                                                                         p_cd_situacao_drap => d.cd_situacao_drap,
                                                                                         p_cd_situacao_drap_eleicao => d.cd_situacao_drap_eleicao,
                                                                                         p_st_apto => pc.st_apto
                                                                                        ),
                             admtotcentral.pc_ad_motivo_destinacao_voto.fc_nm_motivo_destinacao_votos(p_cd_motivo_destinacao_voto => v.cd_motivo_destinacao_voto)
                            )
                     )
               
              END nm_motivo_destinacao_voto,
           l.cd_cargo,
           pc.st_dissidente,
                     fe.nm_federacao,
                     fe.sg_federacao,
                     'C' tp_agremiacao
      FROM drap d
           JOIN partido_federacao_coligacao pc
               ON (pc.cd_pleito = d.cd_pleito
               AND pc.cd_eleicao = d.cd_eleicao
               AND pc.sg_ue = d.sg_ue
               AND pc.sq_drap = d.sq_drap)
           LEFT JOIN partido p
               ON (p.cd_pleito = pc.cd_pleito
               AND p.cd_eleicao = pc.cd_eleicao
               AND (p.nr_partido = pc.nr_partido_federacao
                                 OR p.nr_federacao = pc.nr_partido_federacao))
                     LEFT JOIN federacao fe
                          ON fe.cd_pleito = p.cd_pleito
                                AND fe.cd_eleicao = p.cd_eleicao
                                AND fe.nr_federacao = p.nr_federacao
           JOIN situacao_drap sd ON (d.cd_situacao_drap = sd.cd_situacao_drap)
           JOIN situacao_drap sdele ON (d.cd_situacao_drap_eleicao = sdele.cd_situacao_drap)
           JOIN situacao_drap simp ON (d.cd_situacao_drap_importa = simp.cd_situacao_drap)
           JOIN legenda l
               ON l.cd_eleicao = d.cd_eleicao
              AND l.sg_ue = d.sg_ue
              AND l.sq_drap = d.sq_drap
           JOIN cargo cp
               ON cp.cd_eleicao = l.cd_eleicao
              AND cp.cd_cargo = l.cd_cargo
           JOIN coligacao c
               ON (d.cd_pleito = c.cd_pleito
               AND d.cd_eleicao = c.cd_eleicao
               AND d.sg_ue = c.sg_ue
               AND d.sq_drap = c.sq_drap)
           LEFT JOIN votavel v
               ON d.cd_pleito = v.cd_pleito
              AND d.cd_eleicao = v.cd_eleicao
              AND d.sg_ue = v.sg_ue
              AND p.nr_partido = v.nr_votavel
              AND l.cd_cargo = v.cd_cargo_pergunta
    ORDER BY 1, 2, 3, 5, 4;