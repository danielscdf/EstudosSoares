package br.jus.tse.educacional.exercicio03;

public class ContaEspecial extends ContaCorrente{
    
	public ContaEspecial(double pValor){
        super(pValor);
    }

    @Override
    public double getTaxaOperacao() {
    	return 0.01;
    }
}
