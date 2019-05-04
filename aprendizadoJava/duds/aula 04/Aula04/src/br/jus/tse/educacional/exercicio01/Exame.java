package br.jus.tse.educacional.exercicio01;

public class Exame extends Servico {
	private String medidaPreventiva;
	private String tipoExame;

	public String getMedidaPreventiva() {
		return medidaPreventiva;
	}

	public void setMedidaPreventiva(String medidaPreventiva) {
		this.medidaPreventiva = medidaPreventiva;
	}

	public void setTipoExame(String tipoExame) {
		this.tipoExame = tipoExame;
	}

	public String getTipoExame() {
		return tipoExame;
	}
}
