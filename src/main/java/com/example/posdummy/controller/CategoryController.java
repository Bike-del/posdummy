package com.example.posdummy.controller;


import com.example.posdummy.service.Category.CategoryService;
import com.example.posdummy.vo.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    //get
    @GetMapping("/getAll")
    public List<Category> getAllCategory(){
        return categoryService.getAllCategory();
    }

    //post
    @PostMapping("/create")
    public Category createCategory(@RequestBody Category category){
        return categoryService.createCategory(category);
    }

    @PostMapping("/delete/{id}")
    public String deleteById(@PathVariable long id){
         categoryService.deleteCategory(id);
         return "Deleted";
    }

    //update
    @PostMapping("/update/{id}")
    public Category updateCategory(@RequestBody Category category,@PathVariable long id){
        return categoryService.updateCategory(category,id);
    }


    //findbyid
    @GetMapping("/{id}")
    public Category getById(@PathVariable long id){
        return categoryService.categoryById(id);
    }


}
