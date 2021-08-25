package semana1;

public class Principal {

	public static void main(String[] args) {
		CarroDeCorrida c1 = new CarroSoma(10,100,"Corcel");
		
		c1.acelerar();
		c1.acelerar();
		c1.acelerar();
		c1.frear();
		c1.imprimir();
	}

}
