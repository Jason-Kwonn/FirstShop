package com.jasonproject.firstshop.service.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.ToString;

import java.sql.Date;
import java.sql.Timestamp;

@Getter
@ToString
@Entity
@Table(name = "users") // table name
public class User {

	///Method
	///Field
	@Id
	@Column(name = "user_id", nullable = false)
	private String userId;
	@Column(name = "user_name", nullable = false)
	private String userName;
	@Column(name = "password", nullable = false)
	private String password;
	@Column(name = "role", columnDefinition = "DEFAULT 'user'")
	private String role;
	@Column(name = "ssn")
	private String ssn;
	@Column(name = "cell_phone")
	private String phone;
	@Column(name = "addr")
	private String addr;
	@Column(name = "email")
	private String email;
	@Column(name = "reg_date")
	private Timestamp regDate;

	@Transient
	private String phone1;
	@Transient
	private String phone2;
	@Transient
	private String phone3;
	@Transient
	private String regDateString;



	///Constructor
	public User(){
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public void setSsn(String ssn) {
		this.ssn = ssn;
	}

	public void setPhone(String phone) {
		this.phone = phone;
		if(phone != null && !phone.isEmpty()){
			phone1 = phone.split("-")[0];
			phone2 = phone.split("-")[1];
			phone3 = phone.split("-")[2];
		}
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;

		if(regDate !=null) {
			this.setRegDateString( regDate.toString().split("-")[0]
					+"-"+ regDate.toString().split("-")[1]
					+ "-" +regDate.toString().split("-")[2] );
		}

	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}

	public void setRegDateString(String regDateString) {
		this.regDateString = regDateString;
	}
}