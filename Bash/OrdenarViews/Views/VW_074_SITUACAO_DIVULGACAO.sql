CREATE OR REPLACE VIEW vw_074_situacao_divulgacao
AS
    SELECT uee.cd_pleito,
           uee.cd_eleicao,
           e.nm_eleicao,
           uee.sg_ue,
           uee.sg_ue_uf,
           uep.nm_ue,
           DECODE(NVL(uee.st_autoriza_divulgacao, 'S'), 'S', 'N', 'S') st_bloqueio
      FROM ue_eleicao uee
           INNER JOIN ue_processo uep
               ON uee.cd_processo_eleitoral = uep.cd_processo_eleitoral
              AND uee.sg_ue = uep.sg_ue
           INNER JOIN eleicao e ON e.cd_eleicao = uee.cd_eleicao;