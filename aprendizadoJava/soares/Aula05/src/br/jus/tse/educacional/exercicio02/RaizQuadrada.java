package br.jus.tse.educacional.exercicio02;

import javax.swing.JOptionPane;

public class RaizQuadrada {
	public static void main(String[] args) {
	    double total;
	    String titulo = "Calcula raiz quadrada";
	    String msg1 = "Digite um número";

		String input = JOptionPane.showInputDialog(null, msg1, titulo, JOptionPane.QUESTION_MESSAGE);
		
		Double numero = new Double(input);
		
		total = Math.sqrt(numero);
		JOptionPane.showMessageDialog(null, "Raiz quadrada de "+ numero + " é: " + total);
	}
}
