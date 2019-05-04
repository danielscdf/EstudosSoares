package br.jus.tse.educacional.exercicio03;

import java.util.Scanner;

public class Aula04 {

	private static ContaCorrente conta;

	public static void main(String[] args) {

		String opcao;
		boolean sair = false;
		double valor;
		Scanner scan = new Scanner(System.in);

		while (!sair) {
			System.out.println(
					"Selecione a opção \n1- Criar conta comum\n2- Criar conta especial\n3- Depositar\n4- Sacar\n5- Obter saldo\n6- Sair");
			opcao = scan.next();
			// Limpar Tela
			for (int i = 0; i < 50; ++i)
				System.out.println();

			switch (opcao) {
			case "1":
				conta = new ContaComum(100);
				break;
			case "2":
				conta = new ContaEspecial(100);
				break;
			case "3":
				// Limpar Tela
				for (int i = 0; i < 50; ++i)
					System.out.println();
				
				System.out.println("Valor a depositar");
				valor = scan.nextDouble();
				conta.depositar(valor);
				break;
			case "4":
				// Limpar Tela
				for (int i = 0; i < 50; ++i)
					System.out.println();
				System.out.println("Valor a sacar");
				valor = scan.nextDouble();
				if (conta.saldo() < valor) {
					System.out.println("Informar um valor igual ou menos o saldo");
				}else {
					conta.sacar(valor);
				}
				break;
			case "5":
				System.out.println("Saldo é de: " + conta.saldo());
				break;
			case "6":
				sair = true;
				break;
			default:
				System.out.println("Opção Inválida!");
			}
		}
		scan.close();
	}
}
