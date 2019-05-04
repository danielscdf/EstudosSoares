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
	
	public String getTipoExame() {
		return tipoExame;
	}
	
	public void setTipoExame(String tipoExame) {
		this.tipoExame = tipoExame;
	}
}
