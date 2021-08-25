package semana4.testeBanco;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import semana4.banco.ContaEspecial;

public class TesteContaEspecial extends TesteContaCorrente{

	@Before
	public void inicializaConta() {
		conta1 = new ContaEspecial(100);
		conta1.depositar(200);
	}
	
	@Test
	public void testeSacaValorMaior() {
		int valorSacado = conta1.sacar(350);
		assertEquals(0, valorSacado);
		assertEquals(200, conta1.getSaldo());
	}

	@Test
	public void testeSacaValorMaiorSaldoDentroLimite() {
		int valorSacado = conta1.sacar(250);
		assertEquals(250, valorSacado);
		assertEquals(-50, conta1.getSaldo());
	}

}
