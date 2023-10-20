CREATE OR REPLACE VIEW vw_067_consultar_secoes
AS
SELECT se.cd_pleito,
       se.cd_eleicao,
			 e.nm_eleicao,
       se.sg_ue_uf,
       se.sg_ue_mun,
       ue.nm_ue,
       se.nr_zona,
       se.nr_secao nr_secao_principal,
       se.qt_aptos - SUM(nvl(sa.qt_aptos,0)) OVER (PARTITION BY sa.cd_pleito, sa.cd_eleicao, sp.sg_ue_uf, sp.sg_ue_mun, sp.nr_zona, sp.nr_secao_principal) qt_aptos_secao_principal,
       se.qt_aptos qt_total_aptos,
       sa.nr_secao nr_secao_agregada,
       sa.qt_aptos qt_aptos_secao_agregada,
       MAX(st.qt_comparecimento) qt_comparecimento_secao,
       CASE
          WHEN spp.cd_tipo_urna <> 1 AND st.st_comparec_nao_ident = 'S' THEN tu.nm_tipo_urna||' / '||spp.ds_motivo||' / Comparecimeto não conhecido'
          WHEN spp.cd_tipo_urna <> 1 AND st.st_comparec_nao_ident = 'N' THEN tu.nm_tipo_urna||' / '||spp.ds_motivo
          WHEN spp.cd_ori_votos IN ('B','R') THEN ov.nm_ori_votos
          WHEN spp.cd_ori_votos = 'C' THEN ov.nm_ori_votos||' / '||ta.nm_tipo_arquivo||' / '||ts.nm_tipo_sistema_apuracao
          WHEN spp.cd_tipo_urna <> 1 and spp.dt_desliga_voto_impresso IS NOT NULL THEN tu.nm_tipo_urna||' / '||spp.dt_desliga_voto_impresso
       END ds_ocorrencia,
			 CASE
          WHEN sa.nr_secao IS NOT NULL AND tu.nm_tipo_urna IS NOT NULL THEN ' '||tu.nm_tipo_urna|| ' / ' ||'Agregação'
          WHEN sa.nr_secao IS NOT NULL THEN ' Agregação'
			 END ds_secao_agregada, --Foi necessário separar a descrição da ocorrencia de seção agregada das demais ocorrências para que fosse possível filtrar, a concatenção portanto é realizada no java
			 decode(sp2.cd_tipo_local_votacao,3,'S','N') tp_preso_provisorio,
			 sp2.cd_tipo_local_votacao
FROM secao_eleicao se
INNER JOIN eleicao e
      ON se.cd_eleicao = e.cd_eleicao
INNER JOIN pleito p
      ON se.cd_pleito = p.cd_pleito
INNER JOIN secao_processo sp2 --Esse segundo relacionamento se faz necessário pois a view pode ser filtrada por eleição, e a informação da seção que agrega a outras fica na secao_processo
      ON p.cd_processo_eleitoral = sp2.cd_processo_eleitoral
      AND se.sg_ue_uf = sp2.sg_ue_uf
      AND se.sg_ue_mun = sp2.sg_ue_mun
      AND se.nr_zona = sp2.nr_zona
      AND se.nr_secao = sp2.nr_secao
INNER JOIN secao_pleito spp
      ON se.cd_pleito = spp.cd_pleito
      AND se.sg_ue_uf = spp.sg_ue_uf
      AND se.sg_ue_mun = spp.sg_ue_mun
      AND se.nr_zona = spp.nr_zona
      AND se.nr_secao = spp.nr_secao
INNER JOIN ue_processo ue
      ON p.cd_processo_eleitoral = ue.cd_processo_eleitoral
      AND se.sg_ue_uf = ue.sg_ue_superior
      AND se.sg_ue_mun = ue.sg_ue
INNER JOIN secao_tp_cargo_perg st
      ON se.cd_pleito = st.cd_pleito
      AND se.cd_eleicao = st.cd_eleicao
      AND se.sg_ue_uf = st.sg_ue_uf
      AND se.sg_ue_mun = st.sg_ue_mun
      AND se.nr_zona = st.nr_zona
      AND se.nr_secao = st.nr_secao
LEFT JOIN secao_processo sp
     ON p.cd_processo_eleitoral = sp.cd_processo_eleitoral
     AND se.sg_ue_uf = sp.sg_ue_uf
     AND se.sg_ue_mun = sp.sg_ue_mun
     AND se.nr_zona = sp.nr_zona
     AND se.nr_secao = sp.nr_secao_principal
LEFT JOIN secao_agregada_eleicao sa
     ON se.cd_pleito =  sa.cd_pleito
     AND se.cd_eleicao = sa.cd_eleicao
     AND sp.sg_ue_uf = sa.sg_ue_uf
     AND sp.sg_ue_mun = sa.sg_ue_mun
     AND sp.nr_zona = sa.nr_zona --Informado por Acassiane que somente é possível agregar seções da mesma zona.
     AND sp.nr_secao = sa.nr_secao
LEFT JOIN tipo_urna tu
     ON spp.cd_tipo_urna = tu.cd_tipo_urna
LEFT JOIN origem_votos ov
     ON spp.cd_ori_votos = ov.cd_ori_votos
LEFT JOIN tipo_arquivo ta
     ON spp.cd_tipo_arquivo = ta.cd_tipo_arquivo
LEFT JOIN tipo_sistema_apuracao ts
     ON spp.cd_tipo_sistema_apuracao = ts.cd_tipo_sistema_apuracao
     AND spp.cd_tipo_arquivo = ts.cd_tipo_arquivo
GROUP BY se.cd_pleito,
       sa.cd_pleito,
       se.cd_eleicao,
			 e.nm_eleicao,
       sa.cd_eleicao,
       se.sg_ue_uf,
       sp.sg_ue_uf,
       se.sg_ue_mun,
       sp.sg_ue_mun,
       ue.nm_ue,
       se.nr_zona,
       sp.nr_zona,
       se.nr_secao,
       sa.qt_aptos,
       se.qt_aptos,
       sp.nr_secao_principal,
       sa.nr_secao,
       spp.cd_tipo_urna,
       spp.cd_ori_votos,
       spp.dt_desliga_voto_impresso,
       tu.nm_tipo_urna,
       spp.ds_motivo,
       ov.nm_ori_votos,
       ta.nm_tipo_arquivo,
       ts.nm_tipo_sistema_apuracao,
       st.st_comparec_nao_ident,
			 sp2.cd_tipo_local_votacao;
/
