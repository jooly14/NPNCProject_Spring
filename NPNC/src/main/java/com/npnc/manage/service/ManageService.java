package com.npnc.manage.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import com.npnc.board.dto.CDto;

public interface ManageService {
	public int moveCategory(int idx, int category);
	public int onepassdelete(String delIdxs);
	public HashMap<String, Vector<CDto>> getCategoryList();
	public int deleteMainCategory(String maincategory);
	public int deleteCategory(int idx);
	public int moveAllCategory(int newca, int old);
	public int chgRWgrade(int idx, String rw, int grade);
	public int addCategory(CDto dto);
	public Map<String, Object> getMemberList(String type,String keyword,int page,int pagesize);
	public String chgMemGrade(String id, int grade);
}
