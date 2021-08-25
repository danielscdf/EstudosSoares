package semana4.banco;

public class ContaEspecial extends ContaCorrente{
	int limite;
	
	public ContaEspecial(int limite){
		this.limite=limite;
	}
	
	public int sacar(int valor) {
		if((saldo+limite)<valor) {
			return 0;
		}else {
			this.saldo-=valor;
			return valor;
		}
	}
}
