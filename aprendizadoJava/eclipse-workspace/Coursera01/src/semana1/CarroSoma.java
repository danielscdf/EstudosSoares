package semana1;

public class CarroSoma extends CarroDeCorrida{
	private int potencia;
	public CarroSoma(int potencia, int velocidadeMaxima, String nome) {
		super(nome, velocidadeMaxima);
		this.potencia = potencia;
	}

	@Override
	public void acelerar() {
		velocidade += potencia;
		if(this.velocidade > this.velocidadeMaxima) {
			this.velocidade = this.velocidadeMaxima;
		}
	}
}
