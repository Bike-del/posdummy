package com.example.posdummy.controller;

import com.example.posdummy.Repository.SalesRepository;
import com.example.posdummy.dto.SalesDto;
import com.example.posdummy.service.sales.SalesService;
import com.example.posdummy.vo.Sales;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController()
@RequestMapping("/sales")
@RequiredArgsConstructor
public class SalesController {


    private final SalesService salesService;

    @GetMapping("/getAll")
    public List<Sales> getAll(){
        return salesService.getAll();
    }

    @GetMapping("/{id}")
    public Sales getById(@PathVariable long id){
        return  salesService.salesGetById(id);
    }

    @PostMapping("/create")
    public Sales createSale(@RequestBody SalesDto sales){
        return salesService.createSale(sales);
    }

    @PostMapping("/update/{id}")
    public Sales update(@RequestBody SalesDto sales, @PathVariable long id){
        return salesService.updateSale(sales,id);
    }

    @DeleteMapping("Delete/{id}")
    public String  delete(@PathVariable long id){
         salesService.deleteSales(id);
         return "Success";
    }

}
