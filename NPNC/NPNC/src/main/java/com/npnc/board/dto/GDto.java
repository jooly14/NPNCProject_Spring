package com.npnc.board.dto;

public class GDto {
	private int grade;
	private String name;
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
