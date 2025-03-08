CREATE OR REPLACE VIEW vw_085_exp_qp
AS
SELECT qp.cd_eleicao,
       qp.sg_ue,
			 ue.nm_ue,
       qp.sg_ue_uf,
       qp.cd_cargo,
       qp.sq_drap,
       qp.qt_votos_nominais,
       qp.qt_votos_legenda,
       (qp.qt_votos_nominais + qp.qt_votos_legenda) qt_votos_validos,
       qp.qt_vagas_qp_obtida,
       qp.qt_cand_votacao_minima_qp qt_cando_10_qe,
       qp.qt_vagas_qp_preenchida,
       NVL((select distinct c.nm_coligacao 
             from partido_federacao_coligacao pc
             join coligacao c
             on pc.cd_pleito = c.cd_pleito
             and pc.cd_eleicao = c.cd_eleicao
             and pc.sg_ue = c.sg_ue
             and pc.sq_drap = c.sq_drap
             join legenda l
               on pc.cd_eleicao = l.cd_eleicao
              and pc.sg_ue = l.sg_ue
              and pc.sq_drap = l.sq_drap
            where pc.cd_eleicao = qp.cd_eleicao
              and pc.sg_ue = qp.sg_ue
              and pc.sq_drap = qp.sq_drap
              and l.cd_cargo = qp.cd_cargo
              and pc.st_apto = 'S'
              ),
           (select nvl(fe.nm_federacao,p.nr_partido || ' - ' ||p.sg_partido)
              from drap_isolado pi
              join partido p
                on pi.cd_pleito = p.cd_pleito
               and pi.cd_eleicao = p.cd_eleicao
               and pi.nr_partido_federacao = p.nr_partido
              join legenda l
                on pi.cd_eleicao = l.cd_eleicao
               and pi.sg_ue = l.sg_ue
               and pi.sq_drap = l.sq_drap
							 LEFT JOIN federacao fe
							      ON fe.cd_pleito = p.cd_pleito
										AND fe.cd_eleicao = p.cd_eleicao
										AND fe.nr_federacao = p.nr_federacao
             where pi.cd_eleicao = qp.cd_eleicao
               and pi.sg_ue = qp.sg_ue
               and pi.sq_drap = qp.sq_drap
               and l.cd_cargo = qp.cd_cargo)) sg_partido
  FROM quociente_partidario qp
INNER JOIN eleicao e
      ON qp.cd_eleicao = e.cd_eleicao
INNER JOIN pleito p
      ON e.cd_pleito = p.cd_pleito
INNER JOIN ue_processo ue
      ON p.cd_processo_eleitoral = ue.cd_processo_eleitoral
			AND qp.sg_ue = ue.sg_ue;