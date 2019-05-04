package br.jus.tse.educacional.exercicio02;

import javax.swing.JOptionPane;

public class MenorMaiorNumeroVetor {
	public static void main(String[] args) {
		int[] numeros = new int[5];
		String titulo = "Bingo";
		String msg1 = "Digite um numero";
		
		for (int i = 0; i < numeros.length; i++) {
			String input = JOptionPane.showInputDialog(null, msg1, titulo, JOptionPane.QUESTION_MESSAGE);
			numeros[i] = new Integer(input);
		}
		System.out.println("Maior Número: " + MaiorNumeroVetor(numeros));
		System.out.println("Menor Número: " + MenorNumeroVetor(numeros));
	}
	
	public static int MenorNumeroVetor(int[] numeros){
		int valor = numeros[0];
		for (int i = 0; i < numeros.length; i++) {
			if (i > 0) {
				if (numeros[i] < valor) {
					valor = numeros[i];
				}
			}
		}
		return valor;
	}
	public static int MaiorNumeroVetor(int[] numeros){
		int valor = numeros[0];
		for (int i = 0; i < numeros.length; i++) {
			if (i > 0) {
				if (numeros[i] > valor) {
					valor = numeros[i];
				}
			}
		}
		return valor;
	}
}
