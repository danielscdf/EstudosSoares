/* Formatted on 11/11/2020 15:28:31 (QP5 v5.252.13127.32847) */
CREATE OR REPLACE VIEW vw_085_exp_votacao_mun
AS
SELECT vm.cd_pleito,
       vm.cd_eleicao,
       vm.sg_ue_uf,
       vm.sg_ue,
       dm.nm_municipio nm_ue,
       dm.sg_ue_mun,
       vm.cd_cargo_pergunta,
       vm.nr_votavel,
       nvl(vt.sq_candidato, DECODE(vt.cd_tipo_cargo_pergunta,3, vt.nr_votavel)) sq_cand_resposta,
       SUM(vm.qt_votos_computados) qt_votos_computados_votavel,
       SUM(vm.qt_votos_totalizados) qt_votos_totalizados_votavel,
       NVL(vt.cd_tipo_votavel_destinacao,tv.cd_tipo_votavel) cd_tipo_votavel_destinacao,
       NVL(vt.nm_tipo_votavel_destinacao,tv.nm_tipo_destinacao_votos) nm_tipo_destinacao_votos
FROM voto_mun_zona vm
LEFT JOIN dm_votavel vt
     ON vt.cd_pleito = vm.cd_pleito
     AND vt.cd_eleicao = vm.cd_eleicao
     AND vt.sg_ue_uf = vm.sg_ue_uf
     AND vt.sg_ue = vm.sg_ue
     AND vt.cd_cargo_pergunta = vm.cd_cargo_pergunta
     AND vt.nr_votavel = vm.nr_votavel
LEFT JOIN tipo_votavel tv
     ON tv.nr_tipo_votavel = vm.nr_votavel
INNER JOIN dm_municipio dm
      ON dm.cd_pleito = vm.cd_pleito
      AND dm.cd_eleicao = vm.cd_eleicao
      AND dm.sg_ue_uf = vm.sg_ue_uf
      AND dm.sg_ue_mun = vm.sg_ue_mun
GROUP BY vm.cd_pleito,
       vm.cd_eleicao,
       vm.sg_ue_uf,
       vm.sg_ue,
       dm.nm_municipio,
       dm.sg_ue_mun,
       vm.cd_cargo_pergunta,
       vm.nr_votavel,
       nvl(vt.sq_candidato, DECODE(vt.cd_tipo_cargo_pergunta,3, vt.nr_votavel)),
       NVL(vt.cd_tipo_votavel_destinacao,tv.cd_tipo_votavel),
       NVL(vt.nm_tipo_votavel_destinacao,tv.nm_tipo_destinacao_votos);