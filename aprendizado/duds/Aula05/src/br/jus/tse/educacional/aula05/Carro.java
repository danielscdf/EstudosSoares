package br.jus.tse.educacional.aula05;

import java.util.Scanner;

public class Carro {

	public static void main(String[] args) {
		int custoFabrica;
		double custoDistribuidor = 1.28;
		double custoImpostos = 1.45;

		Scanner scanner = new Scanner(System.in);
		System.out.println("Digite o custo da fabrica:");
		custoFabrica = scanner.nextInt();
		
		System.out.println("O custo total para o consumidor eh "+custoFabrica*custoDistribuidor*custoImpostos);
		scanner.close();
	}

}
