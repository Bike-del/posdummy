package com.example.posdummy.service.sales;


import com.example.posdummy.GlobalException.ResourceNotFoundException;
import com.example.posdummy.Repository.SalesRepository;
import com.example.posdummy.dto.SalesDto;
import com.example.posdummy.vo.Sales;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@RequiredArgsConstructor
public class SalesServiceImpl implements SalesService {


    private final SalesRepository salesRepository;

    @Override
    public Sales createSale(SalesDto salesDto) {

        Sales s = new Sales();
        s.setDate(salesDto.getDate());
        s.setCustomerName(salesDto.getCustomerName());
        s.setOrderNo(salesDto.getOrderNo());

        return salesRepository.save(s);

    }

    @Override
    public Sales updateSale(SalesDto salesDto, long id) {
        Sales s = salesRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("sales not found for this id:" + id));
        s.setDate(salesDto.getDate());
        s.setCustomerName(salesDto.getCustomerName());
        s.setOrderNo(salesDto.getOrderNo());
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
}
