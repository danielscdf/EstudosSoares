package br.jus.tse.educacional.exercicio02;

public class Arvore {
	   public No raiz;

	    class No {
	        Integer valor;
	        No filhoEsquerdo;
	        No filhoDireito;

	        public No(Integer valor) {
	            this.valor = valor;
	            //System.out.println("Método Construtor - Inserido Raiz!");
	        }
	    }

	    public No inserir(Integer valor) {
	        return this.inserir(new No(valor), raiz);
	    }

	    private No inserir(No novo, No anterior) {
	        if (raiz == null) {
	            raiz = novo;
	            System.out.println("Inserido Raiz!");
	            return raiz;
	        }

	        if (anterior != null) {
	            if (novo.valor <= anterior.valor) {
	                anterior.filhoEsquerdo = this.inserir(novo, anterior.filhoEsquerdo);
	                System.out.println("Inserido esquerdo! Novo: " + novo.valor + " Anterior: " + anterior.valor);
	            } else if (novo.valor > anterior.valor) {
	                anterior.filhoDireito = this.inserir(novo, anterior.filhoDireito);
	                System.out.println("Inserido direito! Novo: " + novo.valor + " Anterior: " + anterior.valor);
	            } else {
	                return null;
	            }
	        } else {
	            anterior = novo;
	        }

	        return anterior;
	    }
}
