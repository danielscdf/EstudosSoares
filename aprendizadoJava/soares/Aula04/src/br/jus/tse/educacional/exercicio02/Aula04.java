package br.jus.tse.educacional.exercicio02;

import java.util.ArrayList;
import java.util.Date;
import java.util.Scanner;

public class Aula04 {
	
	public static void main(String[] args) {
		String opcao;
		String o;
		boolean sair = false;
		String nomeEmpresa;
		String nomeDepartamento;
		String cnpj;
		String nomeFuncionario;
		Date data = new Date();
		float salario;
		ArrayList<Empresa> empresas = new ArrayList<Empresa>();
		Scanner scan = new Scanner(System.in);
		while (!sair) {
			System.out.println("Selecione a opção \n1- Cadastrar Empresa\n2- Listar Empresas\n3- Aumento 10% Funcionários de um departamento\n4- Transferir funcionario\n5- Sair");
			opcao = scan.next();
			//Limpar Tela
			for (int i = 0; i < 50; ++i)
			    System.out.println ();
			switch(opcao){
			case "1":
				boolean continua = true;
				
				System.out.println("Digite o nome da empresa\n");
				nomeEmpresa = scan.next();
				System.out.println("Digite o CNPJ da empresa\n");
				cnpj = scan.next();
				Empresa emp = new Empresa();
				emp.setNomeEmpresa(nomeEmpresa);
				emp.setCnpj(cnpj);
				empresas.add(emp);
	
				while (continua) {
					System.out.println("Digite o nome de um departamento\n");
					Departamento departamento = new Departamento(scan.next());
					
					while (continua) {
						System.out.println("Digite o nome do funcionario\n");
						nomeFuncionario = scan.next();
						System.out.println("Digite o salário do funcionario\n");
						salario = scan.nextFloat();
						Funcionario funcionario = new Funcionario(nomeFuncionario, salario, data);
						departamento.setFuncionario(funcionario);
						System.out.println("Deseja cadastrar outro funcionario?(S/N)\n");
						o = scan.next();
						if (o.equals("S")) {
							continua = true;
						}else {
							continua = false;
						}
					}
					empresas.get(empresas.indexOf(emp) ).setDepartamento(departamento);
					System.out.println("Deseja cadastrar outro departamento?(S/N)\n");
					o = scan.next();
					if (o.equals("S")) {
						continua = true;
					}else {
						continua = false;
					}
				}
				break;
			case "2":
				//Limpar Tela
				for (int i = 0; i < 50; ++i)
				    System.out.println ();
				for (int i = 0; i < empresas.size(); i++) {
					empresas.get(i).listaEmpresa();
				}
				break;
			case "3":
				System.out.println("Digite o nome da empresa\n");
				nomeEmpresa = scan.next();
				for (int i = 0; i < empresas.size(); i++) {
					if (empresas.get(i).getNomeEmpresa().equals(nomeEmpresa)) {
						for (int j = 0; j < empresas.get(i).getDepartamento().size(); j++) {
							empresas.get(i).getDepartamento().get(j).listaDepartamento();
						}
						System.out.println("Digite o nome do departamento que terá 10% de aumento\n");
						nomeDepartamento = scan.next();
						for (int j = 0; j < empresas.get(i).getDepartamento().size(); j++) {
							if (empresas.get(i).getDepartamento().get(j).getNomeDepartamento().equals(nomeDepartamento)) {
								empresas.get(i).getDepartamento().get(j).ajusteSalarial(10);
							}
						}						
					}
				}
				break;
			case "4":
				System.out.println("Digite o nome da empresa\n");
				nomeEmpresa = scan.next();
				
				for (Empresa empresa : empresas) {
					if (empresa.getNomeEmpresa().equals(nomeEmpresa)) {
						for (Departamento departamento : empresa.getDepartamento()) {
							departamento.listaDepartamento();
						}
						System.out.println("Digite o nome do departamento que terá o funcionário remanejado\n");
						nomeDepartamento = scan.next();
						System.out.println("Digite o nome do funcionário a ser remanejado\n");
						nomeFuncionario = scan.next();

						Departamento departamento = empresa.buscaDepartamentoNome(nomeDepartamento);

						Funcionario funcionario = departamento.buscaFuncionarioNome(nomeFuncionario);

						departamento.remFuncionario(funcionario);
						System.out.println("Digite o nome do departamento que o funcionário será remanejado\n");
						nomeDepartamento = scan.next();
						departamento = empresa.buscaDepartamentoNome(nomeDepartamento);
						departamento.setFuncionario(funcionario);
					}
				}
				break;
			case "5":
				sair = true;
				break;
			default:
				System.out.println("Opção Inválida!");
			}
		}
		scan.close();
	}
}
