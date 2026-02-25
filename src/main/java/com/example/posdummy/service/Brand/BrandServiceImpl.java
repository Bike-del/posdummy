package com.example.posdummy.service.Brand;

import com.example.posdummy.GlobalException.ResourceNotFoundException;
import com.example.posdummy.Repository.BrandRepository;
import com.example.posdummy.vo.Brand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class BrandServiceImpl implements BrandService{

    @Autowired
    private BrandRepository brandRepository;

    @Override
    public Brand createBrand(Brand brand) {
        brand.setCreatedAt(LocalDateTime.now());
        return brandRepository.save(brand);
    }

    @Override
    public Brand updateBrand(Brand brand, long id) {
        Brand oldBrand = brandRepository.findById(id).orElseThrow(() ->  new ResourceNotFoundException("Not found for this id:"+id));
        oldBrand.setBrandName(brand.getBrandName());
        oldBrand.setDescription(brand.getDescription());
        oldBrand.setUpdatedAt(LocalDateTime.now());

        return brandRepository.save(oldBrand);

    }

    @Override
    public void deleteBrand(long id) {
        brandRepository.deleteById(id);

    }

    @Override
    public List<Brand> getAllBrand() {
         return brandRepository.findAll();

    }

    @Override
    public Brand getById(long id) {
        return brandRepository.findById(id).orElseThrow(()->new ResourceNotFoundException("Not found for brand for this id"+id));
    }


}
