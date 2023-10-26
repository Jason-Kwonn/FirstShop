package com.jasonproject.firstshop.persistence.product;

import com.jasonproject.firstshop.service.domain.Product;
import lombok.NonNull;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, String> {

    // Select one product
    Product findByProdNo(int prodNo);

    // Select all product
    @NonNull
    List<Product> findAll();

}
