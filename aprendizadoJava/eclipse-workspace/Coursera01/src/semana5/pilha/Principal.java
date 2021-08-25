package semana5.pilha;

public class Principal {

	public static void main(String[] args) {
		Pilha p = new Pilha(10);
		p.empilhar("Eduardo");
		p.empilhar("Maria");
		p.empilhar("José");
		System.out.println(p.topo()+" : "+p.tamanho());
		
		//Object[] arrayElementos = p.getElementos();
		Object[] arrayElementos = new Object[10];
		arrayElementos = p.getElementos();
		arrayElementos[1] = "OUTRO";
		
		System.out.println(p.desempilhar());
		System.out.println(p.topo()+" : "+p.tamanho());
	}

}
