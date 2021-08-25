package semana6.excecaoLerArquivo;

import java.util.HashMap;

public class Principal {
	public static void main(String[] args) throws LeituraArquivoException {
		HashMap<String, String> mapTeste = new HashMap<String, String>();
		mapTeste = ProcessadorArquivo.processar(
				"/media/danielscdf/D/desenv/EstudosSoares/aprendizadoJava/eclipse-workspace/Coursera01/src/semana6/excecaoLerArquivo/Arquivo.txt");
		System.out.println(mapTeste);
		String linha = "Nome->Daniel";
		if(linha.contains("->")){
			int qtdSinal = linha.length() - linha.replaceAll("->", "").length();
			
			if(qtdSinal > 2){
				System.out.println("Formato de arquivo inválido.");
			}			
		}else{
			System.out.println("Formato de arquivo inválido.");
		}
	}

}
