CREATE OR REPLACE VIEW vw_099_consulta_desempate_votaveis
AS
SELECT
				d.cd_pleito AS codigoPleito,
				d.cd_eleicao AS codigoEleicao,
                d.sg_ue_uf AS uf,
				d.sg_ue AS ue,
				ue.nm_ue AS nomeUe,
                d.qt_votos AS qtdVotos,
                d.nr_votavel AS numeroVotavel,
                NVL(c.nm_candidato,r.nm_resposta) AS nomeVotavel,
                d.cd_cargo_pergunta AS codigoCargoPergunta,				
				NVL(d.sq_classificacao,0) AS classificacao,
                c.dt_nascimento AS dataNascimento,                 
				 DECODE(
                    cp.cd_tipo_cargo_pergunta,
                    3, NULL,
                    NVL(
                        (SELECT coligacao.nm_coligacao || '(' || pc_ad_legenda.fc_monta_legenda_tot(p_cd_pleito => d.cd_pleito, p_cd_eleicao => d.cd_eleicao, p_coligacao => c.sq_drap, p_numero => 'S') || ')'
                           FROM coligacao
                          WHERE coligacao.cd_pleito = c.cd_pleito
                            AND coligacao.cd_eleicao = c.cd_eleicao
                            AND coligacao.sg_ue = c.sg_ue
                            AND coligacao.sq_drap = c.sq_drap),
                        (pc_ad_legenda.fc_monta_legenda_tot(p_cd_pleito => d.cd_pleito, p_cd_eleicao => d.cd_eleicao, p_coligacao => c.sq_drap, p_numero => 'S'))
                       )
                   ) AS partidoColigacao,	                
				NVL(d.ds_desempate,'') AS observacao
			FROM desempate d
            INNER JOIN cargo_pergunta cp
                 ON cp.cd_pleito = d.cd_pleito
                    AND cp.cd_eleicao = d.cd_eleicao
                    AND cp.cd_cargo_pergunta = d.cd_cargo_pergunta
			LEFT JOIN candidato c ON
				c.CD_PLEITO = d.CD_PLEITO AND
				c.CD_ELEICAO = d.CD_ELEICAO AND
				c.CD_CARGO = d.CD_CARGO_PERGUNTA AND
				c.SG_UE = d.SG_UE AND
        		c.SG_UE_UF = d.SG_UE_UF AND
				c.NR_CAND = d.NR_VOTAVEL AND
				(c.ST_SUBSTITUIDO = 'N' OR c.ST_SUBSTITUIDO IS NULL)
      		LEFT JOIN resposta r ON
        		r.CD_PLEITO = d.CD_PLEITO AND
				r.CD_ELEICAO = d.CD_ELEICAO AND
				r.CD_PERGUNTA = d.CD_CARGO_PERGUNTA AND
				r.SG_UE = d.SG_UE AND
        		r.SG_UE_UF = d.SG_UE_UF AND
				r.NR_RESPOSTA = d.NR_VOTAVEL
            JOIN UE ON (ue.sg_ue = d.sg_ue)
            LEFT JOIN COLIGACAO co ON (co.cd_pleito = d.cd_pleito and co.cd_eleicao = d.cd_eleicao and co.sg_ue = d.sg_ue and co.sq_drap = c.sq_drap)
            LEFT JOIN drap_isolado pi on (pi.cd_pleito = d.cd_pleito and pi.cd_eleicao = d.cd_eleicao and pi.sg_ue = d.sg_ue and pi.SQ_DRAP = c.sq_drap)
            LEFT JOIN partido pa on (pa.cd_pleito = pi.cd_pleito and pa.cd_eleicao = pi.cd_eleicao and pa.nr_partido = pi.nr_partido_federacao)
						LEFT JOIN federacao fe
						     ON fe.cd_pleito = pa.cd_pleito
								 AND fe.cd_eleicao = pa.cd_eleicao
								 AND fe.nr_federacao = pa.nr_federacao
			ORDER BY d.sq_classificacao, c.dt_nascimento;