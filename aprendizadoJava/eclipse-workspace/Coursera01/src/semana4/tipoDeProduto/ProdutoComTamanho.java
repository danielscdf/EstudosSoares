package semana4.tipoDeProduto;

public class ProdutoComTamanho extends Produto {

	private int tamanho;

	public ProdutoComTamanho(String nome, int codigo, double preco, int tamanho) {
		super(nome, codigo, preco);
		this.tamanho = tamanho;
	}

	public int getTamanho() {
		return tamanho;
	}

	public void setTamanho(int tamanho) {
		this.tamanho = tamanho;
	}

	@Override
	public boolean equals(Object o) {
		if ((o instanceof ProdutoComTamanho) && (this.getCodigo() == (((ProdutoComTamanho) o).getCodigo()))
				&& (this.getTamanho() == (((ProdutoComTamanho) o).getTamanho()))) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return this.getCodigo() * 100 * this.getTamanho();
	}

}
