package com.example.posdummy.service.sales;


import com.example.posdummy.GlobalException.ResourceNotFoundException;
import com.example.posdummy.Repository.SalesItemRepository;
import com.example.posdummy.Repository.SalesRepository;
import com.example.posdummy.dto.SalesDto;
import com.example.posdummy.dto.SalesItemDto;
import com.example.posdummy.service.Product.ProductService;
import com.example.posdummy.service.sales_item.SalesItemService;
import com.example.posdummy.vo.Product;
import com.example.posdummy.vo.Sales;
import com.example.posdummy.vo.SalesItem;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.Serial;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SalesServiceImpl implements SalesService {


    private final SalesRepository salesRepository;
    private final ProductService productService;
    private final SalesItemRepository salesItemRepository;

    @Value("${sales.order.prefix}")
    private String orderPrefix;

    @Override
    @Transactional
    public Sales createSale(SalesDto salesDto) {


        LocalDateTime saleDate = salesDto.getSaleDate() != null ? salesDto.getSaleDate() : LocalDateTime.now();


        Sales sale = new Sales();
        sale.setCustomerName(salesDto.getCustomerName());
        sale.setSaleDate(saleDate);
        String orderNo = generateOrderNo(saleDate);
        sale.setOrderNo(orderNo);
        salesRepository.save(sale);



        for (SalesItemDto itemDto : salesDto.getItems()) {

            Product product = productService.getById(itemDto.getProductId());
            product.setQty(product.getQty()- itemDto.getSalesQty());

            SalesItem item = new SalesItem();
            item.setProduct(product);
            item.setSales(sale);
            item.setSalesQty(itemDto.getSalesQty());
            item.setTotalPrice(itemDto.getTotalPrice());
            salesItemRepository.save(item);


        }
        return sale;


    }


    @Override
    public Sales updateSale(SalesDto salesDto, long id) {
        Sales s = salesRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("sales not found for this id:" + id));

        if (salesDto.getSaleDate() != null) {
            s.setSaleDate(salesDto.getSaleDate());
        }

        if (salesDto.getCustomerName() != null) {
            s.setCustomerName(salesDto.getCustomerName());
        }

        //order no can't be updated
//        s.setOrderNo(salesDto.getOrderNo());
        return salesRepository.save(s);
    }

    @Override
    public void deleteSales(long id) {
        salesRepository.deleteById(id);

    }

    @Override
    public Sales salesGetById(long id) {
        return salesRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("sales not found for this id:" + id));

    }


    public List<Sales> getAll() {
        return salesRepository.findAll();
    }


//==========================================EXTRA METHOD ===================================================


    private String generateOrderNo(LocalDateTime saleDate) {
        int month = saleDate.getMonthValue();
        int year = saleDate.getYear();
        int day = saleDate.getDayOfMonth();

        //total today record
        int count = salesRepository.countBySaleDateBetween(
                saleDate.toLocalDate().atStartOfDay(),
                saleDate.toLocalDate().atTime(23, 59, 59)
        );

        long sequnece = count + 1;

        return String.format("%s-%02d-%d-%02d-%03d", orderPrefix, month, year, day, sequnece);

    }
}
