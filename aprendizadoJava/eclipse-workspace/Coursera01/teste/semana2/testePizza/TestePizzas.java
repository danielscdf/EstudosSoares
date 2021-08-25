package semana2.testePizza;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import semana2.pizza.CarrinhoDeCompras;
import semana2.pizza.Pizza;

public class TestePizzas {

	@Before
	public void setUpBefore() throws Exception {
		Pizza.zeraIngrediente();
		CarrinhoDeCompras.zeraCarrinho();
	}
	
	@Test
	public void testeGetPreco() {
		double precoPizza;
		Pizza pizza1 = new Pizza();
		pizza1.adicionaIngrediente("Calabresa");
		precoPizza = pizza1.getPreco();
		//Teste com 1 ingrediente
		assertEquals(15, precoPizza, 0);
		pizza1.adicionaIngrediente("Queijo");
		pizza1.adicionaIngrediente("Presunto");
		precoPizza = pizza1.getPreco();
		//Teste com 3 ingredientes
		assertEquals(20, precoPizza, 0);
		pizza1.adicionaIngrediente("Ovo");
		pizza1.adicionaIngrediente("Azeitona");
		pizza1.adicionaIngrediente("Salame");
		precoPizza = pizza1.getPreco();
		//Teste com 6 ingredientes
		assertEquals(23, precoPizza, 0);
	}
	@Test
	public void testeIngredientes(){
		Integer totalIngredientes =0;
		Pizza pizza1 = new Pizza();
		pizza1.adicionaIngrediente("Calabresa");
		pizza1.adicionaIngrediente("Queijo");
		pizza1.adicionaIngrediente("Presunto");
		//Valida a quantidade de ingredientes no objeto pizza1
		assertEquals(3, pizza1.ingredientesPizza.size());
		Pizza pizza2 = new Pizza();
		pizza2.adicionaIngrediente("Ovo");
		pizza2.adicionaIngrediente("Queijo");
		//Valida a quantidade de ingredientes no objeto pizza2
		assertEquals(2, pizza2.ingredientesPizza.size());
		//Valida a quantidade de ingredientes no HashMap Static - PS: Queijo tem que somar 2 ingredientes
		for (Integer qtdIngredientes : Pizza.ingredientes.values()) {
			totalIngredientes+=qtdIngredientes;
			}
		assertEquals(5, totalIngredientes, 0);
	}

	@Test
	public void testePrecoTotalCarrinho(){
		CarrinhoDeCompras carrinho = new CarrinhoDeCompras();
		Pizza pizza1 = new Pizza();
		Pizza pizza2 = new Pizza();
		Pizza pizza3 = new Pizza();
		
		//Cria 3 pizzas com ingredientes diferentes
		pizza1.adicionaIngrediente("Atum");
		
		pizza2.adicionaIngrediente("Frango");
		pizza2.adicionaIngrediente("Palmito");
		pizza2.adicionaIngrediente("Atum");
		
		pizza3.adicionaIngrediente("Calabresa");
		pizza3.adicionaIngrediente("Atum");
		pizza3.adicionaIngrediente("Frango");
		pizza3.adicionaIngrediente("Palmito");
		pizza3.adicionaIngrediente("Carne");
		
		//Adiciona essas Pizzas em um CarrinhoDeCompra
		carrinho.adicionarPizzaCarrinho(pizza1);
		carrinho.adicionarPizzaCarrinho(pizza2);
		carrinho.adicionarPizzaCarrinho(pizza3);
		
		assertEquals(55, carrinho.getValorTotal(), 0);
	}

	@Test
	public void testePizzaSemIngredienteCarrinho(){
		CarrinhoDeCompras carrinho = new CarrinhoDeCompras();
		//Cria 1 pizza sem ingredientes
		Pizza pizza1 = new Pizza();
		//Cria 1 pizza com ingredientes
		Pizza pizza2 = new Pizza();
		pizza2.adicionaIngrediente("Frango");
		pizza2.adicionaIngrediente("Palmito");
		pizza2.adicionaIngrediente("Atum");
		
		//Adiciona as Pizzas no Carrinho De Compra
		carrinho.adicionarPizzaCarrinho(pizza1);
		carrinho.adicionarPizzaCarrinho(pizza2);
		
		//Valida a quantidade de pizzas no carrinho
		assertEquals(1, carrinho.getQtdPizzas(), 0);
	}
}
