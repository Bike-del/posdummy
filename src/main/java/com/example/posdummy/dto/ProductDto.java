package com.example.posdummy.dto;

import lombok.Data;

@Data
public class ProductDto {

    private long productId;


    private String  itemCode;


    private String productName;



    private double MRP;


    private  double sellingPrice;
    private double qty;


    private long categoryId;


    private long brandId;

    private boolean status;

    private long subCategoryId;

}
