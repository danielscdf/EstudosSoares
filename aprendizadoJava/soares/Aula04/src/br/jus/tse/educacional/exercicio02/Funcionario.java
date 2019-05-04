package br.jus.tse.educacional.exercicio02;

import java.util.Date;

public class Funcionario {
	private String nome;

	private double salario;

	private Date dataAdmissao;

	public Funcionario(String pNome, double pSalario, Date pdataAdmissao) {

		this.nome = pNome;

		this.salario = pSalario;

		this.dataAdmissao = pdataAdmissao;

	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public double getSalario() {
		return salario;
	}

	public void setSalario(double salario) {
		this.salario = salario;
	}

	public Date getDataAdmissao() {
		return dataAdmissao;
	}

	public void setData(Date dataAdmissao) {
		this.dataAdmissao = dataAdmissao;
	}
	public void reajuste(double percentual) {
		double sal = 1+percentual/100;
		sal = this.getSalario() * sal;
		this.setSalario(sal);

	}
	public void listaFuncionario(){

        System.out.println("Funcionario: " + this.getNome());

        System.out.println("Data de admissão:"+ this.getDataAdmissao());

        System.out.println("“Salario:"+ this.getSalario());
    }
}
