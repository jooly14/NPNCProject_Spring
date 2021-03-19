package com.npnc.board.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.sound.midi.Soundbank;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.npnc.board.dao.BDao;
import com.npnc.board.dto.BDto;
import com.npnc.board.dto.CDto;
import com.npnc.board.dto.GDto;
import com.npnc.board.dto.RDto;

@Service
public class BoardServiceImpl implements BoardService {
	public void hello() {
		System.out.println("hello");
	}
	@Autowired
	private BDao dao;
	
	@Override
	public Map<String, Object> getList(String type, String keyword, Integer category, int page,
			int pagesize) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		param.put("category", category);
		param.put("page", (page-1)*pagesize);
		param.put("pagesize", pagesize);
		List<BDto> dtos = dao.getList(param);
		int totalCnt = dao.getCnt(param);
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
		map.put("category", category);	
		return map;
	}
	public Map<String, Object> getGradeList(){
		List<GDto> result_ = dao.getGradeList();
		HashMap<Integer, String> result = new HashMap<>();
		for(GDto g: result_) {
			result.put(g.getGrade(), g.getName());
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("grades", result);
		return map;
	}
	
	public Map<String, Object> getCategoryList() {	//maincategory필드 값을 키 값으로 category테이블 값을 갖고 있는 CDto리스트를 가지고 있는 hashmap
		List<CDto> result_ = dao.getCategoryList();
		 HashMap<String, Vector<CDto>> result = new HashMap<>();
		 for(CDto c:result_) {
			 if(!result.containsKey(c.getMaincategory())) {
				 result.put(c.getMaincategory(),new Vector<CDto>());
			 }
			 result.get(c.getMaincategory()).add(c);
		 }
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clist", result);
		return map;
	}
	public int write(BDto dto) {
		int result = dao.write(dto);
		return result;
	}
	public Map<String, Object> read(int idx){
		Map<String, Object> result = new HashMap<>();
		BDto dto = dao.read(idx);
		result.put("dto", dto);
		result.put("category", dto.getCategory());
		List<RDto> rdto = dao.getReplyList(idx);
		result.put("rdto", rdto);
		return result;
	}
	
	public List<RDto> insertReply(int idx,String id, String content){
		RDto rdto = new RDto(0, idx, id, content, null);
		dao.insertReply(rdto);
		List<RDto> result = dao.getReplyList(idx);
		return result;
	}
}
