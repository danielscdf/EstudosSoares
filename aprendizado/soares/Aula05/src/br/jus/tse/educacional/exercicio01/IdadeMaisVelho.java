package br.jus.tse.educacional.exercicio01;

import java.util.Scanner;

public class IdadeMaisVelho {
	
	public static void main(String[] args) {
		int[] idades = new int[3];
		int rec;
		String[] nomes = new String[3];
		Scanner scan = new Scanner(System.in);
		for (int i = 0; i < 3; i++) {
			System.out.println("Digite o nome ");
			nomes[i] = scan.next();
			System.out.println("Digite a idade ");
			idades[i] = scan.nextInt();
		}
		scan.close();
		if (idades[0] > idades[1] & idades[0] > idades[2]) {
			rec = 0;
		}else if (idades[1] > idades[0] & idades[1] > idades[2]) {
			rec = 1;
		}else {
			rec = 2;
		}
			System.out.println(nomes[rec] + " é o mais velho com "+ idades[rec] + " anos!");
	}
}
