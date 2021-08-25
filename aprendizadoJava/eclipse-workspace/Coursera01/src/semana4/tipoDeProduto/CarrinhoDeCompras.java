package semana4.tipoDeProduto;

import java.util.HashMap;

public class CarrinhoDeCompras {
	public HashMap<Produto, Integer> produtos = new HashMap<Produto, Integer>();

	public void adicionaProduto(Produto prd, int quantidade) {
		if (produtos.get(prd) == null) {
			produtos.put(prd, quantidade);
		} else {
			produtos.computeIfPresent(prd, (k, v) -> v + quantidade);
		}
	}

	public void removeProduto(Produto prd, int quantidade) {
		if (produtos.get(prd) == null || produtos.get(prd) < quantidade) {
			return;
			//System.out.println(
			//		"Produto inexistente ou a quantidade para remover é maior que a quantidade existente para o produto!");
		} else if (produtos.get(prd) == quantidade) {
			produtos.remove(prd);
		} else {
			produtos.computeIfPresent(prd, (k, v) -> v - quantidade);
		}
	}

	public double valorTotalCompra() {
		double valorTotal = 0;
		for (Produto produto : produtos.keySet()) {
			valorTotal += (produto.getPreco()*produtos.get(produto));
		}
		return valorTotal;
	}
	/*
	 * Outra forma de validar com método hashCode e Equals, porém não foi necessário pois a forma acima funcionou.
	 * 
	public void adicionaProduto(Produto prd, int quantidade) {
	  if (produtos.isEmpty()) {
		produtos.put(prd, quantidade);
	} else {
		for (Produto produto : produtos.keySet()) {
			if (produto.equals(prd) && produto.hashCode() == prd.hashCode()) {
				produtos.computeIfPresent(prd, (k, v) -> v + quantidade);
				return;
			}
		}
		produtos.put(prd, quantidade);
	}*/
}
