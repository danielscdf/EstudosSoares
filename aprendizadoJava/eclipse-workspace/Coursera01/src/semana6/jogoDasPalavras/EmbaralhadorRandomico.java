package semana6.jogoDasPalavras;

import java.util.Random;

public class EmbaralhadorRandomico implements Embaralhador {

	@Override
	public String embaralhar(String palavra) {
		char letraAntiga;
		char[] palavraRandomica;
		String novaPalavra = "";
		Random r = new Random();
		palavraRandomica = palavra.toCharArray();
		
		for(int i=0;i<5;i++) {
			int numeroRandomico = r.nextInt(palavra.length()-1);
			letraAntiga = palavraRandomica[numeroRandomico];
			palavraRandomica[numeroRandomico] = palavraRandomica[palavra.length()-1];
			palavraRandomica[palavra.length()-1] = letraAntiga;
		}
		novaPalavra = String.valueOf(palavraRandomica);
		return novaPalavra;
	}

}
