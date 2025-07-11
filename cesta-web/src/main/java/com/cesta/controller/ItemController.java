package com.cesta.controller;

import com.cesta.model.Item;
import com.cesta.repository.ItemRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@Controller
public class ItemController {

    @Autowired
    private ItemRepository itemRepository;

    @PostConstruct
    public void init() {
        if (itemRepository.count() == 0) {
            itemRepository.saveAll(Arrays.asList(
                    new Item(null, "Bebidas", "Refrigerante", 5.5),
                    new Item(null, "Bebidas", "Suco", 4.0),
                    new Item(null, "Higiene", "Sabonete", 2.5),
                    new Item(null, "Higiene", "Pasta de Dente", 3.2),
                    new Item(null, "Alimentos", "Arroz", 10.0),
                    new Item(null, "Alimentos", "Feijão", 8.0)
            ));
        }
    }

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("categorias", itemRepository.findAll()
                .stream().map(Item::getCategoria).distinct().toList());
        return "index";
    }

    @GetMapping("/itens")
    @ResponseBody
    public List<Item> getItens(@RequestParam String categoria) {
        return itemRepository.findByCategoria(categoria);
    }
}