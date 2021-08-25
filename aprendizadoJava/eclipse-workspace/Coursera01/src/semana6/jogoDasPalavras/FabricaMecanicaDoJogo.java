package semana6.jogoDasPalavras;

import java.util.Random;

public class FabricaMecanicaDoJogo {
	public MecanicaDoJogo retornaMecanica(String palavraSecreta) {
		Random r = new Random();
		int numeroRandomico = r.nextInt(2) + 1;
		switch (numeroRandomico) {
		case 1:
			return new MecanicaDoJogoMelhor3Palavras(palavraSecreta);
		case 2:
			return new MecanicaDoJogoPontuacao3Erros(palavraSecreta);
		default:
			return new MecanicaDoJogoMelhor3Palavras(palavraSecreta);
		}
	}
}
