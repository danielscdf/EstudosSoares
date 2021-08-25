package semana1;

public class CarroMult extends CarroDeCorrida {
	private double potencia;

	public CarroMult(String nome, double potencia, int velocidadeMaxima) {
		super(nome, velocidadeMaxima);
		if(potencia > 1 && potencia < 2) {
			this.potencia = potencia;
		}else {
			this.potencia = 1.5;
		}
	}

	@Override
	public void acelerar() {
		if(this.velocidade==0) {
			this.velocidade=10;
		}else {
			this.velocidade*=potencia;
		}
		if(this.velocidade > this.velocidadeMaxima) {
			this.velocidade = this.velocidadeMaxima;
		}

	}

}
