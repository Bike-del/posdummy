package com.example.posdummy.Repository;

import com.example.posdummy.vo.Sales;
import com.example.posdummy.vo.SalesItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface SalesItemRepository extends JpaRepository<SalesItem,Long> {

}
