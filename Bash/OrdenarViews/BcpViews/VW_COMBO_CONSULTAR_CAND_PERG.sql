CREATE OR REPLACE VIEW vw_combo_consultar_cand_perg
AS
    SELECT ue.cd_pleito,
		       cd_eleicao,
           DECODE(UP.cd_tipo_ue,  3, 0,  5, 0,  2, 1,  4, 1,  2)
               cd_tipo_abrangencia,
           UP.sg_ue,
           UP.nm_ue,
           UP.sg_ue_superior
      FROM ue_eleicao ue
           JOIN ue_processo UP
               ON ue.cd_processo_eleitoral = UP.cd_processo_eleitoral
              AND ue.sg_ue = UP.sg_ue;
