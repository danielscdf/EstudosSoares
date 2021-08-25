package pkg;
public class Compra {
	int valorTotal;
	int numeroParcelas;
	
	public Compra(int valor) {
		valorTotal = valor;
		numeroParcelas = 1;
	}

	public Compra(int qtdParcelas, int valorParcela) {
		numeroParcelas = qtdParcelas;
		valorTotal = numeroParcelas * valorParcela;
	}

	public int getValorTotal() {
		return valorTotal;
	}

	public int getNumeroParcelas() {
		return numeroParcelas;
	}
	
	public int getVarlorParcela() {
		return valorTotal / numeroParcelas;
	}
}
