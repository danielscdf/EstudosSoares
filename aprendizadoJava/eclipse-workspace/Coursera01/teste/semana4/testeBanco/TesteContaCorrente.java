package semana4.testeBanco;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import semana4.banco.ContaCorrente;

public class TesteContaCorrente {

	ContaCorrente conta1;
	
	@Before
	public void inicializaConta() {
		conta1 = new ContaCorrente();
		conta1.depositar(200);
	}
	
	@Test
	public void testeDeposito() {
		assertEquals(conta1.getSaldo(), 200);
	}

	@Test
	public void testeSacar() {
		int valorSacado = conta1.sacar(50);
		assertEquals(50, valorSacado);
		assertEquals(150, conta1.getSaldo());
	}

	@Test
	public void testeSacaValorMaior() {
		int valorSacado = conta1.sacar(250);
		assertEquals(0, valorSacado);
		assertEquals(200, conta1.getSaldo());
	}

}
