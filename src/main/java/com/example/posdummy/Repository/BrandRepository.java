package com.example.posdummy.Repository;

import com.example.posdummy.vo.Brand;
import com.example.posdummy.vo.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BrandRepository extends JpaRepository<Brand,Long> {
}
