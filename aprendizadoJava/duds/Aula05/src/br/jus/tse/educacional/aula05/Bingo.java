package br.jus.tse.educacional.aula05;

import java.util.Arrays;

import javax.swing.JOptionPane;

public class Bingo {
	public static void main(String[] args) {
		int[] cartela = new int[5];
		int[] sorteio = new int[5];
		int qtdSorteado = 0;

		String titulo = "Java Bingo";
		String cartelaTela = "";
		String sorteioTela = "";
		int valor;

		for (int i = 0; i < sorteio.length; i++) {
			String msg1 = "Digite um numero";
			String input = JOptionPane.showInputDialog(null, msg1, titulo, JOptionPane.QUESTION_MESSAGE);
			int numero = (new Integer(input));
			cartela[i] = numero;
			valor = (int) (Math.random() * 10);
			sorteio[i] = valor;

		}

		Arrays.sort(cartela);
		Arrays.sort(sorteio);

		for (int i = 0; i < cartela.length; i++) {
			cartelaTela = cartelaTela + " " + cartela[i];
			sorteioTela = sorteioTela + " " + sorteio[i];

			for (int j = 0; j < sorteio.length; j++) {
				if (cartela[i] == sorteio[j]) {
					qtdSorteado++;

				}

			}

		}

		JOptionPane.showMessageDialog(null, "Sua Cartela é " + cartelaTela + " \nNumeros sorteados:" + sorteioTela
				+ " \nVoce acertou " + qtdSorteado + " números");
	}
}
