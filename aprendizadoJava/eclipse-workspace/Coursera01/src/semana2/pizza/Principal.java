package semana2.pizza;

public class Principal {

	public static void main(String[] args) {
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
		
		//Imprime o total do CarrinhoDeCompra
		System.out.println("Valor Total do carrinho de compras: "+carrinho.getValorTotal());
		
		//Imprime a quantidade utilizada de cada ingrediente
		System.out.println("*********Quantidade de ingredientes*********");
		for (String ingrediente : Pizza.ingredientes.keySet()) {
		      System.out.println(ingrediente + " : " + Pizza.ingredientes.get(ingrediente));
		    }
		
		//Imprime os ingredientes de cada Pizza
		System.out.println("*********Quantidade de ingredientes Pizza1*********");
		pizza1.ingredientesPizza.forEach((ingrediente) -> {System.out.println(ingrediente);});
		System.out.println("*********Quantidade de ingredientes Pizza2*********");
		pizza2.ingredientesPizza.forEach((ingrediente) -> {System.out.println(ingrediente);});
		System.out.println("*********Quantidade de ingredientes Pizza3*********");
		pizza3.ingredientesPizza.forEach((ingrediente) -> {System.out.println(ingrediente);});
	}

}
