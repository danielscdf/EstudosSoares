package semana2.pizza;

public class CarrinhoDeCompras {
	private static double valorTotal;
	private static int qtdPizzas;
	public void adicionarPizzaCarrinho(Pizza pizza) {
		if(pizza.ingredientesPizza.size() > 0) {
			valorTotal+=pizza.getPreco();
			qtdPizzas+=1;
		}
	}
	public double getValorTotal() {
		return valorTotal;
	}
	public int getQtdPizzas() {
		return qtdPizzas;
	}
	public static void zeraCarrinho() {
		valorTotal=0;
		qtdPizzas=0;
	}
}
