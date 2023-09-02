package com.model2.mvc.service.purchase.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.junit.Assert;

@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations = { "classpath:config/commonservice.xml"})
//==> Meta-Data 를 다양하게 Wiring 하자...
//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration(locations = { "classpath:config/context-common.xml",
									"classpath:config/context-aspect.xml",
									"classpath:config/context-mybatis.xml",
									"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
//	@Test
	public void testAddPurchase() throws Exception{
		
		Purchase purchase = new Purchase();
		Product product = new Product();
		User user = new User();

		product.setProdNo(10000);
		purchase.setPurchaseProd(product);
		
		user.setUserId("user11");
		purchase.setBuyer(user);
		
		purchase.setPaymentOption("1");
		purchase.setReceiverName("scott");
		purchase.setReceiverPhone("010-1111-1111");
		purchase.setDlvyAddr("우리집?");
		purchase.setDlvyRequest("Quickly");
		purchase.setTranCode("1");
		purchase.setDlvyDate("2023-10-15");
		
		purchaseService.addPurchase(purchase);
		
		System.out.println(purchase);
		
		Assert.assertEquals(10000, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user11", purchase.getBuyer().getUserId());
		Assert.assertEquals("scott", purchase.getReceiverName());
		
	}
	
//	@Test
	public void testGetPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		
		purchase.setTranNo(10000);
		
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		
		System.out.println(purchase);
		
		
		Assert.assertNotNull(purchase);
		
		
	}
//	@Test
	public void testUpdatePurchase() throws Exception{
		
		Purchase purchase = purchaseService.getPurchase(10000);
		
		System.out.println(purchase);
		
		Assert.assertNotNull(purchase);
		
		purchase.setDlvyAddr("JAVA_HOME");
		purchase.setDlvyRequest("아무때나 와주세요.");
		
		purchaseService.updatePurchase(purchase);
		
		System.out.println(purchase);
		
		Assert.assertEquals("JAVA_HOME", purchase.getDlvyAddr());
		Assert.assertEquals("아무때나 와주세요.", purchase.getDlvyRequest());
		
	}
//	@Test
	public void testGetPurchaseListAll() throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	
	 	Map<String,Object> map = purchaseService.getPurchaseList(search, "user01");
	 	
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
	 	map = purchaseService.getPurchaseList(search, "user01");
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	}
//	@Test
	public void updateTranCodePcsToDlv() throws Exception {
		Purchase purchase = purchaseService.getPurchase(10000);
		
		purchase.setTranCode("2");
		
		System.out.println(purchase);
		
		Assert.assertNotNull(purchase);
		Assert.assertEquals("2", purchase.getTranCode());
	}
//	@Test
	public void updateTranCodeDlvToRcv() throws Exception {
		Purchase purchase = purchaseService.getPurchase(10000);
		
		purchase.setTranCode("3");
		
		System.out.println(purchase);
		
		Assert.assertNotNull(purchase);
		Assert.assertEquals("3", purchase.getTranCode());
	}
} // end of class
