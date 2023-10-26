package com.jasonproject.firstshop.web.controller.product;

import com.jasonproject.firstshop.service.domain.Product;
import com.jasonproject.firstshop.service.product.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/product")
public class ProductRestController {

    // Field
    @Qualifier("productServiceImpl")
    private final ProductService productService;

    @Autowired
    public ProductRestController(ProductService productService) {
        System.out.println(this.getClass());
        this.productService = productService;
    }

    @RequestMapping(value = "/getProduct/{prodNo}", method = RequestMethod.GET)
    public Product getProduct(@PathVariable int prodNo) throws Exception {
        System.out.println("/product/getProduct : GET json");

        return productService.getProductPurchase(prodNo);
    }

    @RequestMapping(value = "/getProductList", method = RequestMethod.GET)
    public List<Product> getProductList() throws Exception {
        System.out.println("/product/getProductList : GET json");

        return productService.getAllProduct();
    }
}
