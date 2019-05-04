package br.jus.educacional.exercicio2;

public class Empresa {

	protected String Nome;

	protected String CNPJ;

	protected Departamento Depto[];

	private int QtdDepto = 0;

	public Empresa(String pNome, String pCNPJ) {

		this.Nome = pNome;

		this.CNPJ = pCNPJ;

		this.Depto = new Departamento[10];

	}

	public void AdicionaDepto(String pNome) {

		Depto[QtdDepto] = new Departamento(pNome);

		QtdDepto++;

	}

	public void ListaDepto(){

        for(int i=0; i<QtdDepto; i++){

            System.out.println("Nome do departamento: "+ Depto[i].Nome);

            Depto[i].ListaFunc();

        }

    }

}