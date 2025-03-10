package semana5.tratamentoNome;

public class ComTitulo implements FormatadorNome {
	private String titulo;
	

	public ComTitulo(String titulo) {
		super();
		this.titulo = titulo;
	}

	@Override
	public String formatarNome(String nome, String sobrenome) {
		return titulo.trim()+" "+nome.trim()+" "+sobrenome.trim();
	}

}
