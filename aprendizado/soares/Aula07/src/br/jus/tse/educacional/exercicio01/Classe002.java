package br.jus.tse.educacional.exercicio01;

public class Classe002 extends Classe001{
	private int atributoB;

	public int getAtributoB() {
		return atributoB;
	}

	public void setB(int atributoB) {
		this.atributoB = atributoB;
	}
	
	public static int soma(int a, int b){
		return a + b;
	}
	public static void main(String[] args) {
		Classe002 teste = new Classe002();
		teste.setAtributoA(8);
		teste.setB(2);
		System.out.println("Soma = " + soma(teste.getAtributoA(), teste.getAtributoB()));
	}
}
