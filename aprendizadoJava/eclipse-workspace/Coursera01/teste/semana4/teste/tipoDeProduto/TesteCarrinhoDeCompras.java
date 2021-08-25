package semana4.teste.tipoDeProduto;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import semana4.tipoDeProduto.CarrinhoDeCompras;
import semana4.tipoDeProduto.Produto;
import semana4.tipoDeProduto.ProdutoComTamanho;

public class TesteCarrinhoDeCompras {
	Produto prodComT1, prodComT2, prodComT3, prodSemT1, prodSemT2, prodSemT3;
	CarrinhoDeCompras carrinho = new CarrinhoDeCompras();
	
	@Before
	public void inicializaProdutos() {
		prodComT1 = new ProdutoComTamanho("ProdutoC1", 100, 1.50, 41);
		prodComT2 = new ProdutoComTamanho("ProdutoC2", 100, 4.50, 39);
		prodComT3 = new ProdutoComTamanho("ProdutoC3", 100, 1.50, 41);
		prodSemT1 = new Produto("ProdutoS1", 100, 1.50);
		prodSemT2 = new Produto("ProdutoS2", 200, 4.50);
		prodSemT3 = new Produto("ProdutoS3", 100, 1.50);
	}
	
	@Test
	public void testAdicionaProduto() {
		carrinho.adicionaProduto(prodSemT1, 4);
		carrinho.adicionaProduto(prodSemT2, 5);
		carrinho.adicionaProduto(prodSemT3, 6);
		carrinho.adicionaProduto(prodComT1, 1);
		carrinho.adicionaProduto(prodComT2, 2);
		carrinho.adicionaProduto(prodComT3, 3);
		assertEquals(4, carrinho.produtos.size(), 0);
	}

	@Test
	public void testRemoveProdutoQuantidade() {
		carrinho.adicionaProduto(prodSemT1, 4);
		carrinho.adicionaProduto(prodSemT2, 5);
		carrinho.adicionaProduto(prodSemT3, 6);
		carrinho.adicionaProduto(prodComT1, 1);
		carrinho.adicionaProduto(prodComT2, 2);
		carrinho.adicionaProduto(prodComT3, 3);
		carrinho.removeProduto(prodSemT1, 6);
		assertEquals(4, carrinho.produtos.get(prodSemT1), 0);
	}
	
	@Test
	public void testRemoveProdutoObjeto() {
		carrinho.adicionaProduto(prodSemT1, 4);
		carrinho.adicionaProduto(prodSemT2, 5);
		carrinho.adicionaProduto(prodSemT3, 6);
		carrinho.adicionaProduto(prodComT1, 1);
		carrinho.adicionaProduto(prodComT2, 2);
		carrinho.adicionaProduto(prodComT3, 3);
		carrinho.removeProduto(prodSemT1, 10);
		assertTrue(carrinho.produtos.get(prodSemT1)==null);
	}

	@Test
	public void testRemoveProdutoMaiorPermitido() {
		carrinho.adicionaProduto(prodSemT1, 4);
		carrinho.adicionaProduto(prodSemT2, 5);
		carrinho.adicionaProduto(prodSemT3, 6);
		carrinho.adicionaProduto(prodComT1, 1);
		carrinho.adicionaProduto(prodComT2, 2);
		carrinho.adicionaProduto(prodComT3, 3);
		carrinho.removeProduto(prodSemT1, 11);
		assertEquals(10, carrinho.produtos.get(prodSemT1), 0);
	}
	
	@Test
	public void testvalorTotalCompra() {
		carrinho.adicionaProduto(prodSemT1, 4);
		carrinho.adicionaProduto(prodSemT2, 5);
		carrinho.adicionaProduto(prodSemT3, 6);
		carrinho.adicionaProduto(prodComT1, 1);
		carrinho.adicionaProduto(prodComT2, 2);
		carrinho.adicionaProduto(prodComT3, 3);
		assertEquals(52.5, carrinho.valorTotalCompra(), 0);
	}
}
