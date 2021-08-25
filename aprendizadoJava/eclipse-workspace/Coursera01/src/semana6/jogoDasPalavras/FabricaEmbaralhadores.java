package semana6.jogoDasPalavras;

import java.util.Random;

public class FabricaEmbaralhadores {
	public Embaralhador retornaEmbaralhador() {
		Random r = new Random();
		int numeroRandomico = r.nextInt(2) + 1;
		switch (numeroRandomico) {
		case 1:
			return new EmbaralhadorRandomico();
		case 2:
			return new EmbaralhadorInvertido();
		default:
			return new EmbaralhadorRandomico();
		}
	}
}
