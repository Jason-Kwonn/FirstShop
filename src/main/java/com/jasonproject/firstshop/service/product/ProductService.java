package com.jasonproject.firstshop.service.product;

import com.jasonproject.firstshop.service.domain.Product;

import java.util.List;

public interface ProductService {

    Product getProductPurchase(int prodNo) throws Exception;

    List<Product> getAllProduct() throws Exception;
}
