package com.npnc.board.service;

import java.util.List;
import java.util.Map;

import com.npnc.board.dto.BDto;
import com.npnc.board.dto.RDto;

public interface BoardService {
	public Map<String, Object> getList(String type,String keyword,Integer category,int page,int pagesize);
	public Map<String, Object> getGradeList();
	public Map<String, Object> getCategoryList();
	public int write(BDto dto);
	public Map<String, Object> read(int idx);
	public List<RDto> insertReply(int idx,String id, String content);
}
