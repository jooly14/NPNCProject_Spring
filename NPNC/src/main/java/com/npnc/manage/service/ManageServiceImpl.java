package com.npnc.manage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.npnc.board.dto.CDto;
import com.npnc.manage.dao.MgrDao;
import com.npnc.member.dto.MDto;

@Service
public class ManageServiceImpl implements ManageService {
	
	@Autowired
	MgrDao dao;

	public int moveCategory(int idx, int category) {
		return dao.moveCategory(idx, category);
	}
	
	public int onepassdelete(String delIdxs) {
		return dao.onepassdel(delIdxs);
	}
	
	
	public HashMap<String, Vector<CDto>> getCategoryList(){
		List<CDto> result_ = dao.getCategoryList();
		 HashMap<String, Vector<CDto>> result = new HashMap<>();
		 for(CDto c:result_) {
			 if(!result.containsKey(c.getMaincategory())) {
				 result.put(c.getMaincategory(),new Vector<CDto>());
			 }
			 result.get(c.getMaincategory()).add(c);
		 }
		return result;
	}
	
	public int deleteMainCategory(String maincategory) {
		return dao.deleteMainCategory(maincategory);
	}
	
	public int deleteCategory(int idx) {
		return dao.deleteCategory(idx);
	}
	
	public int moveAllCategory(int newca, int old) {
		return dao.moveAllCategory(newca, old);
	}
	
	public int chgRWgrade(int idx, String rw, int grade) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("idx", idx);
		param.put("rw", rw);
		param.put("grade", grade);
		return dao.chgRWgrade(param);
	}
	
	public int addCategory(CDto dto) {
		return dao.addCategory(dto);
	}
	
	public Map<String, Object> getMemberList(String type,String keyword,int page,int pagesize) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		param.put("page", (page-1)*pagesize);
		param.put("pagesize", pagesize);
		List<MDto> dtos = dao.getMemberList(param);
		int totalCnt = dao.getMemberCnt(param);
		int totalpage = totalCnt/pagesize;		//전체 게시글 개수/한 페이지 당 게시글 개수 = 전체 페이지 개수
		if(totalCnt%pagesize!=0){				//나머지가 있는 경우에는 한 페이지 더 필요
			totalpage++;
		}
		int pagelistsize = 10;					//페이지리스트(게시글리스트 하단에 있는 페이지링크를 의미) 한번에 보여지는 페이지 개수(총페이지 개수가 이를 초과하면 다음버튼이 생성됨)
		int start = (page/pagelistsize)*pagelistsize+1;	//페이지리스트에 시작하는 숫자
		if(page%pagelistsize==0){
			start = (page/pagelistsize-1)*pagelistsize+1;
		}
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("dtos", dtos);
		map.put("page", page);
		map.put("totalcnt", totalCnt);	
		map.put("totalpage", totalpage);
		map.put("pagesize", pagesize);
		map.put("start", start);
		map.put("end", start+pagelistsize-1);
		map.put("type", type);	
		map.put("keyword", keyword);
		
		return map;
	}
	
	public String chgMemGrade(String id, int grade) {
		HashMap<String, Object> cntmap = dao.getManagerCnt();
		if((Long)cntmap.get("cnt")==1) {
			if(cntmap.get("id").equals(id)){						//1명 밖에 안 남은 관리자의 회원등급을 변경하고자 하는 경우 변경 취소
				return "no";
			}
		}
		dao.chgMemGrade(id,grade);
		return "yes";
	} 
}
