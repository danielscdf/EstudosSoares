package br.jus.tse.educacional.exercicio02;

import java.util.ArrayList;

public class Empresa {
	private String nomeEmpresa;
	private String cnpj;
	private ArrayList<Departamento> departamento = new ArrayList<Departamento>();


	public String getNomeEmpresa() {
		return nomeEmpresa;
	}

	public void setNomeEmpresa(String nomeEmpresa) {
		this.nomeEmpresa = nomeEmpresa;
	}

	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	public void setDepartamento(Departamento departamento) {
		this.departamento.add(departamento);
	}

	public ArrayList<Departamento> getDepartamento() {
		return departamento;
	}

	public void setDepartamento(ArrayList<Departamento> departamento) {
		this.departamento = departamento;
	}
	
	public Departamento buscaDepartamentoNome(String nomeDepartamento){
		for (int i = 0; i < this.departamento.size(); i++) {
			if (this.departamento.get(i).getNomeDepartamento().equals(nomeDepartamento)) {
				return this.departamento.get(i);
			}
		}
		return null;
	}

	public void listaEmpresa(){

        System.out.println("Empresa: " + this.getNomeEmpresa());
        
		for(int i=0; i < departamento.size(); i++){

            departamento.get(i).listaDepartamento();
        }
    }
}
