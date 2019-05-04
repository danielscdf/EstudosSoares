package br.jus.educacional.exercicio2;

public class Departamento {

	protected String Nome;

	protected Funcionario Func[];

	private int QtdeFunc = 0;

	public Departamento(String pNome) {

		this.Nome = pNome;

		this.Func = new Funcionario[100];

	}

	public void AdicionarFunc(String pNome, double pSalario, String pData) {

		Func[QtdeFunc] = new Funcionario(pNome, pSalario, pData);

		QtdeFunc++;

	}

	public void AjusteSalarial(int pPorc) {

		for (int i = 0; i < QtdeFunc; i++) {

			Func[i].Reajuste(pPorc);

		}

	}

	public void ListaFunc(){

        for(int i=0;i<QtdeFunc;i++){

            System.out.println("Funcionario: " + Func[i].Nome);

            System.out.println("Data de admissão:"+ Func[i].Data);

            System.out.println("“Salario:"+ Func[i].Salario);

        }

    }

}