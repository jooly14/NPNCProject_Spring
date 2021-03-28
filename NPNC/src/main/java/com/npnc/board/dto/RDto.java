package com.npnc.board.dto;

import java.sql.Timestamp;

public class RDto {
	
	private int ridx;					//댓글 idx
	private int bidx;					//게시글 idx
	private String id;					//회원 아이디
	private String content;				//댓글 내용
	private Timestamp regDate;			//등록일
	
	
	
	
	public RDto(int ridx, int bidx, String id, String content, Timestamp regDate) {
		super();
		this.ridx = ridx;
		this.bidx = bidx;
		this.id = id;
		this.content = content;
		this.regDate = regDate;
	}
	
	public RDto() {}

	public int getRidx() {
		return ridx;
	}
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setRidx(int ridx) {
		this.ridx = ridx;
	}
	public int getBidx() {
		return bidx;
	}
	public void setBidx(int bidx) {
		this.bidx = bidx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	
	

	@Override
	public String toString() {
		return "RDto [ridx=" + ridx + ", bidx=" + bidx + ", content=" + content + ", regDate=" + regDate + "]";
	}
}
