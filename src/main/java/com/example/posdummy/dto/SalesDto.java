package com.example.posdummy.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class SalesDto {

    private long salesId;

    private String customerName;

    private String orderNo;

    private LocalDateTime saleDate;


    private List<SalesItemDto> items;

}
