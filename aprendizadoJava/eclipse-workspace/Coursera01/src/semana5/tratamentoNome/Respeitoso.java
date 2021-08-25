package semana5.tratamentoNome;

public class Respeitoso implements FormatadorNome {
	private boolean sexoMasculino;
	final private String abreviaturaTratamentoMasculino = "Sr.";
	final private String abreviaturaTratamentoFeminino = "Sra.";

	
	public Respeitoso(boolean sexoMasculino) {
		super();
		this.sexoMasculino = sexoMasculino;
	}

	@Override
	public String formatarNome(String nome, String sobrenome) {
		if (this.sexoMasculino){
			return abreviaturaTratamentoMasculino+sobrenome.trim();
		}else {
			return abreviaturaTratamentoFeminino+sobrenome.trim();
		}
	}

}
