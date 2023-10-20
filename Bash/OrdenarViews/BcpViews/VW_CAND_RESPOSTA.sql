CREATE OR REPLACE VIEW vw_cand_resposta
AS
    SELECT cand.cd_cargo cd_cargo_pergunta,
           cand.nr_cand numero,
           cand.nm_candidato,
           cand.nm_cand_urna nm_cand_resposta_urna,
           cand.cd_pleito,
           cand.cd_eleicao,
           cand.sg_ue,
           c.cd_tipo_cargo_pergunta,
           cand.cd_situacao_totalizacao,
           cand.sg_ue_uf,
           cand.sq_drap,
           cand.nr_partido,
           vice.nm_vice,
           c.nm_cargo_neutro nm_cargo_pergunta,
           cand.sq_ordem_suplencia
      FROM candidato cand
           JOIN cargo c
               ON cand.cd_eleicao = c.cd_eleicao
              AND cand.cd_cargo = c.cd_cargo
           LEFT JOIN (  SELECT LISTAGG(vc.nm_candidato, ' / ') WITHIN GROUP (ORDER BY vc.ROWID) nm_vice,
                               ca.cd_cargo_superior,
                               vc.cd_pleito,
                               vc.cd_eleicao,
                               vc.sg_ue_uf,
                               vc.sg_ue,
                               vc.nr_cand
                          FROM candidato vc
                               JOIN cargo ca
                                   ON ca.cd_eleicao = vc.cd_eleicao
                                  AND ca.cd_cargo = vc.cd_cargo
                                  AND ca.cd_cargo_superior IS NOT NULL
											WHERE vc.st_substituido <> 'S'
                      GROUP BY ca.cd_cargo_superior,
                               vc.cd_pleito,
                               vc.cd_eleicao,
                               vc.sg_ue_uf,
                               vc.sg_ue,
                               vc.nr_cand
											ORDER BY vc.cd_cargo DESC) vice
               ON vice.cd_pleito = cand.cd_pleito
              AND vice.cd_eleicao = cand.cd_eleicao
              AND vice.sg_ue_uf = cand.sg_ue_uf
              AND vice.sg_ue = cand.sg_ue
              AND vice.nr_cand = cand.nr_cand
              AND vice.cd_cargo_superior = c.cd_cargo
     WHERE cand.st_substituido <> 'S'
       AND c.cd_cargo_superior IS NULL
    UNION
    SELECT r.cd_pergunta,
           r.nr_resposta,
           NULL,
           r.nm_resposta,
           r.cd_pleito,
           r.cd_eleicao,
           r.sg_ue,
           3,
           r.cd_situacao_totalizacao,
           r.sg_ue_uf,
           NULL,
           NULL,
           NULL,
           p.nm_pergunta,
           NULL
      FROM resposta r
           JOIN pergunta p
               ON r.cd_pleito = p.cd_pleito
              AND r.cd_eleicao = p.cd_eleicao
              AND r.cd_pergunta = p.cd_pergunta;