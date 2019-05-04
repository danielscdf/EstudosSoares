package br.jus.tse.educacional.exercicio03;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import javax.swing.JOptionPane;

public class GravadorDeArquivos {
	public static void main(String[] args) {
		String texto = JOptionPane.showInputDialog("Digite um texto");
		
		if (texto != null && texto.length() > 0) {
			File arquivo = new File("arquivo.txt");
			
			if (!arquivo.exists()) {
				try {
					if (arquivo.createNewFile()) {
						FileWriter fw = new FileWriter(arquivo);
						fw.write(texto);
						
						fw.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
