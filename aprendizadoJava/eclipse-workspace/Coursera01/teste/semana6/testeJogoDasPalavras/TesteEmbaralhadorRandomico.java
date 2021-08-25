package semana6.testeJogoDasPalavras;

import static org.junit.Assert.*;

import org.junit.Test;

import semana6.jogoDasPalavras.EmbaralhadorRandomico;

public class TesteEmbaralhadorRandomico {

	@Test
	public void testEmbaralhar() {
		EmbaralhadorRandomico embaralha = new EmbaralhadorRandomico();
		assertNotEquals("abcdefg", embaralha.embaralhar("abcdefg"));
	}

}
