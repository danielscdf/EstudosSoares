package br.jus.tse.educacional.exercicio01;

import java.util.ArrayList;

public class Agenda {
	
	private Integer ano;
	private ArrayList<Horario> horario;
	private ArrayList<Paciente> paciente;
	
	public Integer getAno() {
		return ano;
	}
	
	public ArrayList<Horario> getHorario() {
		return horario;
	}

	public void setHorario(ArrayList<Horario> horario) {
		this.horario = horario;
	}

	public ArrayList<Paciente> getPaciente() {
		return paciente;
	}

	public void setPaciente(ArrayList<Paciente> paciente) {
		this.paciente = paciente;
	}

	public void setAno(Integer ano) {
		if (ano > 0){
			this.ano = ano;
		}
	}
	
	public void abrirAgenda(){
		System.out.println("Agenda aberta.");
	}
	
	public void resgatarAgendaDia(){
		System.out.println("Agenda do dia.");
	}
	
	public void resgatarAgenda2Dias(){
		System.out.println("Agenda de 2 dias.");
	}
	
	public void resgatarAgendaSemana(){
		System.out.println("Agenda da semana.");
	}
}
