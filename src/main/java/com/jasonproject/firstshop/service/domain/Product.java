package com.jasonproject.firstshop.service.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;

import java.sql.Date;
import java.sql.Timestamp;


@Data
@Entity
@Table
public class Product {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "prod_no", nullable = false)
	private int prodNo;
	@Column(name = "prod_name", nullable = false)
	private String prodName;
	@Column(name = "prod_detail")
	private String prodDetail;
	@Column(name = "manufacture_day", nullable = false)
	private Date manuDate;
	@Column(name = "price")
	private int price;
	@Column(name = "quantity", columnDefinition = "int default 0")
	private int stock; // 재고
	@Column(name = "likes", columnDefinition = "int default 0")
	private int likes;
	@Column(name = "see", columnDefinition = "int default 0")
	private int see;
	@Column(name = "image_file")
	private String fileName;
	@CreationTimestamp
	@Column(name = "reg_date", updatable = false)
	private Timestamp regDate;

	@Transient
	private String[] fileNames;
	@Transient
	private String proTranCode;

}