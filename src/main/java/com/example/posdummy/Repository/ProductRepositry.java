package com.example.posdummy.Repository;

import com.example.posdummy.dto.ProductDto;
import com.example.posdummy.vo.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepositry extends JpaRepository<Product, Long> {

    Product findByProductName(String productName);
}

