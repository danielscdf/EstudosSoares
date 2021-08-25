package semana6.testeExcecaoLerArquivo;

import static org.junit.Assert.*;

import java.util.HashMap;

import org.junit.Test;

import semana6.excecaoLerArquivo.LeituraArquivoException;
import semana6.excecaoLerArquivo.ProcessadorArquivo;

public class TesteProcessadorArquivo {

	@Test
	public void processadoComSucesso() throws LeituraArquivoException {
		HashMap<String, String> mapTeste = new HashMap<String, String>();
		mapTeste = ProcessadorArquivo.processar(
				"/media/danielscdf/D/desenv/EstudosSoares/aprendizadoJava/eclipse-workspace/Coursera01/src/semana6/excecaoLerArquivo/Arquivo.txt");
		assertEquals(mapTeste.get("idade"), "37");
	}

	@Test
	public void arquivoVazio() throws LeituraArquivoException {
		try {
			@SuppressWarnings("unused")
			HashMap<String, String> mapTeste = new HashMap<String, String>();
			mapTeste = ProcessadorArquivo.processar(
					"/media/danielscdf/D/desenv/EstudosSoares/aprendizadoJava/eclipse-workspace/Coursera01/src/semana6/excecaoLerArquivo/ArquivoVazio.txt");
		} catch (LeituraArquivoException e) {
			assertEquals(e.getMessage(), "Arquivo vazio");
		}
	}

	@Test
	public void formatoArquivoInvalido() throws LeituraArquivoException {
		try {
			@SuppressWarnings("unused")
			HashMap<String, String> mapTeste = new HashMap<String, String>();
			mapTeste = ProcessadorArquivo.processar(
					"/media/danielscdf/D/desenv/EstudosSoares/aprendizadoJava/eclipse-workspace/Coursera01/src/semana6/excecaoLerArquivo/ArquivoFormatoInvalido.txt");
		} catch (LeituraArquivoException e) {
			assertEquals(e.getMessage(), "Formato de arquivo inválido");
		}
	}

	@Test
	public void IoExceptionArquivo() throws LeituraArquivoException {
		try {
			@SuppressWarnings("unused")
			HashMap<String, String> mapTeste = new HashMap<String, String>();
			mapTeste = ProcessadorArquivo.processar(
					"/media/danielscdf/D/desenv/EstudosSoares/aprendizadoJava/eclipse-workspace/Coursera01/src/semana6/excecaoLerArquivo/ArquivoInexistente.txt");
		} catch (LeituraArquivoException e) {
			assertTrue(e.getMessage().contains("Erro ao abrir o arquivo!"));
		}
	}
}
