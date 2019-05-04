package br.jus.tse.educacional.exercicio01;

public class LimpezaRestauracao extends Servico {
	private String materialUsado;
	private String denteTratado;

	public String getMaterialUsado() {
		return materialUsado;
	}

	public void setMaterialUsado(String materialUsado) {
		this.materialUsado = materialUsado;
	}

	public String getDenteTratado() {
		return denteTratado;
	}

	public void setDenteTratado(String denteTratado) {
		this.denteTratado = denteTratado;
	}
}
