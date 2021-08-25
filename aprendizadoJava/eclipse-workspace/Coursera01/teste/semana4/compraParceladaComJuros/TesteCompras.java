package semana4.compraParceladaComJuros;

import static org.junit.Assert.*;

import org.junit.Test;

public class TesteCompras {

	@Test
	public void testParcela1() {
		Compra compra1 = new CompraParcelada(99.99, 1, 1);
		assertEquals(100.98, compra1.total(), 0.1);
	}

	@Test
	public void testParcela2() {
		Compra compra1 = new CompraParcelada(99.99, 2, 1);
		assertEquals(101.99, compra1.total(), 0.1);
	}

	@Test
	public void testParcela5() {
		Compra compra1 = new CompraParcelada(35000, 5, 1.7);
		assertEquals(38077.8842, compra1.total(), 0.1);
	}

	@Test
	public void testParcela10() {
		Compra compra1 = new CompraParcelada(35000, 10, 1.7);
		assertEquals(41426.4361, compra1.total(), 0.1);
	}

}
