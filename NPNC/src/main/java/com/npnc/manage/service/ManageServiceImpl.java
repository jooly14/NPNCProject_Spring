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
		int totalpage = totalCnt/pagesize;		//��ü �Խñ� ����/�� ������ �� �Խñ� ���� = ��ü ������ ����
		if(totalCnt%pagesize!=0){				//�������� �ִ� ��쿡�� �� ������ �� �ʿ�
			totalpage++;
		}
		int pagelistsize = 10;					//����������Ʈ(�Խñ۸���Ʈ �ϴܿ� �ִ� ��������ũ�� �ǹ�) �ѹ��� �������� ������ ����(�������� ������ �̸� �ʰ��ϸ� ������ư�� ������)
		int start = (page/pagelistsize)*pagelistsize+1;	//����������Ʈ�� �����ϴ� ����
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
			if(cntmap.get("id").equals(id)){						//1�� �ۿ� �� ���� �������� ȸ������� �����ϰ��� �ϴ� ��� ���� ���
				return "no";
			}
		}
		dao.chgMemGrade(id,grade);
		return "yes";
	} 
}
