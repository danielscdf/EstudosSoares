CREATE OR REPLACE VIEW vw_classificacao_candidato
AS
    WITH dados_cand
         AS (SELECT DECODE(can.cd_situacao_totalizacao,  1, 1,  2, 1,  3, 1,  6, 1,  5, 2,  4, 3,  4) sq_ordem_eleitos,
                    NVL(vmz.qt_votos_computados, 0) qt_votos,
                    can.cd_cargo cd_cargo_pergunta,
                    can.nr_partido,
                    can.nm_cand_urna AS nm_candidato,
                    NVL(des.sq_classificacao, 0) AS sq_classificacao,
                    can.sg_ue,
                    can.cd_eleicao,
                    can.cd_pleito,
                    can.nr_cand nr_votavel,
                    can.dt_nascimento,
                    can.sg_ue_uf
               FROM voto_mun_zona vmz, candidato can, desempate des
              WHERE can.nr_cand = vmz.nr_votavel(+)
                AND can.sg_ue_uf = vmz.sg_ue_uf(+)
                AND vmz.cd_cargo_pergunta(+) = can.cd_cargo
                AND vmz.cd_eleicao(+) = can.cd_eleicao
                AND vmz.sg_ue(+) = can.sg_ue
                AND vmz.cd_pleito(+) = can.cd_pleito
                AND can.st_substituido <> 'S'
                AND des.cd_pleito(+) = can.cd_pleito
                AND des.cd_eleicao(+) = can.cd_eleicao
                AND des.sg_ue_uf(+) = can.sg_ue_uf
                AND des.cd_cargo_pergunta(+) = can.cd_cargo
                AND des.sg_ue(+) = can.sg_ue
                AND des.nr_votavel(+) = can.nr_cand
             UNION ALL
             SELECT DECODE(res.cd_situacao_totalizacao,  1, 1,  2, 1,  3, 1,  6, 1,  5, 2,  4, 3,  4) sq_ordem_eleitos,
                    vmz.qt_votos_totalizados,
                    res.cd_pergunta cd_cargo_pergunta,
                    NULL,
                    res.nm_resposta,
                    0 AS sq_classificacao,
                    res.sg_ue,
                    res.cd_eleicao,
                    res.cd_pleito,
                    res.nr_resposta nr_votavel,
                    NULL,
                    res.sg_ue_uf
               FROM voto_mun_zona vmz, resposta res
              WHERE res.nr_resposta = vmz.nr_votavel(+)
                AND vmz.cd_cargo_pergunta(+) = res.cd_pergunta
                AND vmz.sg_ue(+) = res.sg_ue
                AND vmz.cd_eleicao(+) = res.cd_eleicao
                AND vmz.cd_pleito(+) = res.cd_pleito)
      SELECT sq_ordem_eleitos,
             SUM(NVL(qt_votos, 0)) qtd_votos,
             cd_cargo_pergunta,
             nm_candidato,
             sq_classificacao,
             sg_ue,
             cd_eleicao,
             cd_pleito,
             nr_votavel,
             dt_nascimento,
             sg_ue_uf
        FROM dados_cand
    GROUP BY sq_ordem_eleitos,
             cd_cargo_pergunta,
             nm_candidato,
             sq_classificacao,
             sg_ue,
             cd_eleicao,
             cd_pleito,
             nr_votavel,
             dt_nascimento,
             sg_ue_uf
    ORDER BY sq_ordem_eleitos, qtd_votos DESC, sq_classificacao, dt_nascimento, nr_votavel;