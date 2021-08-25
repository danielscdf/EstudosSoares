package semana6.jogoDasPalavras;

public interface MecanicaDoJogo {
	public String DescricaoJogo();

	public boolean JogoAcabou();

	public boolean AcertouPalavra(String palavraDigitada);

	public boolean PodeTentarNovamente();

	public int GetPontuacao();

	public String GetStatusPartida();

	public String GetPalavraEmbaralhada();

	public void TrocaPalavraSecreta(String palavraSecreta);

	public void AtribuiPontuação();
}
