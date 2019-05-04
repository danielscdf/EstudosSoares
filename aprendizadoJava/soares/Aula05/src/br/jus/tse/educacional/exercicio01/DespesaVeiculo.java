package br.jus.tse.educacional.exercicio01;

public class DespesaVeiculo {
	private float custoFabrica;
	private float percentualDistribuidor = 0.28f;
	private float percentualImposto = 0.45f;
	public float getCustoFabrica() {
		return custoFabrica;
	}
	public void setCustoFabrica(float custoFabrica) {
		this.custoFabrica = custoFabrica;
	}
	public float getPercentualDistribuidor() {
		return percentualDistribuidor;
	}
	public void setPercentualDistribuidor(float percentualDistribuidor) {
		this.percentualDistribuidor = percentualDistribuidor;
	}
	public float getPercentualImposto() {
		return percentualImposto;
	}
	public void setPercentualImposto(float percentualImposto) {
		this.percentualImposto = percentualImposto;
	}
	public float retornaCustoConsumidor(){
		float valor;
		valor = this.custoFabrica + this.custoFabrica*(this.percentualDistribuidor) + this.custoFabrica*(this.percentualImposto);
		return valor;
	}
}
