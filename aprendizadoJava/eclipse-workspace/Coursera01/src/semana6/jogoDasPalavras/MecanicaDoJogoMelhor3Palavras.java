package semana6.jogoDasPalavras;

public class MecanicaDoJogoMelhor3Palavras implements MecanicaDoJogo {
	private String palavraSecreta;
	private String palavraEmbaralhada;
	private int qtdVidas;
	private int pontuacao;
	private int pontosJogador;
	private int qtdTentativas;
	private int qtdTentativaPalavra;
	FabricaEmbaralhadores fabricaEmbaralhadores = new FabricaEmbaralhadores();
	Embaralhador embaralhador = fabricaEmbaralhadores.retornaEmbaralhador();

	public MecanicaDoJogoMelhor3Palavras(String palavraSecreta) {
		super();
		this.palavraSecreta = palavraSecreta;
		this.qtdVidas = 3;
		this.pontuacao = 15;
		this.qtdTentativas = 3;
		this.qtdTentativaPalavra = 0;
		this.palavraEmbaralhada = embaralhador.embaralhar(palavraSecreta);
	}

	@Override
	public String DescricaoJogo() {
		return "***************Descobre palavra melhor de 3***************\n"
				+ "-Nesse jogo o jogador tem 3 palavras para descobrir;\n"
				+ "-Serão 3 chances para acertar 1 palavra;\n"
				+ "-Acertando a palavra na primeira tentativa o jogador ganha 15 pontos;\n"
				+ "-Acertando a palavra na segunda tentativa o jogador ganha 10 pontos;\n"
				+ "-Acertando a palavra na terceira tentativa o jogador ganha 8 pontos;\n"
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
		this.qtdVidas -= 1;
	}

	private void setaDerrota() {
		this.qtdTentativaPalavra += 1;
		if(this.qtdTentativaPalavra == this.qtdTentativas) {
			this.qtdVidas -= 1;
		}
	}

	@Override
	public void AtribuiPontuação() {
		switch (this.qtdTentativaPalavra) {
		case 0:
			this.pontosJogador += this.pontuacao;
			break;
		case 1:
			this.pontosJogador += (this.pontuacao - 5);
			break;
		case 2:
			this.pontosJogador += (this.pontuacao - 7);
			break;
		default:
			this.pontosJogador += (this.pontuacao - 10);
		}
	}
}
