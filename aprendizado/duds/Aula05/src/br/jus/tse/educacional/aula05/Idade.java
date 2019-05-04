package br.jus.tse.educacional.aula05;

import java.util.Scanner;

public class Idade {

	public static void main(String[] args) {
		Usuario[] users = new Usuario[3];

		Scanner scanner = new Scanner(System.in);
		for (int i = 0; i < 3; i++) {
			Usuario userX = new Usuario();
			
			System.out.println("Digite a sua idade:");
			userX.setIdade(scanner.nextInt());
			
			System.out.println("Digite o seu Nome:");
			userX.setNome(scanner.next());
			
			// salvo no array
			users[i] = userX;

		}

		// comparacao de idades
		int idade = 0;
		String nome = "";
		for (int i = 0; i < users.length; i++) {
			if (users[i].getIdade() > idade) {
				idade = users[i].getIdade();
				nome = users[i].getNome();
			} // if
		} // for
		System.out.println("O usuario mais velho tem " + idade + " anos e se chama " + nome);
		scanner.close();
	}

}
