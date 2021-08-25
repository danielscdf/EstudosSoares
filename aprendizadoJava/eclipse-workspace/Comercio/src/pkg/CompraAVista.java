package pkg;
import static org.junit.Assert.*;

import org.junit.Test;

public class CompraAVista {

	@Test
	public void compraAVista() {
		Compra c = new Compra(500);
		assertEquals(1, c.getNumeroParcelas());
		assertEquals(500, c.getValorTotal());
		assertEquals(500, c.getVarlorParcela());
	}

	@Test
	public void compraParcelada() {
		Compra c = new Compra(4, 1000);
		assertEquals(4, c.getNumeroParcelas());
		assertEquals(4000, c.getValorTotal());
		assertEquals(1000, c.getVarlorParcela());
	}
}
