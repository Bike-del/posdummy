package com.example.posdummy.service.Product;

import com.example.posdummy.GlobalException.ResourceNotFoundException;
import com.example.posdummy.Repository.ProductRepositry;
import com.example.posdummy.dto.ProductDto;
import com.example.posdummy.service.Brand.BrandService;
import com.example.posdummy.service.Category.CategoryService;
import com.example.posdummy.vo.Brand;
import com.example.posdummy.vo.Category;
import com.example.posdummy.vo.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService{

   private final ProductRepositry productRepositry;

   private final BrandService brandService;
   private final CategoryService categoryService;



    @Override
    public Product createProduct(ProductDto productDto) {

        Brand brand = brandService.getById(productDto.getBrandId());
        Category category = categoryService.categoryById(productDto.getCategoryId());

        Product product = new Product();
        product.setProductName(productDto.getProductName());
        product.setMRP(productDto.getMRP());
        product.setBrand(brand);
        product.setQty(productDto.getQty());
        product.setItemCode(productDto.getItemCode());
        product.setSellingPrice(productDto.getSellingPrice());
        product.setCreatedAt(LocalDateTime.now());
        product.setUpdatedAt(LocalDateTime.now());

        product.setSubCategoryId(productDto.getSubCategoryId());
        product.setCategory(category);

        return productRepositry.save(product);


    }

    @Override
    public Product updateProduct(ProductDto productDto, long id) {

        Brand brand = brandService.getById(productDto.getBrandId());
        Category category = categoryService.categoryById(productDto.getCategoryId());


        Product p = productRepositry.findById(id).orElseThrow(()-> new ResourceNotFoundException("not found product for this id (productId.....):"+id));
        p.setQty(productDto.getQty());
        p.setBrand(brand);
        p.setCategory(category);
        p.setMRP(productDto.getMRP());
        p.setUpdatedAt(LocalDateTime.now());
        p.setItemCode(productDto.getItemCode());
        p.setSellingPrice(productDto.getSellingPrice());
        p.setProductName(productDto.getProductName());
        p.setStatus(productDto.isStatus());
        p.setSubCategoryId(productDto.getSubCategoryId());

        return productRepositry.save(p);

    }

    @Override
    public Void deleteProduct(long id) {
        productRepositry.deleteById(id);

        return null;
    }

    @Override
    public List<Product> getAllProduct() {
        return productRepositry.findAll();
    }

    @Override
    public Product getById(long id) {
        return productRepositry.findById(id).orElseThrow(()-> new ResourceNotFoundException("not found product:"+id));
    }

    @Override
    public Product findByName(String name) {
        return productRepositry.findByProductName(name);

    }

    //status method


    //active method of product
}
