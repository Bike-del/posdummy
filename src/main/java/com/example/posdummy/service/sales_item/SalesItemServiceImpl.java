package com.example.posdummy.service.sales_item;

import com.example.posdummy.GlobalException.ResourceNotFoundException;
import com.example.posdummy.Repository.SalesItemRepository;
import com.example.posdummy.dto.SalesItemDto;
import com.example.posdummy.service.Product.ProductService;
import com.example.posdummy.service.sales.SalesService;
import com.example.posdummy.vo.Product;
import com.example.posdummy.vo.Sales;
import com.example.posdummy.vo.SalesItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SalesItemServiceImpl implements SalesItemService {

    @Autowired
    private SalesItemRepository salesItemRepository;

    @Autowired
    private SalesService salesService;

    @Autowired
    private ProductService productService;

    @Override
    public SalesItem createSalesItem(SalesItemDto salesItemDto) {

        Sales sales = salesService.salesGetById(salesItemDto.getSalesItemId());
        Product product = productService.getById(salesItemDto.getProductId());

        SalesItem salesItem = new SalesItem();
        salesItem.setSalesQty(salesItemDto.getSalesQty());
        salesItem.setTotalPrice(salesItemDto.getTotalPrice());
        salesItem.setProduct(product);
        salesItem.setSales(sales);



        return salesItemRepository.save(salesItem);
    }

    @Override
    public SalesItem updateSalesItem(SalesItemDto salesItemDto, long id) {

        Sales sales = salesService.salesGetById(salesItemDto.getSalesItemId());
        Product product = productService.getById(salesItemDto.getProductId());

        SalesItem salesItem = salesItemRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("sales not found for this id:" + id));
        salesItem.setSalesQty(salesItemDto.getSalesQty());
        salesItem.setProduct(product);
        salesItem.setSales(sales);
        salesItem.setTotalPrice(salesItemDto.getTotalPrice());


        return salesItemRepository.save(salesItem);
    }

    @Override
    public List<SalesItem> getall() {
        return salesItemRepository.findAll();
    }

    @Override
    public SalesItem getById(long id) {
        return salesItemRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("sales not found for this id:" + id));
    }

    @Override
    public void deleteSalesItem(long id) {
         salesItemRepository.deleteById(id);
    }
}
