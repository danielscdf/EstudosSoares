CREATE OR REPLACE VIEW VW_VOTAVEL_CANDIDATO_RESPOSTA
AS
SELECT v.cd_pleito,
                    v.sg_ue,
                    v.cd_eleicao,
                    v.cd_cargo_pergunta,
                    v.nr_votavel,
                    v.nr_partido,
                    ct.nm_candidato nm_candidato_resposta,
                    ct.nm_cand_urna nm_cand_urna_resposta,
                    ct.sq_candidato sq_candidato_resposta,
                    v.cd_tipo_votavel,
                    ct.st_substituido,
                    ct.sq_candidato,
                    ct.cd_situacao_totalizacao,
                    ct.dt_nascimento,
                    ct.sq_drap,
                    ct.nr_cand,
                    ct.nm_candidato,
                    NULL nm_resposta,
                    ct.cd_situacao_candidato_atual,
                    ct.sq_cand_substituido,
                    par.sg_partido,
                    v.sg_ue_uf
               FROM votavel v
                    JOIN candidato ct
                       ON  v.cd_eleicao = ct.cd_eleicao
                       AND v.sg_ue_uf = ct.sg_ue_uf
                       AND v.sg_ue = ct.sg_ue
                       AND v.cd_cargo_pergunta = ct.cd_cargo
                       AND v.nr_votavel = ct.nr_cand
                       AND ct.sq_cand_substituido IS NULL
                    JOIN partido par
                        ON ct.cd_eleicao = par.cd_eleicao
                       AND ct.nr_partido = par.nr_partido
             UNION
             SELECT v.cd_pleito,
                    v.sg_ue,
                    v.cd_eleicao,
                    v.cd_cargo_pergunta,
                    v.nr_votavel,
                    v.nr_partido,
                    r.nm_resposta,
                    r.nm_resposta,
                    r.nr_resposta,
                    v.cd_tipo_votavel,
                    NULL,
                    NULL,
                    r.cd_situacao_totalizacao cd_situacao_totalizacao,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    r.nm_resposta,
                    NULL,
                    NULL,
                    NULL,
                    v.sg_ue_uf
               FROM votavel v
                    JOIN resposta r --N?o existe ?ndice para essa combina??o de par?metros, avaliar a possibilidade de criar.
                        ON (v.cd_pleito = r.cd_pleito
                        AND v.cd_eleicao = r.cd_eleicao
                        AND v.sg_ue_uf = r.sg_ue_uf
                        AND v.sg_ue = r.sg_ue
                        AND v.cd_cargo_pergunta = r.cd_pergunta
                        AND v.nr_votavel = r.nr_resposta)
             UNION
             SELECT v.cd_pleito,
                    v.sg_ue,
                    v.cd_eleicao,
                    v.cd_cargo_pergunta,
                    v.nr_votavel,
                    v.nr_partido,
                    NULL,
                    NULL,
                    NULL,
                    v.cd_tipo_votavel,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    par.sg_partido,
                    v.sg_ue_uf
               FROM votavel v
                    LEFT JOIN partido par
                        ON v.nr_partido = par.nr_partido
                       AND v.cd_eleicao = par.cd_eleicao
              WHERE v.cd_tipo_votavel <> 1;
