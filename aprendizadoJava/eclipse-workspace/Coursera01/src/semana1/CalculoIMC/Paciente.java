package semana1.CalculoIMC;

public class Paciente {
	private double peso;
	private double altura;

	public Paciente(double Peso, double Altura) {
		peso=Peso;
		altura=Altura;
	}
	public double calcularIMC() {
		double imc;
		imc = this.peso/(this.altura*this.altura);
		return imc;
	}
	public String diagnostico() {
		double valorImc;
		valorImc = calcularIMC();
		if (valorImc < 16) {
			return "Baixo peso muito grave";
		} else if(valorImc >= 16 & valorImc <= 16.99) {
			return "Baixo peso grave";
		} else if(valorImc >= 17 & valorImc < 18.49) {
			return "Baixo peso";
		} else if(valorImc >= 18.50 & valorImc < 24.99) {
			return "Peso normal";
		} else if(valorImc >= 25 & valorImc < 29.99) {
			return "Sobrepeso";
		} else if(valorImc >= 30 & valorImc < 34.99) {
			return "Obesidade grau I";
		} else if(valorImc >= 35 & valorImc < 39.99) {
			return "Obesidade grau II";
		} else if(valorImc >= 40) {
			return "Obesidade grau III (obesidade mórbida)";
		} else {
			return "IMC não mapeado";
		}

	}
}
