package br.jus.tse.educacional.exercicio01;

import java.util.Scanner;

public class IdadePessoaMaisVelho {
	public static void main(String[] args) {
		Pessoa[] pessoa = new Pessoa[3];
		int rec;
		String nome;
		int idade;
		Scanner scan = new Scanner(System.in);
		for (int i = 0; i < 3; i++) {
			pessoa[i] = new Pessoa();
			System.out.println("Digite o nome ");
			nome = scan.next();
			pessoa[i].setNome(nome);
			System.out.println("Digite a idade ");
			idade = scan.nextInt();
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
			System.out.println(pessoa[rec].getNome() + " é o mais velho com "+ pessoa[rec].getIdade() + " anos!");
	}
}
