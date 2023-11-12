//package com.jasonproject.firstshop.service.domain;
//
//import jakarta.persistence.*;
//import lombok.Data;
//
//@Data
//@Entity
//@Table(name = "transaction")
//public class Purchase {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    @Column(name = "tran_no", nullable = false)
//    private int tranNo;
//    @ManyToMany // 각각 필요한 정보를 가져와야 해서, 연결 쿼리 지정 필요
//    @JoinColumn(name = "prod_no")
//    private Product purchaseProd;
//    @ManyToOne
//    @JoinColumn(name = "user_pk")
//    private User buyer;
//
//    @Column(name = "quantity")
//    private int purchaseQty;
//}
