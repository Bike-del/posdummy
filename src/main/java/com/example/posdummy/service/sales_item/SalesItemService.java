package com.example.posdummy.service.sales_item;

import com.example.posdummy.dto.SalesItemDto;
import com.example.posdummy.vo.SalesItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface SalesItemService {

        public SalesItem createSalesItem(SalesItemDto salesItemDto);
        public SalesItem updateSalesItem(SalesItemDto salesItemDto,long id);
        public List<SalesItem> getall();
        public SalesItem getById(long id);
        public void deleteSalesItem(long id);


}
