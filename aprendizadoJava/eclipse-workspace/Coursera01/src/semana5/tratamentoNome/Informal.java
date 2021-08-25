package semana5.tratamentoNome;

public class Informal implements FormatadorNome {

	@Override
	public String formatarNome(String nome, String sobrenome) {
		return nome.trim();
	}

}
