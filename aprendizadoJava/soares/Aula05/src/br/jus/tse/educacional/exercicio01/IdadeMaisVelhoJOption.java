package br.jus.tse.educacional.exercicio01;

import java.util.Scanner;

import javax.swing.JOptionPane;

public class IdadeMaisVelhoJOption {
	public static void main(String[] args) {
		Pessoa[] pessoa = new Pessoa[3];
		int rec;
		String titulo = "Calcula mais velho";
		String msg1 = "Digite o nome";
		String msg2 = "Digite a idade";
		Scanner scan = new Scanner(System.in);
		for (int i = 0; i < 3; i++) {
			pessoa[i] = new Pessoa();
			String input = JOptionPane.showInputDialog(null, msg1, titulo, JOptionPane.QUESTION_MESSAGE); 
			pessoa[i].setNome(input);
			String input2 = JOptionPane.showInputDialog(null, msg2, titulo, JOptionPane.QUESTION_MESSAGE);
			//idade = scan.nextInt();
			Integer idade = new Integer(input2);
			pessoa[i].setIdade(idade);
		}
		scan.close();
		if (pessoa[0].getIdade() > pessoa[1].getIdade() & pessoa[0].getIdade() > pessoa[2].getIdade()) {
			rec = 0;
		}else if (pessoa[1].getIdade() > pessoa[0].getIdade() & pessoa[1].getIdade() > pessoa[2].getIdade()) {
			rec = 1;
		}else {
			rec = 2;
		}
		JOptionPane.showMessageDialog(null, pessoa[rec].getNome() + " é o mais velho com "+ pessoa[rec].getIdade() + " anos!");	
	}
}
