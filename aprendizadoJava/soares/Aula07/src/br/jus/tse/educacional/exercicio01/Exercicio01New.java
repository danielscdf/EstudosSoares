package br.jus.tse.educacional.exercicio01;

public class Exercicio01New {
	public static void main(String[] args) {
		Exercicio01New ex = new Exercicio01New();
		
	}
	
	private void imprimirHierarquia(Object obj){
		imprimirHierarquiaComTudo(obj.getClass());
	}
	
	private void imprimirHierarquia(Class classe){
		if (classe != null) {
			System.out.println(classe);
			imprimirHierarquia(classe.getSuperclass());
		}
	}
	
	private void imprimirHierarquiaComTudo(Class classe){
		if (classe != null) {
			System.out.println(classe);
			
		}
	}
}
