CREATE OR REPLACE VIEW VW_017_CONSULTAR_MRJ AS
SELECT ue.cd_processo_eleitoral,
           ni.id_eleitoral cd_pleito,
           ue.sg_ue_superior sg_ue_uf,
           ni.sg_ue sg_ue_mun,
           ue.nm_ue,
           ni.nr_zona,
           CASE
               WHEN uj.nr_urna_mrj IS NULL THEN
                   '*'
               ELSE
                   mj.nr_mesa ||
                   '-' ||
                   uj.nr_urna_mrj
           END
               mesa_urna
      FROM notificacao_importacao_full ni
           LEFT JOIN mesa_justificativa_pleito mj
               ON ni.id_eleitoral = mj.cd_pleito
              AND ni.sg_ue = mj.sg_ue_mun
              AND ni.nr_zona = mj.nr_zona
           LEFT JOIN urna_justificativa uj
               ON mj.cd_pleito = uj.cd_pleito
              AND mj.sg_ue_mun = uj.sg_ue_mun
              AND mj.nr_zona = uj.nr_zona
              AND mj.nr_mesa = uj.nr_mesa
           JOIN pleito P
               ON ni.id_eleitoral = P.cd_pleito
           JOIN ue_processo ue
               ON ue.cd_processo_eleitoral = p.cd_processo_eleitoral
              AND ue.sg_ue = ni.sg_ue
     WHERE ni.cd_tipo_pacote = 4;
	 