package br.jus.tse.educacional.aula05;

import javax.swing.JOptionPane;

public class IdadeJOption {

	public static void main(String[] args) {
		Usuario[] users = new Usuario[3];
		String titulo = "Questionamento";

		//Scanner scanner = new Scanner(System.in);
		for (int i = 0; i < 3; i++) {
			Usuario userX = new Usuario();

			// System.out.println("Digite a sua idade:");
			// userX.setIdade(scanner.nextInt());
			String msg1 = "Digite a sua idade";
			String input = JOptionPane.showInputDialog(null, msg1, titulo, JOptionPane.QUESTION_MESSAGE);
			userX.setIdade(new Integer(input));

			// System.out.println("Digite o seu Nome:");
			// userX.setNome(scanner.next());
			msg1 = "Digite o seu Nome";
			input = JOptionPane.showInputDialog(null, msg1, titulo, JOptionPane.QUESTION_MESSAGE);
			userX.setNome(input);

			// salvo no array
			users[i] = userX;

		}

		// comparacao de idades
		int idade = 0;
		String nome = "";
		for (int i = 0; i < users.length; i++) {
			if (users[i].getIdade() > idade) {
				idade = users[i].getIdade();
				nome = users[i].getNome();
			} // if
		} // for
		//System.out.println("O usuario mais velho tem " + idade + " anos e se chama " + nome);
		JOptionPane.showMessageDialog(null, "O usuario mais velho tem " + idade + " anos e se chama " + nome);
	}

}
