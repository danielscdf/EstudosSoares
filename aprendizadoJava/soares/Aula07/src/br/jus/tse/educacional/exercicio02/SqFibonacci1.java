package br.jus.tse.educacional.exercicio02;

public class SqFibonacci1 extends SequenciaFibonacci implements Runnable{
	int calculaFibonacci1(int posicao){
		return calculaFibonacci(posicao-1);
	}
	@Override
	public void run() {
		
		
	}
}
