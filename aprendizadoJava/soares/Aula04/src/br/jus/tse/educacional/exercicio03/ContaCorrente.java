package br.jus.tse.educacional.exercicio03;

public abstract class ContaCorrente {

    private double saldo;
    
    protected ContaCorrente(double pSaldo) {
    	this.saldo=pSaldo;
	}

	protected void sacar(double pValor) {
		this.saldo=this.saldo-(pValor + pValor * getTaxaOperacao());
	}

	protected void depositar(double pValor) {
		this.saldo=this.saldo+pValor;
	}

	protected double saldo() {
	    return this.saldo;
	}
	
	public abstract double getTaxaOperacao();
}
