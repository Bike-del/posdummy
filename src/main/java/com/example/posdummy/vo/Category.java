package com.example.posdummy.vo;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "categories")
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_id")
    private long categoryId;

    @Column(name = "category_name")
    private String categoryName;

    private String description;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @Column(name = "parent_category_id",columnDefinition = "DOUBLE DEFAULT 0")
    private long parentCategoryId;

    // default parent category id is zero  which show in drop down in ui which ever is zero is , then when you create a new category it will show the all the 0 defaul parent category which want you to choose.

}
