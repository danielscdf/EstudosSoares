package br.jus.tse.educacional.exercicio01;

import java.util.ArrayList;

public class Consulta {
	public Integer historico;
	private ArrayList<Servico> servico;
	public ArrayList<Servico> getServico() {
		return servico;
	}

	public void setServico(ArrayList<Servico> servico) {
		this.servico = servico;
	}

	public ArrayList<Horario> getHorario() {
		return horario;
	}

	public void setHorario(ArrayList<Horario> horario) {
		this.horario = horario;
	}

	private ArrayList<Horario> horario;
	
	public Integer getHistorico() {
		return historico;
	}
	
	public void setHistorico(Integer historico) {
		this.historico = historico;
	}
	
	public void registrarConsulta() {
		System.out.println("Registra Consulta");
	}
	
	public void recuperaHistoricoConsulta() {
		System.out.println("Recupera Historico Consulta");
	}
}
