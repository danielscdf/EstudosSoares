package br.jus.tse.educacional.exercicio01;

import java.util.ArrayList;

public class Agenda {
	private Integer ano;
	
	private ArrayList<Horario> horario;

	public Integer getAno() {
		return ano;
	}

	public void setAno(Integer ano) {
		if (ano > 0) {
			this.ano = ano;
		}
	}

	public void abrirAgenda() {
		System.out.println("Agenda aberta");
	}

	public void resgatarAgendaDia() {
		System.out.println("Agenda resgatada");
	}
	
	public void setHorario(ArrayList<Horario> horario) {
		this.horario = horario;
	}
	public ArrayList<Horario> getHorario() {
		return horario;
	}
}
