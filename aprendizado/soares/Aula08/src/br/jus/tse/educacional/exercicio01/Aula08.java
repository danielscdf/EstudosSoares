package br.jus.tse.educacional.exercicio01;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Aula08 {
	public static void main(String[] args) {
		String uf;
		List<Localidade> locais = new ArrayList<Localidade>();
		Localidade local = new Localidade();
		List<String> ufs = new ArrayList<String>();
		
		Scanner scan = new Scanner(System.in);
		System.out.println("Digite a UF ");
		
		uf = scan.next();
		locais = local.buscarLocalidadesUFs(uf);
		for (int i = 0; i < locais.size(); i++) {
			local = locais.get(i);
			System.out.println(local.getLocalidade());
		}
		scan.close();
	}
}
