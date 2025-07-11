package com.cesta.model;

import jakarta.persistence.*;

@Entity
public class Item {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String categoria;
    private String descricao;
    private double valor;

    public Item() {}

    public Item(Long id, String categoria, String descricao, double valor) {
        this.id = id;
        this.categoria = categoria;
        this.descricao = descricao;
        this.valor = valor;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }

    public double getValor() { return valor; }
    public void setValor(double valor) { this.valor = valor; }
}