package br.jus.tse.educacional.exercicio03;

public class ContaComum extends ContaCorrente {

    protected ContaComum(double pSaldo) {
		super(pSaldo);
	}

	@Override
	public double getTaxaOperacao() {
		return 0.05;
	}
}
