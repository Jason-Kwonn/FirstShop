package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@Repository("productServiceImpl")
public class ProductServiceImpl implements ProductService {

	///Field
	@Autowired
	@Qualifier("productDaoImpl") 
	private ProductDao productDao;
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}
	
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addProduct(Product product) throws Exception {
		productDao.addProduct(product);
	}

	@Override
	public Product getProduct(int productNo) throws Exception {
		return productDao.getProduct(productNo);
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception {
		List<Product> list = productDao.getProductList(search);
		int totalCount = productDao.getTotalCount(search);
		
		for(Product product : list) {
			// 재고 유무 확인 세팅
			if (product.getProductQty() == 0) {
				product.setStock("매진");
			} else {
				product.setStock("판매중");
			}
			
			String fileName = product.getFileName();
			
			if (fileName.contains(",")) {
				product.setFileName(fileName.substring(0, fileName.indexOf(",")));
			} else {
				product.setFileName(fileName);
			}
			
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
		
		//tranCode 변환 / 배송관리 페이지 분할 예정으로 주석 처리 
//		for (Product product : list) {
//		
//			if(product.getProTranCode() == null || product.getProTranCode().trim().equals("0")){
//				product.setProTranCode("판매중");
//			} else if(product.getProTranCode().trim().equals("1")){
//				product.setProTranCode("구매완료");
//			} else if(product.getProTranCode().trim().equals("2")){
//				product.setProTranCode("배송중");
//			} else if(product.getProTranCode().trim().equals("3")){
//				product.setProTranCode("배송완료");
//			}
//		}
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);
	}

	@Override
	public List<Product> queryProductList(Search search) throws Exception {
		return productDao.queryProductList(search);
	}

}
