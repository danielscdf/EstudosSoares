CREATE OR REPLACE VIEW vw_085_exp_pendencia
AS
SELECT ps.cd_processo_eleitoral,
       ps.cd_pleito,
       ps.sg_ue_uf,
       ps.sg_ue_mun,
       ue.nm_ue,
       ps.nr_zona,
       ps.nr_secao,
       ps.sq_pendencia_secao_pleito,
       ps.dt_pendencia_hor_loc,
       ps.dt_recebimento_pend_hor_loc,
       tp.cd_tipo_pendencia,
       t.nm_tipo_pendencia,
       tp.cd_tipo_pendencia||' - '||t.nm_tipo_pendencia ds_tipo_pendencia,
       ps.cd_tipo_urna,
       tu.nm_tipo_urna,
       ov.nm_ori_votos,
       ps.st_pendencia,
       ps.ds_motivo,
       decode(ps.st_pendencia,'E','Excluída', 'N', 'Não Processada', 'P', 'Processada') nm_st_pendencia
FROM pendencia_secao_pleito ps
INNER JOIN tipo_pendencia_secao_pleito tp
      ON tp.cd_pleito = ps.cd_pleito
      AND tp.sq_pendencia_secao_pleito = ps.sq_pendencia_secao_pleito
INNER JOIN ue_processo ue
      ON ue.cd_processo_eleitoral = ps.cd_processo_eleitoral
      AND ue.sg_ue = ps.sg_ue_mun
INNER JOIN tipo_pendencia t
      ON t.cd_tipo_pendencia = tp.cd_tipo_pendencia
INNER JOIN origem_votos ov
      ON ps.cd_ori_votos = ov.cd_ori_votos
INNER JOIN tipo_urna tu
      ON ps.cd_tipo_urna = tu.cd_tipo_urna;
