package br.jus.tse.educacional.aula05;

import javax.swing.JOptionPane;

public class CarroJOption {

	public static void main(String[] args) {
		int custoFabrica = 0;
		double custoDistribuidor = 1.28;
		double custoImpostos = 1.45;
		String titulo = "Questionamento";

		String msg1 = "Digite o custo da fabrica:";
		String input = JOptionPane.showInputDialog(null, msg1, titulo, JOptionPane.QUESTION_MESSAGE);
		custoFabrica = (new Integer(input));

		JOptionPane.showMessageDialog(null,
				"O custo total para o consumidor eh " + custoFabrica * custoDistribuidor * custoImpostos);

	}

}
