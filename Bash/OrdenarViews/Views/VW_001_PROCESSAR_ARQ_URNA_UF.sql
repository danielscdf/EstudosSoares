CREATE OR REPLACE VIEW vw_001_processar_arq_urna_uf
AS
    SELECT DISTINCT UP.sg_ue_uf sg_ue_superior, UP.sg_ue
      FROM admtotcentral.pleito p
           JOIN admtotcentral.ue_pleito UP
               ON UP.cd_processo_eleitoral = p.cd_processo_eleitoral
              AND UP.cd_pleito = p.cd_pleito
           JOIN admtotcentral.fase f ON 1 = 1
     WHERE UPPER(p.st_ativo) = 'S'
       AND UP.sg_ue <> 'BR'
       AND UP.sg_ue <> UP.sg_ue_uf
       AND ((f.st_fase = 'O'
         AND TRUNC(SYSDATE) BETWEEN TRUNC(p.dt_pleito) AND TRUNC(UP.dt_limite_trans_arquivo))
         OR f.st_fase <> 'O');