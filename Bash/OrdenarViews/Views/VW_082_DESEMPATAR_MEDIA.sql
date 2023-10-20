CREATE OR REPLACE VIEW ADMTOTCENTRAL.VW_082_DESEMPATAR_MEDIA AS
SELECT media.cd_pleito,
           media.cd_eleicao,
           media.sg_ue,
           media.sg_ue_uf,
           media.cd_cargo,
           media.nr_media,
           media.sq_drap,
           pc_ad_legenda.fc_monta_legenda_tot(p_cd_pleito     => media.cd_pleito,
                                              p_cd_eleicao    => media.cd_eleicao,
                                              p_coligacao     => media.sq_drap,
                                              p_numero        => 'S',
                                              p_mostra_todos  => 'T') partidocoligacao,
           qp.qt_votos_nominais,
           qp.qt_votos_legenda,
           media.vr_media,
           DECODE(media.st_media, 'E', 'Empate', '*' ,'Vencedora') situacao
      FROM media
           JOIN quociente_partidario qp
               ON media.cd_eleicao = qp.cd_eleicao
              AND media.sg_ue = qp.sg_ue
              AND media.cd_cargo = qp.cd_cargo
              AND media.sg_ue_uf = qp.sg_ue_uf
              AND media.sq_drap = qp.sq_drap
           JOIN drap
               ON drap.cd_pleito = media.cd_pleito
              AND drap.cd_eleicao = media.cd_eleicao
              AND drap.sg_ue = media.sg_ue
              AND drap.sq_drap = media.sq_drap
     WHERE media.vr_media = (SELECT MAX(m.vr_media)
                               FROM media m
                              WHERE m.cd_pleito = media.cd_pleito
                                AND m.cd_eleicao = media.cd_eleicao
                                AND m.cd_cargo = media.cd_cargo
                                AND m.nr_media = media.nr_media
                                AND m.sg_ue_uf = media.sg_ue_uf
                                AND m.sg_ue = media.sg_ue)
     ORDER BY situacao;
