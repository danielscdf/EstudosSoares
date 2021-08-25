package semana5.pilha;

import java.util.Arrays;

public class Pilha {
	private Object[] elementos;
	private int topo = 0;
	
	public Pilha(int maximo) {
		elementos = new Object[maximo];
	}
	
	public void empilhar(Object elemento) {
		elementos[topo] = elemento;
		topo++;
	}
	
	public Object desempilhar() {
		topo--;
		return elementos[topo];
	}
	
	public Object topo() {
		return elementos[topo-1];
	}
	
	public int getTopo() {
		return topo;
	}

	public void setElementos(Object[] elementos) {
		this.elementos = elementos;
	}

	public int tamanho() {
		return topo;
	}
	
	public Object[] getElementos() {
		Object[] arrayElementos = Arrays.copyOf(elementos, getTopo());
		return arrayElementos;
	}
}
