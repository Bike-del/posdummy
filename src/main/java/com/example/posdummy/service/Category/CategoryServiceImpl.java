package com.example.posdummy.service.Category;

import com.example.posdummy.GlobalException.ResourceNotFoundException;
import com.example.posdummy.Repository.CategoryRepository;
import com.example.posdummy.vo.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService{

    @Autowired
    private  CategoryRepository categoryRepository;

    @Override
    public Category createCategory(Category category) {
        category.setCreatedAt(LocalDateTime.now());
        category.setUpdatedAt(LocalDateTime.now());
        return categoryRepository.save(category);

    }

    @Override
    public Category updateCategory(Category category, Long id) {
        Category oldCategory = categoryRepository.findById(id).orElseThrow(() ->  new ResourceNotFoundException("Not found for this id:"+id));
        oldCategory.setCategoryName(category.getCategoryName());

        oldCategory.setDescription(category.getDescription());
        oldCategory.setUpdatedAt(LocalDateTime.now());
       return categoryRepository.save(oldCategory);

    }


    @Override
    public void deleteCategory(long id) {
        categoryRepository.deleteById(id);
    }

    @Override
    public List<Category> getAllCategory() {
        return categoryRepository.findAll();
    }

    @Override
    public Category categoryById(long id) {
        return categoryRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("Not found for this id:"+id));
    }
}
