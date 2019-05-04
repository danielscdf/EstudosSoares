package br.jus.educacional.exercicio2;

public class Funcionario {

	protected String Nome;

	protected double Salario;

	protected String Data;

	public Funcionario(String pNome, double pSalario, String pData) {

		this.Nome = pNome;

		this.Salario = pSalario;

		this.Data = pData;

	}

	public void Reajuste(int pPorc) {

		Salario = Salario + (Salario * pPorc / 100);

	}

}