package semana6.excecaoLerArquivo;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Scanner;

public class ProcessadorArquivo {
	public static HashMap<String, String> processar(String nomeArquivo) throws LeituraArquivoException {
		HashMap<String, String> mapArquivo = new HashMap<String, String>();
		File file = new File(nomeArquivo);
		Scanner sc = null;
		try {
			sc = new Scanner(file);
			if (!sc.hasNextLine()) {
				throw new LeituraArquivoException("Arquivo vazio");
			}
			while (sc.hasNextLine()) {
				String s = sc.nextLine();
				if (s.contains("->->")) {
					throw new LeituraArquivoException("Formato de arquivo inválido");
				}
				String[] parteString = s.split("->");
				mapArquivo.put(parteString[0], parteString[1]);
			}
			return mapArquivo;
		} catch (IOException e) {
			throw new LeituraArquivoException("Erro ao abrir o arquivo! " + e.getMessage());
		} finally {
			if (sc != null) {
				sc.close();
			}
		}
	}
}
