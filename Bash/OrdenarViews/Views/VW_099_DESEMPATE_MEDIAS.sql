CREATE OR REPLACE VIEW vw_099_desempate_medias
AS
   SELECT media.cd_pleito,
          media.cd_eleicao,
					el.nm_eleicao,
          media.sg_ue,
          ue.nm_ue,
          media.sg_ue_uf,
          media.cd_cargo,
          cg.nm_cargo_neutro,
          media.nr_media,
          media.sq_drap,
          pa.nr_partido,
          NVL (co.nm_coligacao, nvl(fe.nm_federacao,pa.sg_partido)) nm_partido_coligacao,
          qp.qt_votos_nominais,
          qp.qt_votos_legenda,
          media.vr_media,
          DECODE (media.st_media,  'E', 'Empate',  '*', 'Vencedora') situacao
     FROM media
		      JOIN eleicao el
					     ON media.cd_pleito = el.cd_pleito
							 AND media.cd_eleicao = el.cd_eleicao
          JOIN quociente_partidario qp
             ON     media.cd_eleicao = qp.cd_eleicao
                AND media.sg_ue = qp.sg_ue
                AND media.cd_cargo = qp.cd_cargo
                AND media.sg_ue_uf = qp.sg_ue_uf
                AND media.sq_drap = qp.sq_drap
          LEFT JOIN drap_isolado pi
             ON     pi.cd_pleito = media.cd_pleito
                AND pi.cd_eleicao = media.cd_eleicao
                AND pi.sg_ue = media.sg_ue
                AND pi.sq_drap = media.sq_drap
          LEFT JOIN partido pa
             ON     pa.cd_pleito = pi.cd_pleito
                AND pa.cd_eleicao = pi.cd_eleicao
                AND pa.nr_partido = pi.nr_partido_federacao
					LEFT JOIN federacao fe
					     ON fe.cd_pleito = pa.cd_pleito
							 AND fe.cd_eleicao = pa.cd_eleicao
							 AND fe.nr_federacao = pa.nr_federacao
          LEFT JOIN partido_federacao_coligacao pc
             ON     pc.cd_pleito = media.cd_pleito
                AND pc.cd_eleicao = media.cd_eleicao
                AND pc.sg_ue = media.sg_ue
                AND pc.sq_drap = media.sq_drap
                AND pc.st_apto = 'S'
          LEFT JOIN coligacao co
             ON     co.cd_pleito = pc.cd_pleito
                AND co.cd_eleicao = pc.cd_eleicao
                AND co.sg_ue = pc.sg_ue
                AND co.sq_drap = pc.sq_drap
          JOIN drap
             ON     drap.cd_pleito = media.cd_pleito
                AND drap.cd_eleicao = media.cd_eleicao
                AND drap.sg_ue = media.sg_ue
                AND drap.sq_drap = media.sq_drap
          INNER JOIN pleito p ON media.cd_pleito = p.cd_pleito
          INNER JOIN ue_processo ue
             ON     ue.cd_processo_eleitoral = p.cd_processo_eleitoral
                AND ue.sg_ue = media.sg_ue
          INNER JOIN cargo cg
             ON     cg.cd_eleicao = media.cd_eleicao
                AND cg.cd_cargo = media.cd_cargo
    WHERE     media.vr_media =
                 (SELECT MAX (m.vr_media)
                    FROM media m
                   WHERE     m.cd_pleito = media.cd_pleito
                         AND m.cd_eleicao = media.cd_eleicao
                         AND m.cd_cargo = media.cd_cargo
                         AND m.nr_media = media.nr_media
                         AND m.sg_ue_uf = media.sg_ue_uf
                         AND m.sg_ue = media.sg_ue)
          AND (   pi.st_dissidente = 'N'
               OR drap.cd_situacao_drap IN (3, 5, 8)
               OR drap.cd_tipo_decisao_judicial = 2);