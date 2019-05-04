package br.jus.tse.educacional.exercicio01;

import java.util.Date;

public class Paciente {
	
	private String nome;
	private Integer rg;
	private String endereco;
	private Integer telefone;
	private Date dataDeNascimento = new Date();
	private String profissao;
	private Agenda agenda;
	
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public String getNome() {
		return nome;
	}
	
	public void setRg(Integer rg) {
		this.rg = rg;
	}
	
	public Integer getRg() {
		return rg;
	}
	
	public String getEndereco() {
		return endereco;
	}
	
	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}
	
	public Integer getTelefone() {
		return telefone;
	}
	
	public void setTelefone(Integer telefone) {
		this.telefone = telefone;
	}
	
	public Date getDataDeNascimento() {
		return dataDeNascimento;
	}
	
	public void setDataDeNascimento(Date dataDeNascimento) {
		this.dataDeNascimento = dataDeNascimento;
	}
	
	public String getProfissao() {
		return profissao;
	}
	
	public void setProfissao(String profissao) {
		this.profissao = profissao;
	}

	public void verificarPacienteCadastrado(){
		System.out.println("Verificar paciente cadastrado.");
	}
	
	public void adicionarPaciente() {
		System.out.println("Adicionar paciente.");
	}
	
	public void obterPaciente() {
		System.out.println("Obter paciente");
	}
	
	public void obterConsulta() {
		System.out.println("Obter Consulta");

	}
	
	public void adicionarConsulta() {
		System.out.println("Adicionar Consulta");
	}
	
	public void localizarPaciente() {
		System.out.println("Localizar Paciente");
	}
	
	public void cadastrarPaciente() {
		System.out.println("Cadastrar Paciente");
	}
}
