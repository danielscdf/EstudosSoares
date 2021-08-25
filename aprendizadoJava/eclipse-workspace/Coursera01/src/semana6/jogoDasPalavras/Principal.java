package semana6.jogoDasPalavras;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

public class Principal {

	public static void main(String[] args) {
		String resposta;
		boolean acertouPalavra;
		BancoDePalavras arquivoPalavraSecreta = new BancoDePalavras(new File(
				"/media/daniel/D/desenv/EstudosSoares/aprendizadoJava/eclipse-workspace/Coursera01/src/semana6/jogoDasPalavras/Palavras.txt"));
		System.out.println(
				"************************************************************\n***************JOGO DAS PALAVRAS EMBARELHADAS***************\n************************************************************\n");
		FabricaMecanicaDoJogo fabricaMecanicaDoJogo = new FabricaMecanicaDoJogo();
		MecanicaDoJogo jogo = fabricaMecanicaDoJogo.retornaMecanica(arquivoPalavraSecreta.getPalavra());
		System.out.println(jogo.DescricaoJogo());

		Scanner pausaDescricaoJogo = new Scanner(System.in);
		resposta = pausaDescricaoJogo.nextLine();
		LimpaTela();
		while (!jogo.JogoAcabou()) {
			do {
				System.out.println("Palavra embaralhada:" + jogo.GetPalavraEmbaralhada());
				System.out.println("\nQual a palavra?\n");
				@SuppressWarnings("resource")
				Scanner inResposta = new Scanner(System.in);
				resposta = inResposta.nextLine();
				if (jogo.AcertouPalavra(resposta)) {
					acertouPalavra = true;
					System.out.println("\nParabéns acertou!\n");
				} else {
					acertouPalavra = false;
					System.out.println("\nInfelizmente errou!\n");
				}
			} while (!acertouPalavra & jogo.PodeTentarNovamente());
			jogo.TrocaPalavraSecreta(arquivoPalavraSecreta.getPalavra());
		}
		pausaDescricaoJogo.close();
		LimpaTela();
		System.out.println("************************************************************\n"
				+ "                        <<FIM DO JOGO>>\n\n" + jogo.GetStatusPartida()
				+ "\n************************************************************");
	}

	private static void LimpaTela() {
		if (System.getProperty("os.name").contains("Windows"))
			try {
				Runtime.getRuntime().exec("cls");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		else
			try {
				Runtime.getRuntime().exec("clear");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
}
