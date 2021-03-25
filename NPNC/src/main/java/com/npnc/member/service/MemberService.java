package com.npnc.member.service;

import com.npnc.board.dto.BDto;
import com.npnc.member.dto.MDto;

public interface MemberService {
	public MDto login(String id, String pw);
	public String findId(String name,String phonenum,String email,String idnum);
	public int findPw(String id,String phonenum,String idnum);
	public int changePw(String id, String pw);
	public int legMember(MDto dto);
	public MDto getInfo(String id);
	public int update(MDto dto);
	public int delmember(String id,String pw);
	public int chkId(String id);
	public int chgpw(String id, String oldpw, String newpw);
}
