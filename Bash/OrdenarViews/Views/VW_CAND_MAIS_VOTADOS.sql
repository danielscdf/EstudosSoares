CREATE OR REPLACE VIEW vw_cand_mais_votados
AS
      SELECT v.cd_pleito,
             v.cd_eleicao,
             v.sg_ue,
             v.sg_ue_uf,
             v.nr_votavel,
             SUM(NVL(vm.qt_votos_totalizados, 0)) qt_votos,
             cd.sq_classificacao,
             v.cd_cargo_pergunta,
             c.sq_candidato,
             c.sq_drap
        FROM desempate cd,
             candidato c,
             votavel v,
             voto_mun_zona vm
       WHERE v.sg_ue = vm.sg_ue(+)
         AND v.cd_cargo_pergunta = vm.cd_cargo_pergunta(+)
         AND v.sg_ue_uf = DECODE(v.sg_ue_uf, 'BR', v.sg_ue_uf, vm.sg_ue_uf(+))
         AND c.sg_ue = v.sg_ue
         AND c.cd_eleicao = v.cd_eleicao
         AND c.cd_pleito = v.cd_pleito
         AND c.cd_cargo = v.cd_cargo_pergunta
         AND c.nr_cand = v.nr_votavel
         AND c.sg_ue_uf = v.sg_ue_uf
         AND c.sg_ue = cd.sg_ue(+)
         AND c.cd_cargo = cd.cd_cargo_pergunta(+)
         AND c.nr_cand = cd.nr_votavel(+)
         AND c.cd_eleicao = cd.cd_eleicao(+)
         AND c.cd_pleito = cd.cd_pleito(+)
         AND c.sg_ue_uf = cd.sg_ue_uf(+)
         AND c.st_substituido = 'N'
         AND vm.nr_votavel(+) = v.nr_votavel
         AND v.cd_tipo_votavel = 1
         AND v.cd_tipo_votavel_destinacao = 1
         AND vm.cd_eleicao(+) = v.cd_eleicao
         AND vm.cd_eleicao(+) = c.cd_eleicao
         AND vm.cd_pleito(+) = v.cd_pleito
    GROUP BY v.cd_pleito,
             v.cd_eleicao,
             v.sg_ue,
             v.sg_ue_uf,
             v.nr_votavel,
             cd.sq_classificacao,
             v.cd_cargo_pergunta,
             c.sq_candidato,
             c.sq_drap
    ORDER BY qt_votos DESC, cd.sq_classificacao;
