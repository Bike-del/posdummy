package com.example.posdummy.service.Category;


import com.example.posdummy.vo.Category;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public  interface CategoryService{

     Category createCategory(Category category);
     Category updateCategory(Category category, Long id );
     void deleteCategory(long id);
     List<Category> getAllCategory();
     Category categoryById(long id);


}