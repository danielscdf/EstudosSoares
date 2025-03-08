CREATE OR REPLACE VIEW vw_078_rel_result_tot_cand
AS
      SELECT c.cd_pleito,
             c.sg_ue_uf,
             c.cd_eleicao,
             c.nr_cand,
             c.nm_candidato,
             vice.nm_candidato nm_vice,
             c.nm_cand_social,
             c.nm_cand_urna,
             cg.nm_cargo_abreviado,
             cg.nm_cargo_feminino,
             cg.nm_cargo_masculino,
             cg.nm_cargo_neutro,
             cg.cd_tipo_cargo_pergunta,
             sx.nm_sexo,
             c.dt_nascimento,
             sci.cd_situacao_candidato cd_situacao_importacao,
             sci.nm_situacao_candidato nm_situacao_importacao,
             sc.cd_situacao_candidato cd_situacao_atual,
             sc.nm_situacao_candidato nm_situacao_atual,
             sce.cd_situacao_candidato cd_situacao_eleicao,
             sce.nm_situacao_candidato nm_situacao_eleicao,
             st.cd_situacao_totalizacao,
             st.nm_situacao_totalizacao,
             c.cd_tipo_decisao_judicial,
             tdj.nm_tipo_decisao_judicial,
             vice.nm_situacao_eleicao nm_situacao_eleicao_vc,
             vice.nm_situacao_importacao nm_situacao_importacao_vc,
             vice.nm_situacao_atual nm_situacao_atual_vc,
             vice.nm_situacao_totalizacao nm_situacao_totalizacao_vc,
             vice.nm_tipo_decisao_judicial nm_tipo_decisao_judicial_vc,
             c.sg_ue,
             ue.nm_ue,
             c.cd_cargo,
             c.nr_partido,
             pc_ad_legenda.fc_monta_legenda_tot(p_cd_pleito => c.cd_pleito, p_cd_eleicao => c.cd_eleicao, p_coligacao => c.sq_drap) nm_partido_coligacao,
             tv.nm_tipo_destinacao_votos nm_tipo_votavel,
             COALESCE(co.nm_coligacao, fe.nm_federacao, pa.nr_partido ||' - ' ||pa.nm_partido) nm_partido_coligacao_completo,
						 CASE WHEN co.nm_coligacao IS NOT NULL THEN 'C'
						      WHEN fe.nm_federacao IS NOT NULL THEN 'F'
									ELSE 'P'
						END tp_agremiacao
						 
        FROM candidato c
             JOIN situacao_candidato sc ON c.cd_situacao_candidato_atual = sc.cd_situacao_candidato
             INNER JOIN pleito p ON c.cd_pleito = p.cd_pleito
             LEFT JOIN ue_processo ue
                 ON p.cd_processo_eleitoral = ue.cd_processo_eleitoral
                AND c.sg_ue = ue.sg_ue
             LEFT JOIN situacao_totalizacao st ON c.cd_situacao_totalizacao = st.cd_situacao_totalizacao
             LEFT JOIN tipo_decisao_judicial tdj ON tdj.cd_tipo_decisao_judicial = c.cd_tipo_decisao_judicial
             JOIN cargo cg
                 ON c.cd_cargo = cg.cd_cargo
                AND c.cd_eleicao = cg.cd_eleicao
             JOIN sexo sx ON sx.cd_sexo = c.cd_sexo
             JOIN situacao_candidato sci ON c.cd_situacao_candidato_importa = sci.cd_situacao_candidato
             JOIN situacao_candidato sce ON c.cd_situacao_candidato_eleicao = sce.cd_situacao_candidato
             LEFT JOIN coligacao co
                 ON co.cd_eleicao = c.cd_eleicao
                AND co.sg_ue = c.sg_ue
                AND co.sq_drap = c.sq_drap
             JOIN partido pa
                 ON pa.cd_eleicao = c.cd_eleicao
                AND pa.nr_partido = c.nr_partido
						 LEFT JOIN federacao fe
						      ON fe.cd_pleito = pa.cd_pleito
									AND fe.cd_eleicao = pa.cd_eleicao
									AND fe.nr_federacao = pa.nr_federacao
             JOIN votavel v
                 ON c.cd_eleicao = v.cd_eleicao
                AND c.cd_pleito = v.cd_pleito
                AND c.sg_ue_uf = v.sg_ue_uf
                AND c.sg_ue = v.sg_ue
                AND (cg.cd_cargo = v.cd_cargo_pergunta
                  OR cg.cd_cargo_superior = v.cd_cargo_pergunta)
                AND c.nr_cand = v.nr_votavel
             JOIN tipo_votavel tv ON (v.cd_tipo_votavel_destinacao = tv.cd_tipo_votavel)
             LEFT JOIN (SELECT vc.*,
                               ca.cd_cargo_superior,
                               sce2.nm_situacao_candidato nm_situacao_eleicao,
                               sci2.nm_situacao_candidato nm_situacao_importacao,
                               sca2.nm_situacao_candidato nm_situacao_atual,
                               st2.nm_situacao_totalizacao,
                               tdj2.nm_tipo_decisao_judicial
                          FROM candidato vc
                               INNER JOIN cargo ca
                                   ON ca.cd_eleicao = vc.cd_eleicao
                                  AND ca.cd_cargo = vc.cd_cargo
                               INNER JOIN situacao_candidato sci2 ON vc.cd_situacao_candidato_importa = sci2.cd_situacao_candidato
                               INNER JOIN situacao_candidato sce2 ON vc.cd_situacao_candidato_eleicao = sce2.cd_situacao_candidato
                               INNER JOIN situacao_candidato sca2 ON vc.cd_situacao_candidato_atual = sca2.cd_situacao_candidato
                               LEFT JOIN situacao_totalizacao st2 ON vc.cd_situacao_totalizacao = st2.cd_situacao_totalizacao
                               LEFT JOIN tipo_decisao_judicial tdj2 ON tdj2.cd_tipo_decisao_judicial = vc.cd_tipo_decisao_judicial
                         WHERE vc.st_substituido <> 'S') vice
                 ON vice.cd_pleito = c.cd_pleito
                AND vice.cd_eleicao = c.cd_eleicao
                AND vice.sg_ue_uf = c.sg_ue_uf
                AND vice.sg_ue = c.sg_ue
                AND vice.nr_cand = c.nr_cand
                AND vice.cd_cargo_superior = cg.cd_cargo
       WHERE cg.cd_cargo_superior IS NULL
         AND c.st_substituido <> 'S'
    ORDER BY c.sg_ue, cg.cd_tipo_cargo_pergunta, NVL(cg.cd_cargo_superior, cg.cd_cargo), c.nr_cand, cg.cd_cargo;