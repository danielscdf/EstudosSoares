CREATE OR REPLACE VIEW vw_tabelas_basicas_candidatos AS
SELECT c.cd_pleito,
             c.cd_eleicao,
             c.sg_ue,
             mz.sg_ue_uf,
             mz.sg_ue_mun,
             mz.nr_zona,
             c.sq_drap,
             c.cd_cargo,
             c.nr_partido,
             c.cd_situacao_candidato_importa,
             situacaoimportacao.nm_situacao_candidato descricao_situacao_importa,
             c.cd_situacao_candidato_eleicao,
             situacaoeleicao.nm_situacao_candidato    descricao_situacao_eleicao,
             c.cd_situacao_candidato_atual,
             situacaoatual.nm_situacao_candidato      descricao_situacao_atual,
             c.nr_cand,
             c.nm_candidato,
             c.nm_cand_urna,
             c.cd_tipo_decisao_judicial,
             tdj.nm_tipo_decisao_judicial
      FROM candidato c
      JOIN situacao_candidato situacaoimportacao
      ON (situacaoimportacao.cd_situacao_candidato = c.cd_situacao_candidato_importa)
      JOIN situacao_candidato situacaoeleicao
      ON (situacaoeleicao.cd_situacao_candidato = c.cd_situacao_candidato_eleicao)
      JOIN situacao_candidato situacaoatual
      ON (situacaoatual.cd_situacao_candidato = c.cd_situacao_candidato_atual)
      LEFT OUTER JOIN tipo_decisao_judicial tdj
      ON (tdj.cd_tipo_decisao_judicial = c.cd_tipo_decisao_judicial)      
      INNER JOIN mun_zona_eleicao mz
           ON mz.cd_pleito = c.cd_pleito
           AND mz.cd_eleicao = c.cd_eleicao
           AND c.sg_ue_uf IN (mz.sg_ue_uf, 'BR')
           AND c.sg_ue IN (mz.sg_ue_mun, mz.sg_ue_uf, 'BR');
