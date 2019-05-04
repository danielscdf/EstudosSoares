package br.jus.tse.educacional.exercicio01;

public class Consulta {
private String historico;
public String getHistorico() {
	return historico;
}
public void setHistorico(String historico) {
	this.historico = historico;
}
public void RegistrarConsulta() {
	System.out.println("Consulta registrada.");

}
public void RecuperarHistoricoConsulta() {
	System.out.println("Consulta recuperada.");

}
}
