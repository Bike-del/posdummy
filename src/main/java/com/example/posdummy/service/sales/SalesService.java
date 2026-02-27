package com.example.posdummy.service.sales;

import com.example.posdummy.dto.SalesDto;
import com.example.posdummy.vo.Sales;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface SalesService {

    public Sales createSale(SalesDto salesDto);
    public Sales updateSale(SalesDto salesDto , long id);
    public void deleteSales(long id);
    public Sales salesGetById(long id);
    public List<Sales> getAll();


}
