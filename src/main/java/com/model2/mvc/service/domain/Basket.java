package com.model2.mvc.service.domain;

//domain for managing purchase quantity
public class Basket {

    private Long basketId;
    private Long userId; // User.userId
    private Long tranNo; // Purchase.tranNo
    private int purchaseQty;
//    private int moq; // minimum of quantity
    
	public Long getBasketId() {
		return basketId;
	}
	public void setBasketId(Long basketId) {
		this.basketId = basketId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getTranNo() {
		return tranNo;
	}
	public void setTranNo(Long tranNo) {
		this.tranNo = tranNo;
	}
	public int getPurchaseQty() {
		return purchaseQty;
	}
	public void setPurchaseQty(int purchaseQty) {
		this.purchaseQty = purchaseQty;
	}
	
	@Override
	public String toString() {
		return "Basket [basketId=" + basketId + ", userId=" + userId + ", tranNo=" + tranNo + ", purchaseQty="
				+ purchaseQty + "]";
	}
    
}
