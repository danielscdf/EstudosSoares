CREATE OR REPLACE VIEW vw_104_monitoramento_totalizacao
AS
SELECT h.cd_pleito,
           h.cd_eleicao,
           e.nm_eleicao,
           h.sg_ue_uf,
           h.sg_ue,
           u.nm_ue,
           tc.cd_tipo_cargo_pergunta,
           tc.nm_tipo_cargo_pergunta,
           max(h.dt_ult_tot_final_hor_loc) dt_ult_tot_final_hor_loc,
           max(h.dt_ult_tot_final_hor_tse) dt_ult_tot_final_hor_tse
      FROM admtotcentral.historico_totalizacao h
           JOIN eleicao e
                ON h.cd_eleicao = e.cd_eleicao
           JOIN admtotcentral.pleito p ON p.cd_pleito = h.cd_pleito
           JOIN admtotcentral.ue_processo u
               ON p.cd_processo_eleitoral = u.cd_processo_eleitoral
              AND h.sg_ue = u.sg_ue
           JOIN admtotcentral.tipo_cargo_pergunta tc ON h.cd_tipo_cargo_pergunta = tc.cd_tipo_cargo_pergunta
           GROUP BY h.cd_pleito,
                     h.cd_eleicao,
                     e.nm_eleicao,
                     h.sg_ue_uf,
                     h.sg_ue,
                     u.nm_ue,
                     tc.cd_tipo_cargo_pergunta,
										 tc.nm_tipo_cargo_pergunta;
