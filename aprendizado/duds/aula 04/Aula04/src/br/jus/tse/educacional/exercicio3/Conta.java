package br.jus.educacional.exercicio3;

public class Conta {

    protected double saldo;

    public Conta(double pSaldo){

       saldo=pSaldo;

    }

    public void Sacar(double pValor){

        saldo=saldo-(pValor + pValor*0.05);

    }

    public void Depositar(double pValor){

        saldo=saldo+pValor;

    }

    public double Saldo(){

        return saldo;

    }

}