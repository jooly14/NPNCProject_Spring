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
	public List<RDto> updateReply(int ridx,int idx,String id, String content);
	public List<RDto> deleteReply(int idx,int ridx,String id,int grade);
	public List<RDto> getReplyList(int idx);
	public int delete(int idx,String id,int grade);
	public int update(BDto dto);
	public void upHit(int idx);
	public Map<String, Object> doGob(int idx,String id);
	public BDto insertGob(int idx, String id, boolean gob);
	public BDto deleteGob(int idx, String id);
	public BDto updateGob(int idx, String id, boolean gob);
	public Map<String, Object> getAjaxBlist(Integer idx,Integer startRownum, Integer category, Integer pagesize);
}
