package com.example.posdummy.Repository;

import com.example.posdummy.vo.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<Category,Long> {

    @Query(value = "select * from categories where parent_category_id=:id" ,nativeQuery = true)
    List<Category> findCategoryByParentCategoryId(@Param("id") long id);

    @Query(value = "select * from categories where parent_category_id=0", nativeQuery = true)
    List<Category> findParentCategory();
}
