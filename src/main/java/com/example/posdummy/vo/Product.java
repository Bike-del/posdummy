package com.example.posdummy.vo;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private long productId;

    @Column(name = "item_code")
    private String  itemCode;



    @Column(name = "product_name")
    private String productName;



    private double MRP;

    @Column(name = "selling_Price")
    private  double sellingPrice;
    private double qty;
    private Boolean status=true; //ACTIVE OR DEACTIVE

    @Column(name = "show_online")
    private Boolean showOnline=true;  //TOGGLE


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id",nullable = false)
    private Category category;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "brand_id",nullable = false)
    private  Brand brand;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

}
