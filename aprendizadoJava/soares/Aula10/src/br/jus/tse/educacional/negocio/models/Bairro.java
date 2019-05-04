package br.jus.tse.educacional.negocio.models;

public class Bairro extends Localidade{
	private Integer nuBairro;
	private Uf uf;
	private Localidade localidade;
	private String noBairro;

	public Integer getNuBairro() {
		return nuBairro;
	}

	public void setNuBairro(Integer nuBairro) {
		this.nuBairro = nuBairro;
	}

	public Uf getUf() {
		if(uf==null){
			uf = new Uf();
		}
		return uf;
	}

	public void setUf(Uf uf) {
		this.uf = uf;
	}

	public Localidade getLocalidade() {
		if(localidade == null){
			localidade = new Localidade();
		}
		return localidade;
	}

	public void setLocalidade(Localidade localidade) {
		this.localidade = localidade;
	}

	public String getNoBairro() {
		return noBairro;
	}

	public void setNoBairro(String noBairro) {
		this.noBairro = noBairro;
	}

	public String getBairro() {
		return noBairro;
	}

	public void setBairro(String bairro) {
		this.noBairro = bairro;
	}
	
}
