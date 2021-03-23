package com.npnc.member.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.npnc.member.dao.MDao;
import com.npnc.member.dto.MDto;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MDao dao;
	
	public MDto login(String id, String pw) {
		MDto result = dao.isMember(id,pw);
		return result;
	}
	public String findId(String name,String phonenum,String email,String idnum) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("name", name);
		param.put("phonenum", phonenum);
		param.put("email", email);
		param.put("idnum", idnum);
		String id = dao.findId(param);
		return id;
	}
	public int findPw(String id,String phonenum,String idnum) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("phonenum", phonenum);
		param.put("idnum", idnum);
		int result = dao.findPw(param);
		return result;
	}
	public int changePw(String id, String pw) {
		int result = dao.changePw(id, pw);
		return result;
	}
	public int legMember(MDto dto) {
		int result = dao.legMember(dto);
		return result;
	}
	public MDto getInfo(String id) {
		MDto result = dao.getInfo(id);
		return result;
	}
	public int update(MDto dto) {
		int result = dao.update(dto);
		return result;
	} 
	public int delmember(String id) {
		int result = dao.delmember(id);
		return result;
	}
}
