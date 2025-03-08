CREATE OR REPLACE VIEW vw_101_candidatos_substituidos AS
   SELECT
        c.cd_pleito,
        c.cd_eleicao,
				e.nm_eleicao,
        c.sg_ue,
        ue.NM_UE,
        c.sg_ue_uf,
        uf.nm_ue nm_uf,
        c.cd_cargo,
        ca.NM_CARGO_NEUTRO,
        c.nr_cand nr_cand_substituto,
        c.nm_candidato nm_candidato_substituto,
        c.nr_partido,
        p.sg_partido,
        c.cd_situacao_totalizacao,
        st.NM_SITUACAO_TOTALIZACAO,
        c2.nr_cand nr_cand_substituido,
        c2.nm_candidato nm_candidato_substituido
    FROM
        candidato c
        JOIN candidato c2 ON ( c.cd_pleito = c2.cd_pleito
                               AND c.cd_eleicao = c2.cd_eleicao
                               AND c.sg_ue_uf = c2.sg_ue_uf
                               AND c.sg_ue = c2.sg_ue
                               AND c.cd_cargo = c2.cd_cargo
                               AND c.sq_cand_substituido = c2.sq_candidato )
        JOIN UE ue on (c.sg_ue = ue.SG_UE)
        JOIN UE uf on (c.sg_ue_uf = uf.sg_ue)
        LEFT JOIN SITUACAO_TOTALIZACAO st on (c.cd_situacao_totalizacao = st.cd_situacao_totalizacao)
        JOIN CARGO ca on (c.cd_eleicao = ca.cd_eleicao and c.cd_cargo = ca.cd_cargo)
        JOIN PARTIDO p on (c.cd_pleito = p.cd_pleito and c.cd_eleicao = p.cd_eleicao and c.nr_partido = p.nr_partido)
				INNER JOIN eleicao e
				      ON c.cd_eleicao = e.cd_eleicao
    WHERE
        c.sq_cand_substituido IS NOT NULL;
