package semana6.excecao;

public class LoginException extends Exception {
	
	private String login;

	public String getLogin() {
		return login;
	}

	public LoginException(String message, String login) {
		super(message);
		this.login = login;
	}

}
