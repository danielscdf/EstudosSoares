package com.cesta.repository;

import com.cesta.model.Item;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ItemRepository extends JpaRepository<Item, Long> {
    List<Item> findByCategoria(String categoria);
}