package br.jus.tse.educacional.exercicio01;

import java.util.Date;
import java.util.ArrayList;

public class Paciente {

	private String nome;
	private Integer rg;
	private String endereco;
	private Integer telefone;
	private Date nascimento;
	private String profissao;
	private ArrayList<Agenda> agenda;

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public Integer getRg() {
		return rg;
	}

	public void setRg(Integer rg) {
		this.rg = rg;
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

	public Date getNascimento() {
		return nascimento;
	}

	public void setNascimento(Date nascimento) {
		this.nascimento = nascimento;
	}

	public String getProfissao() {
		return profissao;
	}

	public void setProfissao(String profissao) {
		this.profissao = profissao;
	}

	public ArrayList<Agenda> getAgenda() {
		return agenda;
	}

	public void setAgenda(ArrayList<Agenda> agenda) {
		this.agenda = agenda;
	}

	public void VerificarPacienteCadastrado() {
		System.out.println("Paciente Verificado.");
	}

	public void AdicionarPaciente(String nome, Integer rg, String endereco, Date nascimento, String profissao) {
		setEndereco(endereco);
		setNascimento(nascimento);
		setNome(nome);
		setRg(rg);
		setProfissao(profissao);
		System.out.println("Paciente Adicionado.");
	}
	public void ObterPaciente() {
		System.out.println("Paciente Obtido.");

	}
	public void ObterConsulta() {
		System.out.println("Consulta Adicionada.");

	}
	public void AdicionarConsulta() {
		// TODO Auto-generated method stub

	}
	public void LocalizarPaciente() {
		// TODO Auto-generated method stub

	}
	public void CadastrarPaciente() {
		// TODO Auto-generated method stub

	}
}
