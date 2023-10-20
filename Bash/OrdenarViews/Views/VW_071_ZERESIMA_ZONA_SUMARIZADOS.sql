CREATE OR REPLACE VIEW vw_071_zeresima_zona_sumarizados
AS SELECT mzp.cd_pleito,
       mze.cd_eleicao,
       mzp.sg_ue_uf,
			 mzp.sg_ue_mun,
			 mzp.nr_zona,
       mzp.qt_secoes,
       mzp.qt_secoes_agregadas,
       mze.qt_aptos,
      (SELECT SUM(max(qt_comparecimento))
      FROM secao_tp_cargo_perg st
      WHERE st.cd_pleito = mzp.cd_pleito
            AND st.sg_ue_uf = mzp.sg_ue_uf
            AND st.sg_ue_mun = mzp.sg_ue_mun
            AND st.nr_zona = mzp.nr_zona
      GROUP BY st.cd_pleito, st.cd_eleicao, st.sg_ue_mun, st.nr_zona) qt_comparecimento

FROM mun_zona_pleito mzp
INNER JOIN mun_zona_eleicao mze
      ON mzp.cd_pleito = mze.cd_pleito
      AND mzp.sg_ue_uf = mze.sg_ue_uf
      AND mzp.sg_ue_mun = mze.sg_ue_mun
      AND mzp.nr_zona = mze.nr_zona
GROUP BY mzp.cd_pleito, mze.cd_eleicao, mzp.sg_ue_uf, mzp.sg_ue_mun, mzp.nr_zona, mzp.qt_secoes,mzp.qt_secoes_agregadas, mze.qt_aptos;
