package com.npnc.member.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.npnc.member.dto.MDto;

public interface MDao {   //회원 관련 DAO
	
	public MDto isMember(@Param("id") String id,@Param("pw") String pw);
	public String findId(@Param("param") HashMap<String, Object> param);
	public Integer findPw(@Param("param") HashMap<String, Object> param);
	public Integer changePw(@Param("id") String id,@Param("pw") String pw);
	public Integer legMember(@Param("dto") MDto dto);
	public MDto getInfo(@Param("id") String id);
	public Integer update(@Param("dto") MDto dto);
	public Integer delmember(@Param("id") String id,@Param("pw") String pw);
	public Integer chkId(@Param("id") String id);
	public Integer chgpw(@Param("param") HashMap<String, Object> param);
	
   
}