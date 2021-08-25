package semana5.concurso;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Principal {

	public static void main(String[] args) {
		
		List<Candidato> lista = new ArrayList<>();
		lista.add(new Candidato(80, true, 30));
		lista.add(new Candidato(80, false, 25));
		lista.add(new Candidato(80, true, 28));
		lista.add(new Candidato(80, false, 28));
		lista.add(new Candidato(90, false, 28));
		Candidato cand = lista.get(0);
		char[] teste = {'a', 'b', 'c', 'd'};
		System.out.println(new String (teste));
		cand.setTeste(teste);
		lista.set(0, cand);
		
		Collections.sort(lista);
		
		for(Candidato c : lista) {
			System.out.println(c);
		}
	}

}
