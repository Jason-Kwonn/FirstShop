package com.model2.mvc.service.product.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

/*
 *	FileName :  ProductServiceTest.java
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */
@RunWith(SpringJUnit4ClassRunner.class)

//==> Meta-Data 를 다양하게 Wiring 하자...
//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration(locations = { "classpath:config/context-common.xml",
									"classpath:config/context-aspect.xml",
									"classpath:config/context-mybatis.xml",
									"classpath:config/context-transaction.xml" })
public class ProductServiceTest {
	
	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	//@Test
	public void testAddProduct() throws Exception{
		
		Product product = new Product();
		
		product.setProdName("김피탕");
		product.setProdDetail("good taste");
		product.setManuDate("20200201");
		product.setPrice(16000);
		product.setFileName(null);
		System.out.println(product);
		
		productService.addProduct(product);
		
		//==> console 확인
		System.out.println(product);
		
		//==> API 확인
		Assert.assertEquals("김피탕", product.getProdName());
		Assert.assertEquals("good taste", product.getProdDetail());
		Assert.assertEquals("20200201", product.getManuDate());
		Assert.assertEquals(16000, product.getPrice());
		Assert.assertEquals(null, product.getFileName());
		
	} // end of testAddProduct
	
	//@Test
	public void testGetProduct() throws Exception{
		
		Product product = new Product();
		product.setProdNo(10001);
		
		product = productService.getProduct(product.getProdNo());
		
		System.out.println(product);
		
		Assert.assertNotNull(productService.getProduct(product.getProdNo()));
	} // end of testGetProduct
	
	//@Test
	public void testUpdateProduct() throws Exception{
		
		Product product = productService.getProduct(10000);
		System.out.println(product);
		
		Assert.assertNotNull(product);
		
		product.setPrice(100000);
		product.setProdDetail("not that expensive");
		
		productService.updateProduct(product);
		
		product = productService.getProduct(10000);
		Assert.assertNotNull(product);
		
		System.out.println(product);
		
	} // end of testUpdateProduct
	
	@Test
	public void testGetProductListAll() throws Exception{
		
		Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("");
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	} // end of testGetProductListAll
	
//	@Test
	public void testGetProductListByProdNo() throws Exception {
		
		Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("김피탕");
	 	
	 	
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(2, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
	 	
	 	int totalCount = (Integer)map.get("totalCount");
	 	System.out.println(list);
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
		
	}
	
} // end of class
