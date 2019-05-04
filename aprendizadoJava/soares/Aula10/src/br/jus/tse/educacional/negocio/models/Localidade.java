package br.jus.tse.educacional.negocio.models;

public class Localidade extends Uf{
	private Integer nuLocalidade;
	private Uf uf;
	private String noLocalidade;
	private boolean capital;
	
	public Integer getNuLocalidade() {
		return nuLocalidade;
	}
	public void setNuLocalidade(Integer nuLocalidade) {
		this.nuLocalidade = nuLocalidade;
	}
	public Uf getUf() {
		return uf;
	}
	public void setUf(Uf uf) {
		this.uf = uf;
	}
	public String getNoLocalidade() {
		return noLocalidade;
	}
	public void setNoLocalidade(String noLocalidade) {
		this.noLocalidade = noLocalidade;
	}
	public boolean isCapital() {
		return capital;
	}
	public void setCapital(boolean capital) {
		this.capital = capital;
	}	
}
