package semana1;

public abstract class CarroDeCorrida {

	public abstract void acelerar();

	protected double velocidade;
	protected int velocidadeMaxima;
	protected String nome;
	
	public CarroDeCorrida(String nome, int velocidadeMaxima) {
		this.nome = nome;
		this.velocidadeMaxima = velocidadeMaxima;
		this.velocidade = 0;
	}

	public String getNome() {
		return nome;
	}

	public void frear() {
		velocidade = velocidade/2;
	}

	public double getVelocidade() {
		return velocidade;
	}

	public void imprimir() {
		System.out.println("O carro "+ nome +" está a velocidade "+getVelocidade()+"km/h.");
	}

}
