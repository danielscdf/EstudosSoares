package br.jus.tse.educacional.exercicio01;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.Scanner;

public class File {

    public static void main(String args[]){

        System.out.print("Enter Text: ");
        Scanner scan = new Scanner(System.in);
        String text = scan.nextLine();
        FileWriter fWriter = null;
        BufferedWriter writer = null;
        try {
          fWriter = new FileWriter("arquivo.txt");
          writer = new BufferedWriter(fWriter);
          writer.write(text);
          writer.newLine();
          writer.close();
          System.err.println( + text.length() + " caracteres foram salvos.");
        } catch (Exception e) {
            System.out.println("Error!");
        }
    }

}