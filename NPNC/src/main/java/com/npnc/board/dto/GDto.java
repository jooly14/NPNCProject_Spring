package com.npnc.board.dto;

public class GDto {
	private int grade;			//회원등급 번호
	private String name;		//등급 이름
	public GDto() {
	}
	public GDto(int grade, String name) {
		this.grade = grade;
		this.name = name;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
