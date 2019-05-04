package br.jus.tse.educacional.exercicio02;

public class SequenciaFibonacci implements Runnable{

	int calculaFibonacci(int posicao) {
		return (posicao<=2 ? 1 : calculaFibonacci1(posicao) + calculaFibonacci2(posicao));
	}

}
