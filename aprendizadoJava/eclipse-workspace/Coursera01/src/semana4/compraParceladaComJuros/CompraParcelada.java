package semana4.compraParceladaComJuros;

public class CompraParcelada extends Compra {
	private int qtdParcelas;
	private double jurosMensal;

	public CompraParcelada(double valorCompra, int qtdParcelas, double jurosMensal) {
		super(valorCompra);
		this.qtdParcelas = qtdParcelas;
		this.jurosMensal = jurosMensal/100;
	}

	public double total() {
		return super.getValorCompra() * Math.pow((1 + this.jurosMensal), this.qtdParcelas);
	}

}
