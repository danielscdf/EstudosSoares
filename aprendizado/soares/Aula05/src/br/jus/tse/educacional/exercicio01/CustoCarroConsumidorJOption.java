package br.jus.tse.educacional.exercicio01;

import javax.swing.JOptionPane;

public class CustoCarroConsumidorJOption {
	public static void main(String[] args) {
		DespesaVeiculo despesa = new DespesaVeiculo();
	    Float total;
	    String titulo = "Calcula custo carro";
	    String msg1 = "Digite o custo de fábrica";

		String input = JOptionPane.showInputDialog(null, msg1, titulo, JOptionPane.QUESTION_MESSAGE);
		Float custo = new Float(input);		
		despesa.setCustoFabrica(custo);
		
		total = despesa.retornaCustoConsumidor();
		
		JOptionPane.showMessageDialog(null, "Valor carro é"+ total);
	}
}
