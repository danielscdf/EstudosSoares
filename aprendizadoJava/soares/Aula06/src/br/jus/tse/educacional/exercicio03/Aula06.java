package br.jus.tse.educacional.exercicio03;

import java.util.*;

import javax.swing.JOptionPane;

public class Aula06 {
	public static void main(String[] args) {
		String titulo = "Agenda telefônica";
		String msg1 = "Digite o nome";
		String msg2 = "Digite o telefone";
		String nomePesquisa;
		boolean encontrado;
		int contador;
		boolean continua = true;
		ArrayList<Agenda> agendas = new ArrayList<Agenda>();
		
		for (int j = 0; j < 5; j++) {
			Agenda agenda = new Agenda();
			String input = JOptionPane.showInputDialog(null, msg1, titulo, JOptionPane.QUESTION_MESSAGE);
			agenda.setNome(input);
			String input2 = JOptionPane.showInputDialog(null, msg2, titulo, JOptionPane.QUESTION_MESSAGE);
			Integer telefone = new Integer(input2);
			agenda.setTelefone(telefone);
			agendas.add(agenda);
		}
		while (continua) {
			String input = JOptionPane.showInputDialog(null, "Selecione a opção\n1- Listar Contatos\n2- Buscar Contato Nome\n3- Buscar Contato Telefone\n4- Remover Contato\n5- Informar Qtd Contatos\n6- Sair", titulo, JOptionPane.QUESTION_MESSAGE);
			Iterator<Agenda> itAgenda = agendas.iterator();
			encontrado = false;
			switch (input) {
			case "1":
				Agenda agenda = new Agenda();
				String contatos = "";
				while (itAgenda.hasNext()) {
					agenda = itAgenda.next();
					contatos = contatos + agenda.getNome() + " - " + agenda.getTelefone() + "\n";
				}
				JOptionPane.showMessageDialog(null, contatos); //showMessageDialog(null, contatos, titulo, JOptionPane.OK_OPTION);
				break;
			case "2":
				nomePesquisa = JOptionPane.showInputDialog("Digite o nome a ser pesquisado");
				while (itAgenda.hasNext()) {
					agenda = itAgenda.next();
					if (agenda.getNome().equals(nomePesquisa)) {
						JOptionPane.showMessageDialog(null, "Nome: " + agenda.getNome() + "\nTelefone: " + agenda.getTelefone());
						encontrado = true;
						break;
					}
				}
				if (!encontrado) {
					JOptionPane.showMessageDialog(null, "Nome " + nomePesquisa + "não encontrado");
				}
				break;
			case "3":
				String telefonePesquisa = JOptionPane.showInputDialog("Digite o telefone a ser pesquisado");
				while (itAgenda.hasNext()) {
					agenda = itAgenda.next();
					if (agenda.getTelefone() == new Integer(telefonePesquisa)) {
						JOptionPane.showMessageDialog(null, "Nome: " + agenda.getNome() + "\nTelefone: " + agenda.getTelefone());
						encontrado = true;
						break;
					}
				}
				if (!encontrado) {
					JOptionPane.showMessageDialog(null, "Telefone " + telefonePesquisa + "não encontrado");
				}
				break;
			case "4":
				nomePesquisa = JOptionPane.showInputDialog("Digite o nome a ser apagado");
				while (itAgenda.hasNext()) {
					agenda = itAgenda.next();
					if (agenda.getNome().equals(nomePesquisa)) {
						itAgenda.remove();
						JOptionPane.showMessageDialog(null, "Nome: " + agenda.getNome() + " apagado!");
						encontrado = true;
						break;
					}
				}
				if (!encontrado) {
					JOptionPane.showMessageDialog(null, "Nome " + nomePesquisa + "não encontrado");
				}
				break;
			case "5":
				contador = 0;
				while (itAgenda.hasNext()) {
					agenda = itAgenda.next();
					contador++;
					}
				JOptionPane.showMessageDialog(null, "Agenda possui " + Integer.toString(contador) + " registros!");
				break;
			case "6":
				continua = false;
				break;
			default:
				continua = false;
				break;
			}
		}
	}
}
