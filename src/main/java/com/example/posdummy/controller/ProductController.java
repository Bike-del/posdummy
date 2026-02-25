package com.example.posdummy.controller;

import com.example.posdummy.dto.ProductDto;
import com.example.posdummy.service.Product.ProductService;
import com.example.posdummy.vo.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping("/getAll")
    public List<Product> getAll(){
        return productService.getAllProduct();
    }

    @GetMapping("/{id}")
    public Product getById(@PathVariable long id){
        return productService.getById(id);
    }

    @PostMapping("/create")
    public Product createProduct(@RequestBody ProductDto productDto){
        return productService.createProduct(productDto);

    }

    @PostMapping("/update/{id}")
    public Product updateProduct(@RequestBody ProductDto productDto,@PathVariable long id){
        return productService.updateProduct(productDto,id);
    }

    @PostMapping("/delete/{id}")
    public String deleteProduct(@PathVariable long id){
         productService.deleteProduct(id);
         return "Deleted...";
    }

}
