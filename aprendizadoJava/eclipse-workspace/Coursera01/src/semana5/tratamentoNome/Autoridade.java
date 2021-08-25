package semana5.tratamentoNome;

public class Autoridade{
	private String nome;
	private String sobrenome;
	private FormatadorNome formataNome;

	public Autoridade(String nome, String sobrenome, FormatadorNome formataNome) {
		super();
		this.nome = nome;
		this.sobrenome = sobrenome;
		this.formataNome = formataNome;
	}

	public String getTratamento() {
		return formataNome.formatarNome(nome, sobrenome);
	}

}
