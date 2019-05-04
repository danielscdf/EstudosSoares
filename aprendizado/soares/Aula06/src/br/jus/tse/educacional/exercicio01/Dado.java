package br.jus.tse.educacional.exercicio01;

import java.lang.annotation.Annotation;
import java.util.Random;
@ViciaDado(numeroViciado = 1, vezesRepeticao = 4)
public class Dado {
	private final int totalJogadas = 6;
	private int dado6Faces;
	private int nViciado;
	private int numerosHonestos;
	private int repeticao;
	
    public void jogaDado(){
    	Class classe = Dado.class;
    	Annotation[] anotacoes = classe.getAnnotations();
    	for (Annotation anotacao : anotacoes){
    		ViciaDado numero = (ViciaDado) anotacao;
    		nViciado = numero.numeroViciado();
    		repeticao = numero.vezesRepeticao();
    		//System.out.println("Número viciado" + numero.numeroViciado());
    	}
    	if (nViciado > 0) {
			sorteiaDesonestamente();
		}else {
			sorteiaHonestamente();
		}
    }
    private void sorteiaHonestamente(){
    	System.out.println("********Jogada Honesta********");
    	Random dado = new Random();   

        for (int i = 0; i < totalJogadas; i++) {
        	dado6Faces = 1 + dado.nextInt( 6 );
        	
        	System.out.println( dado6Faces );
		}
    }
    private void sorteiaDesonestamente(){
    	System.out.println("********Jogada Desonesta********");
        Random dado = new Random();   

        for (int i = 0; i < totalJogadas; i++) {
        	dado6Faces = 1 + dado.nextInt( 6 );
        	
        	if (nViciado > 0) {
            	while (dado6Faces != nViciado && numerosHonestos == totalJogadas - repeticao) {
            		dado6Faces = 1 + dado.nextInt( 6 );
    			}
            	if (dado6Faces != nViciado) {
            		numerosHonestos = numerosHonestos +1;
    			}
			}

        	System.out.println( dado6Faces );
		}    	
    }
}
