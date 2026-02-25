package com.example.posdummy.service.Product;

import com.example.posdummy.dto.ProductDto;
import com.example.posdummy.vo.Product;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ProductService {

    Product createProduct(ProductDto productDto);
    Product updateProduct(ProductDto productDto,long id);
    Void deleteProduct( long id);
    List<Product> getAllProduct();
    Product getById(long id);
    Product findByName( String name);




}
