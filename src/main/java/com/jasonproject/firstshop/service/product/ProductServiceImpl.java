package com.jasonproject.firstshop.service.product;

import com.jasonproject.firstshop.persistence.product.ProductRepository;
import com.jasonproject.firstshop.service.domain.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;

    @Autowired
    public ProductServiceImpl(ProductRepository productRepository) {
        System.out.println(this.getClass());
        this.productRepository = productRepository;
    }

    @Override
    public Product getProductPurchase(int prodNo) throws Exception {
        return productRepository.findByProdNo(prodNo);
    }

    @Override
    public List<Product> getAllProduct() throws Exception {
        return productRepository.findAll();
    }
}
