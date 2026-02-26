package com.example.posdummy.controller;

import com.example.posdummy.dto.ProductDto;
import com.example.posdummy.service.Brand.BrandService;
import com.example.posdummy.service.Category.CategoryService;
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

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private BrandService brandService;

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
        mv.addObject("categories",categoryService.getAllCategory());
        mv.addObject("ParentCategory",categoryService.getParentCategory());
//        mv.addObject("SubCategory",categoryService.getAllCategory());
        mv.addObject("brands",brandService.getAllBrand());
        return mv;
    }

    @GetMapping("/addProduct")
    public ModelAndView addProduct() {
        ModelAndView mv = new ModelAndView("AddProduct");

        mv.addObject("ParentCategory",categoryService.getParentCategory());
        mv.addObject("brands",brandService.getAllBrand());
        return mv;
    }

//    @PostMapping("/addProduct")
//    public ModelAndView addProduct() {
//        ModelAndView mv = new ModelAndView("AddProduct");
//        return mv;
//    }

    @GetMapping("/dashboard")
    public ModelAndView Dashboard(){
        ModelAndView mv = new ModelAndView("Dashboard");
        mv.addObject("products",productService.getAllProduct());
        return mv;
    }

}
