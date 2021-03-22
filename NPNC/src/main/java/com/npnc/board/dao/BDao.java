package com.npnc.board.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.npnc.board.dto.BDto;
import com.npnc.board.dto.CDto;
import com.npnc.board.dto.GDto;
import com.npnc.board.dto.RDto;

public interface BDao {
	
	public List<BDto> getList(@Param("param") HashMap<String, Object> param);
	public int getCnt(@Param("param") HashMap<String, Object> param);
	public List<GDto> getGradeList();
	public List<CDto> getCategoryList();
	public int write(@Param("dto") BDto dto);
	public BDto read(@Param("idx") int idx);
	public List<RDto> getReplyList(@Param("idx") int idx);
	public int insertReply(@Param("rdto") RDto rdto);
	public int updateReply(@Param("rdto") RDto rdto);
	public int deleteReply(@Param("param") HashMap<String, Object> param);
	public int delete(@Param("param") HashMap<String, Object> param);
	public int update(@Param("dto") BDto dto);
	public void upHit(@Param("idx") int idx);
	public Integer doGob(@Param("idx") int idx,@Param("id") String id);
	public void insertGob(@Param("param") HashMap<String, Object> param);
	public void updateGob(@Param("param") HashMap<String, Object> param);
	public void deleteGob(@Param("param") HashMap<String, Object> param);
	public BDto getGob(@Param("idx") int idx);
	public int getARowCnt(@Param("param") HashMap<String, Object> param);
	public List<BDto> getAList(@Param("param") HashMap<String, Object> param);
	public int getATotalCnt(@Param("param") HashMap<String, Object> param);
}
