package br.jus.educacional.aula06;

public class Dado {

	private int lado;

	public Dado() {

		jogarDado();
	}

	public void jogarDado() {

		lado = (int) (Math.random() * 6) + 1;

	}
	
	public int getLado() {
		return lado;
	}

}