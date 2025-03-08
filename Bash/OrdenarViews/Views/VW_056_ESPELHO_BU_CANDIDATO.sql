CREATE OR REPLACE VIEW vw_056_espelho_bu_candidato
AS
      SELECT s.cd_pleito,
             s.cd_eleicao,
             el.nm_eleicao,
             s.sg_ue_uf,
             va.sg_ue,
             s.sg_ue_mun,
             s.nr_zona,
             s.nr_secao,
             va.cd_cargo_pergunta,
             DECODE(
                    cp.cd_tipo_cargo_pergunta,
                    3, (SELECT pe.nm_pergunta
                          FROM pergunta pe
                         WHERE cp.cd_pleito = pe.cd_pleito
                           AND cp.cd_eleicao = pe.cd_eleicao
                           AND cp.cd_cargo_pergunta = pe.cd_pergunta),
                    (SELECT cg.nm_cargo_neutro
                       FROM cargo cg
                      WHERE cp.cd_eleicao = cg.cd_eleicao
                        AND cp.cd_cargo_pergunta = cg.cd_cargo)
                   )
                 nm_cargo_pergunta,
             DECODE(
                    p.nr_partido,
                    NULL, NULL,
                    p.nr_partido ||
                    ' - ' ||
                    p.sg_partido
                   )
                 partido,
             COALESCE(ct.nm_candidato, r.nm_resposta, NULL) nm_candidato_resposta,
             COALESCE(ct.nm_cand_urna, r.nm_resposta, NULL) nm_cand_urna_resposta,
             COALESCE(ct.sq_candidato, r.nr_resposta, NULL) sq_candidato_resposta,
             NVL(vt.nr_votavel, 0) nr_candidado_resposta,
             NVL(se.qt_votos, 0) qt_votos,
             vt.nr_partido,
             cp.cd_tipo_cargo_pergunta,
             vt.cd_tipo_votavel,
             p.sg_partido,
             s.qt_aptos qt_eleitores_aptos,
             DECODE(cp.cd_tipo_cargo_pergunta,  1, 'N',  2, 'S',  3, 'N') voto_proporcional,
             SUM(NVL(se.qt_votos, 0))
                 OVER(
                      PARTITION BY s.cd_pleito,
                                   s.cd_eleicao,
                                   vt.sg_ue,
                                   s.nr_zona,
                                   s.nr_secao,
                                   vt.cd_cargo_pergunta,
                                   vt.nr_partido
                     )
                 total_votos_partido,
             SUM(CASE WHEN vt.cd_tipo_votavel = 1 THEN se.qt_votos ELSE 0 END)
                 OVER(
                      PARTITION BY s.cd_pleito,
                                   s.cd_eleicao,
                                   s.sg_ue_mun,
                                   s.nr_zona,
                                   s.nr_secao,
                                   vt.cd_cargo_pergunta
                     )
                 total_votos_nominais_validos,
             SUM(CASE WHEN vt.cd_tipo_votavel = 2 THEN se.qt_votos ELSE 0 END)
                 OVER(
                      PARTITION BY s.cd_pleito,
                                   s.cd_eleicao,
                                   s.sg_ue_mun,
                                   s.nr_zona,
                                   s.nr_secao,
                                   vt.cd_cargo_pergunta
                     )
                 total_votos_brancos,
             SUM(CASE WHEN vt.cd_tipo_votavel = 3 THEN se.qt_votos ELSE 0 END)
                 OVER(
                      PARTITION BY s.cd_pleito,
                                   s.cd_eleicao,
                                   s.sg_ue_mun,
                                   s.nr_zona,
                                   s.nr_secao,
                                   vt.cd_cargo_pergunta
                     )
                 total_votos_nulos,
             SUM(CASE WHEN vt.cd_tipo_votavel = 4 THEN se.qt_votos ELSE 0 END)
                 OVER(
                      PARTITION BY s.cd_pleito,
                                   s.cd_eleicao,
                                   s.sg_ue_mun,
                                   s.nr_zona,
                                   s.nr_secao,
                                   vt.cd_cargo_pergunta
                     )
                 total_votos_legenda,
             SUM(CASE WHEN vt.cd_tipo_votavel = 5 THEN se.qt_votos ELSE 0 END)
                 OVER(
                      PARTITION BY s.cd_pleito,
                                   s.cd_eleicao,
                                   vt.sg_ue,
                                   s.nr_zona,
                                   s.nr_secao,
                                   vt.cd_cargo_pergunta
                     )
                 total_votos_sem_cand_para_votar,
             SUM(CASE WHEN vt.cd_tipo_votavel = 6 THEN se.qt_votos ELSE 0 END)
                 OVER(
                      PARTITION BY s.cd_pleito,
                                   s.cd_eleicao,
                                   vt.sg_ue,
                                   s.nr_zona,
                                   s.nr_secao,
                                   vt.cd_cargo_pergunta
                     )
                 total_votos_anulado,
             SUM(CASE WHEN vt.cd_tipo_votavel = 7 THEN se.qt_votos ELSE 0 END)
                 OVER(
                      PARTITION BY s.cd_pleito,
                                   s.cd_eleicao,
                                   vt.sg_ue,
                                   s.nr_zona,
                                   s.nr_secao,
                                   vt.cd_cargo_pergunta
                     )
                 total_votos_anulado_sub_judice,
             SUM(CASE WHEN vt.cd_tipo_votavel = 8 THEN se.qt_votos ELSE 0 END)
                 OVER(
                      PARTITION BY s.cd_pleito,
                                   s.cd_eleicao,
                                   vt.sg_ue,
                                   s.nr_zona,
                                   s.nr_secao,
                                   vt.cd_cargo_pergunta
                     )
                 total_votos_nulo_tecnico,
             SUM(CASE WHEN vt.cd_tipo_votavel = 9 THEN se.qt_votos ELSE 0 END)
                 OVER(
                      PARTITION BY s.cd_pleito,
                                   s.cd_eleicao,
                                   vt.sg_ue,
                                   s.nr_zona,
                                   s.nr_secao,
                                   vt.cd_cargo_pergunta
                     )
                 total_votos_anul_apurado_sep,
             SUM(NVL(se.qt_votos, 0))
                 OVER(
                      PARTITION BY s.cd_pleito,
                                   s.cd_eleicao,
                                   s.sg_ue_mun,
                                   s.nr_zona,
                                   s.nr_secao,
                                   vt.cd_cargo_pergunta
                     )
                 qt_total_votos_computados,
             SUM(CASE WHEN vt.cd_tipo_votavel = 4 THEN se.qt_votos ELSE 0 END)
                 OVER(
                      PARTITION BY s.cd_pleito,
                                   s.cd_eleicao,
                                   vt.sg_ue,
                                   s.nr_zona,
                                   s.nr_secao,
                                   vt.cd_cargo_pergunta,
                                   vt.nr_partido
                     )
                 qt_votos_legenda
        FROM secao_eleicao s
             JOIN eleicao el
                 ON s.cd_pleito = el.cd_pleito
                AND s.cd_eleicao = el.cd_eleicao
             JOIN vaga va
                 ON va.cd_eleicao = s.cd_eleicao
                AND va.sg_ue IN (s.sg_ue_uf, s.sg_ue_mun, 'BR')
             JOIN cargo_pergunta cp
                 ON cp.cd_pleito = s.cd_pleito
                AND cp.cd_eleicao = s.cd_eleicao
                AND cp.cd_cargo_pergunta = va.cd_cargo_pergunta
             JOIN votavel vt
                 ON vt.cd_pleito = s.cd_pleito
                AND vt.cd_eleicao = s.cd_eleicao
                AND vt.sg_ue_uf IN (s.sg_ue_uf, 'BR')
                AND vt.sg_ue = va.sg_ue
                AND vt.cd_cargo_pergunta = va.cd_cargo_pergunta
             JOIN voto_secao se
                 ON s.cd_pleito = se.cd_pleito
                AND s.cd_pleito = vt.cd_pleito
                AND s.cd_eleicao = se.cd_eleicao
                AND s.cd_eleicao = vt.cd_eleicao
                AND s.sg_ue_uf = se.sg_ue_uf
                AND s.sg_ue_mun = se.sg_ue_mun
                AND va.sg_ue = se.sg_ue
                AND vt.sg_ue = se.sg_ue
                AND s.nr_zona = se.nr_zona
                AND s.nr_secao = se.nr_secao
                AND va.cd_cargo_pergunta = se.cd_cargo_pergunta
                AND vt.cd_cargo_pergunta = se.cd_cargo_pergunta
                AND vt.nr_votavel = se.nr_votavel
             LEFT JOIN partido p
                 ON p.cd_pleito = vt.cd_pleito
                AND p.cd_eleicao = vt.cd_eleicao
                AND p.nr_partido = vt.nr_partido
             LEFT JOIN candidato ct
                 ON vt.cd_pleito = ct.cd_pleito
                AND vt.cd_eleicao = ct.cd_eleicao
                AND vt.sg_ue_uf = ct.sg_ue_uf
                AND vt.sg_ue = ct.sg_ue
                AND vt.cd_cargo_pergunta = ct.cd_cargo
                AND vt.nr_votavel = ct.nr_cand
                AND ct.sq_cand_substituido IS NULL
             LEFT JOIN resposta r
                 ON vt.cd_pleito = r.cd_pleito
                AND vt.cd_eleicao = r.cd_eleicao
                AND vt.sg_ue_uf = r.sg_ue_uf
                AND vt.sg_ue = r.sg_ue
                AND vt.cd_cargo_pergunta = r.cd_pergunta
                AND vt.nr_votavel = r.nr_resposta
    ORDER BY el.nr_ordem_impressao, cp.sq_ordem_relatorio, vt.nr_partido;