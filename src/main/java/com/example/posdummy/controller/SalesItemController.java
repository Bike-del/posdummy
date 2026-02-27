package com.example.posdummy.controller;

import com.example.posdummy.dto.SalesDto;
import com.example.posdummy.dto.SalesItemDto;
import com.example.posdummy.service.sales_item.SalesItemService;
import com.example.posdummy.vo.Sales;
import com.example.posdummy.vo.SalesItem;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/SalesItem")
@RequiredArgsConstructor
public class SalesItemController {

    private final SalesItemService salesItemService;

    @GetMapping("/getAll")
    public List<SalesItem> getAll(){
         return  salesItemService.getall();
    }

    @GetMapping("/{id}")
    public SalesItem getById(@PathVariable long id){
        return salesItemService.getById(id);
    }

    @PostMapping("/create")
    public SalesItem create(@RequestBody SalesItemDto salesItem){
        return salesItemService.createSalesItem(salesItem);
    }

    @PostMapping("/update/{id}")
    public SalesItem update(@RequestBody SalesItemDto salesItemDto, @PathVariable long id){
        return salesItemService.updateSalesItem(salesItemDto,id);
    }

    @DeleteMapping("/Delete/{id}")
    public String  delete(@PathVariable long id){
        salesItemService.deleteSalesItem(id);
        return "Success";
    }


}
