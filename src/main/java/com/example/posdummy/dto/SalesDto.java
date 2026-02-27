package com.example.posdummy.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SalesDto {

    private long salesId;

    private String customerName;

    private String orderNo;

    private LocalDateTime date;

}
