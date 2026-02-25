package com.example.posdummy.service.Brand;

import com.example.posdummy.vo.Brand;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public  interface BrandService {


        Brand createBrand(Brand brand);
        Brand updateBrand(Brand brand,long id);
        void deleteBrand(long id);
       List<Brand> getAllBrand();

       Brand getById(long id);


}