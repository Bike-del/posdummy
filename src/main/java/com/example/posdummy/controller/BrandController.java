package com.example.posdummy.controller;

import com.example.posdummy.service.Brand.BrandService;
import com.example.posdummy.vo.Brand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/Brand")
public class BrandController {

    @Autowired
    private BrandService brandService;

    //getBrand
    @GetMapping("/getAll")
    public List<Brand> getAllBrand(){
        return brandService.getAllBrand();
    }

    //getbyid
    @GetMapping("/{id}")
    public Brand getBrand(@PathVariable long id){
        return brandService.getById(id);
    }



    //create
    @PostMapping("/create")
    public Brand createBrand(@RequestBody Brand brand){
        return brandService.createBrand(brand);
    }

    //update
    @PostMapping("/update/{id}")
    public Brand updateBrand(@RequestBody Brand brand,@PathVariable long id){
        return brandService.updateBrand(brand,id);
    }


    //delete
    @PostMapping("/delete/{id}")
    public String deleteBrand(@PathVariable long id){
         brandService.deleteBrand(id);
         return "deleted..";
    }
}
