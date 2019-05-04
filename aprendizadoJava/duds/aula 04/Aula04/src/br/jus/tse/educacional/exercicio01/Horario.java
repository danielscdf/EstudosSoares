package br.jus.tse.educacional.exercicio01;

import java.util.Date;

public class Horario {
	private Date data = new Date();
	private String hora;
	
	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}
	public void setHora(String hora) {
		this.hora = hora;
	}
	public String getHora() {
		return hora;
	}
	public void ObterHorariosDisponiveis() {
		System.out.println("Horarios disponiveis.");

	}
	public void AlterarDisponibilidadeHorario() {
		System.out.println("Horario Alterado.");

	}
}
