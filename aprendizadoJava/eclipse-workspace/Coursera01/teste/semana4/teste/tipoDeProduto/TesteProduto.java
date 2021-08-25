package semana4.teste.tipoDeProduto;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import semana4.tipoDeProduto.Produto;

public class TesteProduto {
	Produto prod1, prod2, prod3;
	
	@Before
	public void inicializaProdutos() {
		prod1 = new Produto("Produto1", 100, 1.99);
		prod2 = new Produto("Produto2", 200, 4.50);
		prod3 = new Produto("Produto3", 100, 2.99);
	}
	
	@Test
	public void testEquals() {
		assertTrue(prod1.equals(prod3));
		assertFalse(prod1.equals(prod2));
		assertFalse(prod2.equals(prod3));
	}
	
	@Test
	public void testHashCode() {
		assertEquals(prod1.hashCode(), prod3.hashCode(), 0);
		assertNotEquals(prod1.hashCode(), prod2.hashCode(), 0);
		assertNotEquals(prod2.hashCode(), prod3.hashCode(), 0);
	}

}
