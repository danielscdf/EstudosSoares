package br.jus.tse.educacional.exercicio02;

public class SqFibonacci2 extends SequenciaFibonacci{
	int calculaFibonacci2(int posicao){
		return calculaFibonacci(posicao-2);
	}
}
