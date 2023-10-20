CREATE OR REPLACE VIEW VW_063_ARQUIVO_URNA_RECEBIDO AS
SELECT sg_ue_mun,
       cd_pleito,
       nm_ue,
       sg_ue_uf,
       nr_zona,
       nr_secao,
       NVL(CASE BU_VOTACAO
                WHEN 1 THEN 'Validado'
                WHEN 2 THEN 'Erro'
                WHEN 3 THEN 'Em fila'
                END, 'Não recebido') BU_VOTACAO,
       NVL(CASE RDV
                WHEN 1 THEN 'Validado'
                WHEN 2 THEN 'Erro'
                WHEN 3 THEN 'Em fila'
                END, 'Não recebido') RDV,
       NVL(CASE BU_IMPRESSO
                WHEN 1 THEN 'Validado'
                WHEN 2 THEN 'Erro'
                WHEN 3 THEN 'Em fila'
                END, 'Não recebido') BU_IMPRESSO,
       NVL(CASE URNA_CADASTRO
                WHEN 1 THEN 'Validado'
                WHEN 2 THEN 'Erro'
                WHEN 3 THEN 'Em fila'
                END, 'Não recebido') URNA_CADASTRO,
       NVL(CASE LOG_URNA
                WHEN 1 THEN 'Validado'
                WHEN 2 THEN 'Erro'
                WHEN 3 THEN 'Em fila'
                END, 'Não recebido') LOG_URNA,
		 nr_hash_pacote
FROM (
      SELECT sp.sg_ue_mun,
             sp.cd_pleito,
             ue.nm_ue,
             ue.sg_ue_superior sg_ue_uf,
             sp.nr_zona,
             sp.nr_secao,
             CASE WHEN sp.tp_situacao_secao_bu = 'R'
                 THEN ca.nm_conteudo_arquivo
                 WHEN psp.st_pendencia = 'N'
                 THEN ca.nm_conteudo_arquivo
                 ELSE 'Não recebido'
                 END nm_conteudo_arquivo,
             CASE ar.cd_situacao_arquivo
						      WHEN 'v' THEN 1
									WHEN 'e' THEN 2
									WHEN 'f' THEN 3
						 END cd_situacao_arquivo,
			  NVL(sp.nr_hash_pacote,psp.nr_hash_pacote) nr_hash_pacote
      FROM secao_pleito sp
      INNER JOIN ue
            ON sp.sg_ue_uf = ue.sg_ue_superior
            AND sp.sg_ue_mun = ue.sg_ue
      LEFT JOIN arquivo_recebido ar
           ON sp.cd_pleito = ar.cd_pleito
           AND sp.sg_ue_uf = ar.sg_ue_uf
           AND sp.sg_ue_mun = ar.sg_ue_mun
           AND sp.nr_zona = ar.nr_zona
           AND sp.nr_secao = ar.nr_secao
      LEFT JOIN tipo_arquivo_recebido ta
            ON ar.cd_tipo_arquivo_recebido = ta.cd_tipo_arquivo_recebido
      LEFT JOIN conteudo_arquivo ca
           ON ta.cd_conteudo_arquivo = ca.cd_conteudo_arquivo
      LEFT JOIN pendencia_secao_pleito psp
           ON ar.cd_pleito = psp.cd_pleito
           AND ar.sg_ue_uf = psp.sg_ue_uf
           AND ar.sg_ue_mun = psp.sg_ue_mun
           AND ar.nr_zona = psp.nr_zona
           AND ar.nr_secao = psp.nr_secao
           AND psp.st_pendencia = 'N'
      WHERE (ta.cd_conteudo_arquivo IN (1,2,3,4,5) OR ta.cd_conteudo_arquivo IS NULL)
            AND (ar.nr_hash_pacote = NVL(sp.nr_hash_pacote,psp.nr_hash_pacote) OR sp.nr_hash_pacote IS NULL)
 ) ar3
PIVOT(
      MIN(cd_situacao_arquivo)
      FOR nm_conteudo_arquivo IN ('Boletim de Urna' AS BU_VOTACAO, 'Registro Digital de Voto' AS RDV, 'Imagem de BU' AS BU_IMPRESSO, 'Resultado do Cadastro' AS URNA_CADASTRO, 'Log' AS LOG_URNA)
) pvt;