package br.jus.educacional.aula06;

public class Arvore<T> {

    public No raiz;

    class No {
        T valor;
        No filhoEsquerdo;
        No filhoDireito;

        public No(T valor) {
            this.valor = valor;
        }
    }

    public No inserir(T valor) {
        return this.inserir(new No(valor), raiz);
    }

    private No inserir(No novo, No anterior) {
        if (raiz == null) {
            raiz = novo;
            return raiz;
        }

        if (anterior != null) {
            if (novo.valor <= anterior.valor) {
                anterior.filhoEsquerdo = this.inserir(novo, anterior.filhoEsquerdo);
            } else if (novo.valor > anterior.valor) {
                anterior.filhoDireito = this.inserir(novo, anterior.filhoDireito);
            } else {
                return null;
            }
        } else {
            anterior = novo;
        }

        return anterior;
    }
    
   
}
