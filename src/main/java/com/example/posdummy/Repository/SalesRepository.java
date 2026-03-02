package com.example.posdummy.Repository;

import com.example.posdummy.vo.Sales;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface SalesRepository extends JpaRepository<Sales, Long> {
    int countBySaleDateBetween(LocalDateTime start, LocalDateTime end);
}
