package com.npnc.member.dto;

public class MDto {
	private String id;				//아이디
	private String pw;				//비밀번호
	private String name;			//이름
	private String idnum;			//주민등록번호
	private String email;			//이메일
	private String address;			//주소
	private String phonenum;		//전화번호
	private int usergrade;			//회원등급
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIdnum() {
		return idnum;
	}
	public void setIdnum(String idnum) {
		this.idnum = idnum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhonenum() {
		return phonenum;
	}
	public void setPhonenum(String phonenum) {
		this.phonenum = phonenum;
	}
	public int getUsergrade() {
		return usergrade;
	}
	public void setUsergrade(int usergrade) {
		this.usergrade = usergrade;
	}
}
