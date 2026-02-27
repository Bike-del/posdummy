package com.example.posdummy.dto;

import com.example.posdummy.vo.Product;
import com.example.posdummy.vo.Sales;
import jakarta.persistence.Column;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import lombok.Data;

@Data
public class SalesItemDto {

    private long salesItemId;


    // what type of mapping can happen here

    private long productId;


    private double totalPrice;


    private double salesQty;


    private long salesId;

}
