package semana6.excecao;

public class Autenticador {
	public Usuario logar(String login, String senha) throws LoginException {
		if (login.equals("guerra") && senha.equals("senhaDoGuerra")) {
			return new Usuario(login);
		}
		throw new LoginException("O usuário e/ou a senha não batem!", login);
	}

}
