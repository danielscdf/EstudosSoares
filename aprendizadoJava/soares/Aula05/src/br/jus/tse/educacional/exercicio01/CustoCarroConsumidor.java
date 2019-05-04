package br.jus.tse.educacional.exercicio01;

import java.util.Scanner;

public class CustoCarroConsumidor {
	
	public static void main(String[] args) {
		DespesaVeiculo despesa = new DespesaVeiculo();
	    Float total;

		Scanner scan = new Scanner(System.in);
		
		System.out.println("Digite o custo de fábrica: ");
		
		despesa.setCustoFabrica(scan.nextFloat());
		
		total = despesa.retornaCustoConsumidor();
		
		System.out.println("Valor carro é: "+total);
		
		scan.close();
	}
}
