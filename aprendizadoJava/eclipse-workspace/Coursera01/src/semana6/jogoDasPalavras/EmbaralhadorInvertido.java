package semana6.jogoDasPalavras;

public class EmbaralhadorInvertido implements Embaralhador {

	@Override
	public String embaralhar(String palavra) {
		String palavraInvertida = "";
		for (int letra = palavra.length() - 1; letra >= 0; letra--) {
			palavraInvertida += palavra.charAt(letra);
		}
		return palavraInvertida;
	}

}
