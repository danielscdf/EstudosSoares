package semana6.testeJogoDasPalavras;

import static org.junit.Assert.*;

import org.junit.Test;

import semana6.jogoDasPalavras.EmbaralhadorInvertido;

public class TesteEmbaralhadorInvertido {

	@Test
	public void testEmbaralhar() {
		EmbaralhadorInvertido embaralha = new EmbaralhadorInvertido();
		assertEquals("gfedcba", embaralha.embaralhar("abcdefg"));
	}

}
