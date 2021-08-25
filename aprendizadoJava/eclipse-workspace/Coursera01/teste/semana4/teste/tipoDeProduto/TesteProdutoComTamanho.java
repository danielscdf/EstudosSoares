package semana4.teste.tipoDeProduto;

import org.junit.Before;

import semana4.tipoDeProduto.ProdutoComTamanho;

public class TesteProdutoComTamanho extends TesteProduto {

	@Before
	public void inicializaProdutos() {
		prod1 = new ProdutoComTamanho("Produto1", 100, 1.99, 41);
		prod2 = new ProdutoComTamanho("Produto2", 100, 4.50, 39);
		prod3 = new ProdutoComTamanho("Produto3", 100, 2.99, 41);
	}

}
