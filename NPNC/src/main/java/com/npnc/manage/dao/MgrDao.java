package com.npnc.manage.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.npnc.board.dto.BDto;
import com.npnc.board.dto.CDto;
import com.npnc.member.dto.MDto;

public interface MgrDao {
	
	public int moveCategory(@Param("idx") int idx,@Param("category") int category);
	public int onepassdel(@Param("delIdxs") String delIdxs);
	public List<CDto> getCategoryList();
	public int deleteMainCategory(@Param("maincategory") String maincategory);
	public int deleteCategory(@Param("idx") int idx);
	public int moveAllCategory(@Param("newca")int newca, @Param("old") int old);
	public int chgRWgrade(@Param("param") HashMap<String, Object> param);
	public int addCategory(@Param("dto") CDto dto);
	public List<MDto> getMemberList(@Param("param") HashMap<String, Object> param);
	public int getMemberCnt(@Param("param") HashMap<String, Object> param);
	public HashMap<String, Object> getManagerCnt();
	public int chgMemGrade(@Param("id") String id, @Param("grade") int grade);
}
