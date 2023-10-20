CREATE OR REPLACE VIEW vw_voto_mun
AS
      SELECT vmz.cd_pleito,
             vmz.cd_eleicao,
             vmz.sg_ue,
             vmz.sg_ue_mun,
             vmz.cd_cargo_pergunta,
             vmz.nr_votavel,
             SUM(vmz.qt_votos_totalizados) qt_votos,
             vmz.sg_ue_uf
        FROM voto_mun_zona vmz
    GROUP BY vmz.cd_pleito,
             vmz.cd_eleicao,
             vmz.sg_ue,
             vmz.sg_ue_mun,
             vmz.cd_cargo_pergunta,
             vmz.nr_votavel,
             vmz.sg_ue_uf;