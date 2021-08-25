package semana6.jogoDasPalavras;

public class MecanicaDoJogoPontuacao3Erros implements MecanicaDoJogo {
	private String palavraSecreta;
	private String palavraEmbaralhada;
	private int qtdVidas;
	private int pontuacao;
	private int pontosJogador;
	private int qtdTentativas;
	private int qtdTentativaPalavra;
	FabricaEmbaralhadores fabricaEmbaralhadores = new FabricaEmbaralhadores();
	Embaralhador embaralhador = fabricaEmbaralhadores.retornaEmbaralhador();

	public MecanicaDoJogoPontuacao3Erros(String palavraSecreta) {
		super();
		this.palavraSecreta = palavraSecreta;
		this.qtdVidas = 3;
		this.pontuacao = 5;
		this.qtdTentativas = 0;
		this.qtdTentativaPalavra = 0;
		this.palavraEmbaralhada = embaralhador.embaralhar(palavraSecreta);
	}

	@Override
	public String DescricaoJogo() {
		return "***************Descobre palavra 3 erros***************\n" + "-Nesse jogo o jogador terá 3 vidas;\n"
				+ "-Não haverá novas chances nas palavras erradas;\n" + "-São 5 pontos por palavra acertada;\n"
				+ "\n**Aperte qualquer tecla para iniciar o jogo**\n";
	}

	@Override
	public boolean JogoAcabou() {
		if (this.qtdVidas == 0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean AcertouPalavra(String palavraDigitada) {
		if (palavraDigitada.equalsIgnoreCase(this.palavraSecreta)) {
			this.setaVitoria();
			return true;
		} else {
			this.setaDerrota();
			return false;
		}
	}

	@Override
	public boolean PodeTentarNovamente() {
		if (this.qtdTentativas > 0) {
			if (this.qtdTentativaPalavra == this.qtdTentativas) {
				return false;
			} else {
				return true;
			}
		} else {
			return false;
		}
	}

	@Override
	public int GetPontuacao() {
		return this.pontosJogador;
	}

	@Override
	public String GetStatusPartida() {
		return "Quantidade de vidas: " + this.qtdVidas + "\n" + "Pontos ganhos: " + this.pontosJogador + "\n";
	}

	@Override
	public String GetPalavraEmbaralhada() {
		return this.palavraEmbaralhada;
	}

	public void TrocaPalavraSecreta(String palavraSecreta) {
		this.palavraSecreta = palavraSecreta;
		this.palavraEmbaralhada = embaralhador.embaralhar(palavraSecreta);
		this.qtdTentativaPalavra = 0;
	}

	private void setaVitoria() {
		AtribuiPontuação();
		this.qtdTentativaPalavra = 0;
	}

	private void setaDerrota() {
		this.qtdTentativaPalavra += 1;
		this.qtdVidas -= 1;
	}

	@Override
	public void AtribuiPontuação() {
		this.pontosJogador += this.pontuacao;
	}
}
