package semana1;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

public class TesteCarroMult {
	CarroDeCorrida c;

	@Before
	public void inicializaCarro() {
		c = new CarroMult("Teste", 1.5, 100);
	}

	@Test
	public void testeAcelerarUmaVez() {
		c.acelerar();
		assertEquals(10, c.getVelocidade(), 0);
	}

	@Test
	public void testeAcelerarDuasVezes() {
		c.acelerar();
		c.acelerar();
		assertEquals(15, c.getVelocidade(),0);
	}

	@Test
	public void testeAcelerarAteVelocidadeMaxima() {
		for (int i = 0; i < 14; i++) {
			c.acelerar();
		}
		assertEquals(100, c.getVelocidade(), 0);
	}

	@Test
	public void testeCarroParado() {
		assertEquals(0, c.getVelocidade(), 0);
	}

	@Test
	public void testeFrear() {
		c.acelerar();
		c.frear();
		assertEquals(5, c.getVelocidade(), 0);
	}

	@Test
	public void testeFrearAteZero() {
		c.acelerar();
		c.frear();
		c.frear();
		c.frear();
		c.frear();
		assertEquals(0, c.getVelocidade(), 1);
	}


}
