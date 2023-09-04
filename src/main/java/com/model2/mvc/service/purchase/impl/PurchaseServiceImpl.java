package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {
	
	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	public void setPurchaseDao(PurchaseDao purchaseDao) {
		this.purchaseDao = purchaseDao;
	}
	
	public PurchaseServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addPurchase(Purchase purchase) throws Exception {
				
		purchase.setTranCode("1");
		
		purchaseDao.addPurchase(purchase);
		
		if (purchase.getPaymentOption().trim().equals("1")) {
			purchase.setPaymentOption("현금구매");
		} else if (purchase.getPaymentOption().trim().equals("2")) {
			purchase.setPaymentOption("신용구매");
		}
		
		System.out.println(purchase);
		
	}

	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		return purchaseDao.getPurchase(tranNo);
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search) throws Exception {
		
		List<Purchase> list = purchaseDao.getPurchaseList(search);
		int totalCount = purchaseDao.getTotalCount(search);
		
		//tranCode 변환
		for (Purchase purchase : list) {
		
			if(purchase.getTranCode() == null || purchase.getTranCode().trim().equals("0")){
				purchase.setTranCode("판매중");
			} else if(purchase.getTranCode().trim().equals("1")){
				purchase.setTranCode("구매완료");
			} else if(purchase.getTranCode().trim().equals("2")){
				purchase.setTranCode("배송중");
			} else if(purchase.getTranCode().trim().equals("3")){
				purchase.setTranCode("배송완료");
			}
		}
		
			
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);
	}

	@Override
	public void updateTranCodeByProd(Purchase purchase) throws Exception {
		purchaseDao.updateTranCodePcsToDlv(purchase);
	}
	
	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		purchaseDao.updateTranCodeDlvToRcv(purchase);
	}

}
