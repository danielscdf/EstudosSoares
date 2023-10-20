CREATE OR REPLACE VIEW vw_085_exp_log_geral_sistema
AS
SELECT l.cd_processo_eleitoral,
       l.cd_pleito,
       l.cd_eleicao,
			 l.sg_ue_uf,
			 l.nr_zona,
			 l.nr_junta,
			 l.tp_perfil,
			 to_char(l.dt_log_hor_loc, 'DD/MM/YYYY HH24:MI:SS') dt_log_hor_loc,
			 l.dt_log_hor_tse,
			 l.cd_usuario,
			 l.cd_tipo_log_sistema,
			 tl.nm_tipo_log_sistema,
			 l.tx_log
FROM Log_Geral_Sistema l
INNER JOIN tipo_log_sistema tl
      ON l.cd_tipo_log_sistema = tl.cd_tipo_log_sistema;