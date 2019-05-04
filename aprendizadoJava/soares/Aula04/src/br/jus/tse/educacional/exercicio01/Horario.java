package br.jus.tse.educacional.exercicio01;

import java.util.Date;

public class Horario {
	private Date data = new Date();
	private String hora;
	private Consulta consulta;
	public Consulta getConsulta() {
		return consulta;
	}

	public void setConsulta(Consulta consulta) {
		this.consulta = consulta;
	}

	public Agenda getAgenda() {
		return agenda;
	}

	public void setAgenda(Agenda agenda) {
		this.agenda = agenda;
	}

	private Agenda agenda;
		
	public Date getData() {
		return data;
	}
	
	public void setData(Date data) {
		this.data = data;
	}
	
	public String getHora() {
		return hora;
	}
	
	public void setHora(String hora) {
		this.hora = hora;
	}
	
	private void obterHorariosDisponiveis() {
		System.out.println("Obter Hor�rios Dispon�veis");
	}
	
	private void alterarDisponibilidadeHorario() {
		System.out.println("Alterar Disponibilidade de Hor�rio");
	}
}
