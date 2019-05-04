package br.jus.tse.educacional.exercicio02;

import java.util.ArrayList;
import java.util.Date;

public class Departamento {
	private String nomeDepartamento;

	//private Funcionario[] funcionario = new Funcionario[100];
	private ArrayList<Funcionario> funcionario = new ArrayList<Funcionario>();

	public String getNomeDepartamento() {
		return nomeDepartamento;
	}

	public void setNomeDepartamento(String nomeDepartamento) {
		this.nomeDepartamento = nomeDepartamento;
	}


	public ArrayList<Funcionario> getFuncionario() {
		return funcionario;
	}

	public void setFuncionario(ArrayList<Funcionario> funcionario) {
		this.funcionario = funcionario;
	}
	
	public void setFuncionario(Funcionario funcionario) {
		this.funcionario.add(funcionario);
	}
	
	public void remFuncionario(Funcionario funcionario){
		this.funcionario.remove(funcionario);
	}
	
	public Departamento(String pNome) {
		this.nomeDepartamento = pNome;
	}

	public void adicionarFunc(String pNome, double pSalario, Date pData) {
		Funcionario func = new Funcionario(pNome, pSalario, pData);
		funcionario.add(func);
	}

	public void ajusteSalarial(int pPorc) {
		for (int i = 0; i < this.funcionario.size(); i++) {
			funcionario.get(i).reajuste(pPorc);
		}
	}
	
	public Funcionario buscaFuncionarioNome(String nomeFuncionario){
		for (int i = 0; i < funcionario.size(); i++) {
			if (funcionario.get(i).getNome().equals(nomeFuncionario)) {
				return funcionario.get(i);
			}
		}
		return null;
	}

	public void listaDepartamento(){

            System.out.println("Departamento: " + this.getNomeDepartamento());
            if (funcionario.size() > 0 ) {
            	for (int i = 0; i < funcionario.size(); i++) {
					funcionario.get(i).listaFuncionario();
				}
			}
    }
}
