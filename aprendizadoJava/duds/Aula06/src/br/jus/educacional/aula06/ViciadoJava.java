package br.jus.educacional.aula06;

public class ViciadoJava implements Dado {
	
	@Override
	public void jogarDado() {

		lado = (int) (Math.random() * 6) + 1;

	}
	

	public static void main(String[] args) {
		Dado dado1 = new Dado();

		System.out.println( dado1.getLado() );
	}

}
