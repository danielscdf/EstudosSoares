package semana4.tipoDeProduto;

public class Produto {
	private String nome;
	private int codigo;
	private double preco;

	public Produto(String nome, int codigo, double preco) {
		super();
		this.nome = nome;
		this.codigo = codigo;
		this.preco = preco;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public int getCodigo() {
		
		return codigo;
	}

	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	public double getPreco() {
		return preco;
	}

	public void setPreco(double preco) {
		this.preco = preco;
	}

	@Override
	public boolean equals(Object o) {
		if ((o instanceof Produto) && (this.getCodigo() == (((Produto) o).getCodigo()))) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return this.getCodigo() * 100;
	}

}
