package semana6.jogoDasPalavras;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.Random;

public class BancoDePalavras {
	private File file;

	public BancoDePalavras(File file) {
		super();
		this.file = file;
	}

	private List<String> getListaPalavrasArquivo() {
		List<String> listaString = null;
		try {
			listaString = Files.readAllLines(file.toPath());
			return listaString;
		} catch (IOException e) {
			e.printStackTrace();
			return listaString;
		} 
	}

	public String getPalavra() {
		int qtdLinhasArquivo = getListaPalavrasArquivo().size();
		Random r = new Random();
		return getListaPalavrasArquivo().get(r.nextInt(qtdLinhasArquivo - 1) + 1);
	}
}
