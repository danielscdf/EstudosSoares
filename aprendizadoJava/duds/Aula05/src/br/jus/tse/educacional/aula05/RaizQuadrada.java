package br.jus.tse.educacional.aula05;

import javax.swing.JOptionPane;

public class RaizQuadrada {

	public static void main(String[] args) {
		String titulo = "Raiz Quadrada";
		String msg1 = "Digite o n�mero:";
		String input = JOptionPane.showInputDialog(null, msg1, titulo, JOptionPane.QUESTION_MESSAGE);
		int raizQuadrada = (new Integer(input));
		
		//double resposta = Math.sqrt(raizQuadrada);
		JOptionPane.showMessageDialog(null,
				"A raiz quadrada � "+  Math.sqrt(raizQuadrada));
		


	}

}
