package semana1;

public class PrincipalCorrida {

	public static void main(String[] args) {
		Corrida corridaDaAmizade = new Corrida(2000);
		corridaDaAmizade.adicionaCarro(new CarroSoma(10, 110, "CarroA"));
		corridaDaAmizade.adicionaCarro(new CarroSoma(8, 140, "CarroB"));
		corridaDaAmizade.adicionaCarro(new CarroMult("CarroC", 1.7, 100));
		corridaDaAmizade.adicionaCarro(new CarroMult("CarroD", 1.4, 110));
		corridaDaAmizade.umDoisTresEJa();
	}

}
