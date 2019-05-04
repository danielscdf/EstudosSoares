package br.jus.tse.educacional.exercicio01;

import java.util.ArrayList;

public class Servico {
	private String descricao;
	private Float preco;
	private ArrayList<Consulta> Consulta;
	
	public String getDescricao() {
		return descricao;
	}
	
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	public Float getPreco() {
		return preco;
	}
	
	public void setPreco(Float preco) {
		this.preco = preco;
	}
	
	public void registrarServico() {
		System.out.println("Registrar Serviço");

	}
	
	public void recuperarServico() {
		System.out.println("Recuperar Serviço");
	}
}
