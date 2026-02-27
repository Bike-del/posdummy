package com.example.posdummy.vo;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "sales_item")
public class SalesItem {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "sales_item_id")
    private long salesItemId;


    // what type of mapping can happen here
    @OneToOne
    @JoinColumn(name = "product_id",nullable = false)
    private Product product;

    @Column(name = "total_price")
    private double totalPrice;

    @Column(name = "sales_qty")
    private double salesQty;

    @ManyToOne
    @JoinColumn(name = "sales_id",nullable = false)
    private Sales sales;

}
