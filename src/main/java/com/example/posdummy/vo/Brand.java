package com.example.posdummy.vo;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "brands")
public class Brand {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "brand_id")
    private long brandId;

    @Column(name = "brand_name")
    private String brandName;

    private String description;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;



}
