package semana4.banco;

public class ContaCorrente {
	int saldo;
	
	public int sacar(int valor) {
		if(saldo<valor) {
			return 0;
		}else {
			this.saldo-=valor;
			return valor;
		}
	}

	public void depositar(int valor) {
		this.saldo+=valor;
	}
	
	public int getSaldo() {
		return this.saldo;
	}
}
