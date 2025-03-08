CREATE OR REPLACE VIEW VW_VOTO_UF AS
SELECT vmz.cd_pleito,
       vmz.cd_eleicao,
			 vmz.sg_ue,
       ue.sg_ue_uf,
       vmz.cd_cargo_pergunta,
       vmz.nr_votavel,
       sum(vmz.qt_votos_totalizados) qt_votos
FROM voto_mun_zona vmz
INNER JOIN ue_pleito ue
      ON vmz.cd_pleito = ue.cd_pleito
      AND vmz.sg_ue_mun = ue.sg_ue
GROUP BY vmz.cd_pleito,
       vmz.cd_eleicao,
			 vmz.sg_ue,
       ue.sg_ue_uf,
       vmz.cd_cargo_pergunta,
       vmz.nr_votavel;
	   