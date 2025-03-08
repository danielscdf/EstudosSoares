/* Formatted on 12/11/2020 10:40:38 (QP5 v5.252.13127.32847) */
CREATE OR REPLACE VIEW vw_085_exp_resumo_votacao_uf
AS
SELECT s.cd_pleito,
       s.cd_eleicao,
			 s.sg_ue_uf,
			 s.cd_tipo_cargo_pergunta,
			 s.qt_comparecimento qtd_comparecimento,
			 s.qt_abstencao qtd_abstencao,
			 s.qt_aptos_apurados + s.qt_aptos_nao_apurados qt_aptos_secoes_func,
			 s.qt_aptos_apurados qtd_aptos_apurados,
       s.qt_aptos_nao_apurados qtd_aptos_nao_apurados,
       s.qt_aptos_urnas_nao_instaladas qtd_aptos_urnas_nao_instaladas,
       s.qt_secoes_totalizadas qtd_secoes_totalizadas,
       s.qt_secoes_nao_totalizadas qtd_secoes_nao_tot,
       s.qt_secoes_nao_apuradas + s.qt_secoes_apuradas qtd_secoes_func,
			 s.qt_secoes_apuradas qtd_secoes_apuradas,
			 s.qt_secoes_nao_apuradas qtd_secoes_nao_apuradas,
			 s.qt_secoes_nao_instaladas qtd_secoes_nao_instaladas
FROM ft_secoes_uf s;