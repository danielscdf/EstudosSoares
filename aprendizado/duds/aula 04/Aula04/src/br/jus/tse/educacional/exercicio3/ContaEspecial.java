package br.jus.educacional.exercicio3;

public class ContaEspecial extends Conta {

    public ContaEspecial(double pValor){

        super(pValor);

    }

    @Override

    public void Sacar(double pValor){

        saldo=saldo-(pValor + pValor*0.01);

    }

}