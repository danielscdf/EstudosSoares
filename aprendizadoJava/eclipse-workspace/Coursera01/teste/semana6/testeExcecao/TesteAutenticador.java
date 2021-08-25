package semana6.testeExcecao;

import static org.junit.Assert.*;

import java.util.Scanner;

import org.junit.Test;

import semana6.excecao.Usuario;
import semana6.excecao.Autenticador;
import semana6.excecao.LoginException;

public class TesteAutenticador {

	@Test
	public void loginComSucesso() throws LoginException {
		//System.out.println("Digite o nome do usuário:");
		//Scanner inNome = new Scanner(System.in);
		String nome = "guerra";//inNome.nextLine();
		Autenticador a = new Autenticador();
		Usuario u = a.logar(nome, "senhaDoGuerra");
		assertEquals("guerra", u.getLogin());
	}

	@Test(expected = LoginException.class)
	public void loginFalha() throws LoginException {
		Autenticador a = new Autenticador();
		Usuario u = a.logar("guerra", "senhaErradaDoGuerra");
	}

	@Test
	public void informacaoDoErro() throws LoginException {
		Autenticador a = new Autenticador();
		try {
			Usuario u = a.logar("guerra", "senhaErradaDoGuerra");
			fail();
		} catch (LoginException e) {
			assertEquals("guerra", e.getLogin());
		}
	}

}
