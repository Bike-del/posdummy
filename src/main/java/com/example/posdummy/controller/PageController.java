package com.example.posdummy.controller;

import com.example.posdummy.dto.ProductDto;
import com.example.posdummy.service.Product.ProductService;
import com.example.posdummy.vo.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller()
public class PageController {

    @Autowired
    private ProductService productService;

    @GetMapping("/product")
    public ModelAndView productPage(){
        ModelAndView mv = new ModelAndView("Product");
        return mv;
    }

    @PostMapping("/product/edit")
    public ModelAndView updateProduct(@ModelAttribute ProductDto product){
        productService.updateProduct(product,product.getProductId());
        ModelAndView mv = new ModelAndView("Product");
        return mv;
    }



    @GetMapping("/EditPage/{id}")
    public ModelAndView editProductPage(@PathVariable long id) {
        ModelAndView mv = new ModelAndView("Editpage");
        mv.addObject("product", productService.getById(id));
        return mv;
    }

    @GetMapping("/testEdit")
    public ModelAndView testedit() {
        ModelAndView mv = new ModelAndView("Editpage");
        return mv;
    }
}
