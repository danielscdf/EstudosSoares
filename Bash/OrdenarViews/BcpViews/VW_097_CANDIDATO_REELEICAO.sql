CREATE OR REPLACE VIEW vw_097_candidato_reeleicao
AS
SELECT c.nr_cand,
       c.nm_candidato,
       c.nm_cand_social,
       c.nm_cand_urna,
       cg.nm_cargo_abreviado,
       cg.nm_cargo_feminino,
       cg.nm_cargo_masculino,
       cg.nm_cargo_neutro,
       c.st_reeleicao,
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
       c.sg_ue_uf,
       c.cd_eleicao,
       c.sg_ue,
       ue.nm_ue,
       c.cd_cargo,
       c.nr_partido,
       pc_ad_legenda.fc_monta_legenda_tot(p_cd_pleito => c.cd_pleito, p_cd_eleicao => c.cd_eleicao, p_coligacao => c.sq_drap) nm_partido_coligacao,
       upper(nvl(co.nm_coligacao, nvl(fe.nm_federacao, pa.nr_partido || ' - ' || pa.nm_partido))) nm_partido_coligacao_completo,
       decode(c.st_substituido, 'S', '*', NULL) candidato_substituido,
       CASE
            WHEN c.st_substituido = 'S' THEN
             (SELECT cc.nr_partido || ' - ' || cc.nm_cand_urna
              FROM candidato cc
              WHERE cc.cd_pleito = c.cd_pleito
                    AND cc.cd_eleicao = c.cd_eleicao
                    AND cc.sg_ue_uf = c.sg_ue_uf
                    AND cc.sg_ue = c.sg_ue
                    AND cc.cd_cargo = c.cd_cargo
                    AND cc.sq_cand_substituido = c.sq_candidato)
            ELSE
             NULL
        END nr_nome_candidato_substituto,
       c.sq_candidato,
       c.sq_cand_substituido
FROM candidato c
JOIN situacao_candidato sc
ON c.cd_situacao_candidato_atual = sc.cd_situacao_candidato
INNER JOIN pleito p
ON c.cd_pleito = p.cd_pleito
LEFT JOIN ue_processo ue
ON p.cd_processo_eleitoral = ue.cd_processo_eleitoral
   AND c.sg_ue = ue.sg_ue
LEFT JOIN situacao_totalizacao st
ON c.cd_situacao_totalizacao = st.cd_situacao_totalizacao
LEFT JOIN tipo_decisao_judicial tdj
ON tdj.cd_tipo_decisao_judicial = c.cd_tipo_decisao_judicial
JOIN cargo cg
ON c.cd_cargo = cg.cd_cargo
   AND c.cd_eleicao = cg.cd_eleicao
JOIN sexo sx
ON sx.cd_sexo = c.cd_sexo
JOIN situacao_candidato sci
ON c.cd_situacao_candidato_importa = sci.cd_situacao_candidato
JOIN situacao_candidato sce
ON c.cd_situacao_candidato_eleicao = sce.cd_situacao_candidato
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
WHERE c.st_reeleicao = 'S'
      AND cg.cd_cargo_superior IS NULL;