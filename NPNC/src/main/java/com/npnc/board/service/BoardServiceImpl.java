package com.npnc.board.service;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.npnc.board.dao.BDao;
import com.npnc.board.dto.BDto;
import com.npnc.board.dto.CDto;
import com.npnc.board.dto.GDto;
import com.npnc.board.dto.RDto;

@Service
public class BoardServiceImpl implements BoardService {
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
		map.put("category", category);	
		return map;
	}
	
	public Map<String, Object> getGradeList(){
		List<GDto> result_ = dao.getGradeList();
		HashMap<Integer, String> result = new LinkedHashMap<>();
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
	// 게시글 dto(좋아요, 싫어요, 댓글 개수 등) 및 해당 게시글의 카테고리, 댓글 리스트
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
	public List<RDto> updateReply(int ridx,int idx,String id, String content){
		RDto rdto = new RDto(ridx, idx, id, content, null);
		dao.updateReply(rdto);
		List<RDto> result = dao.getReplyList(idx);
		return result;
	}
	public List<RDto> deleteReply(int idx,int ridx,String id,int grade){
		HashMap<String, Object> param = new HashMap<>();
		param.put("ridx", ridx);
		param.put("id", id);
		param.put("grade", grade);
		dao.deleteReply(param);
		List<RDto> result = dao.getReplyList(idx);
		return result;
	}
	
	@Override
	public List<RDto> getReplyList(int idx) {
		List<RDto> result = dao.getReplyList(idx);
		return result;
	}
	
	public int delete(int idx,String id,int grade) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("idx", idx);
		param.put("id", id);
		param.put("grade", grade);
		System.out.println(grade);
		int result = dao.delete(param);
		System.out.println(result);
		return result;
	}
	
	public int update(BDto dto) {
		int result = dao.update(dto);
		return result;
	}
	//조회수 증가
	public void upHit(int idx) {
		dao.upHit(idx);
	}
	// 게시글 조회화면에 해당 회원이 좋아요 및 싫어요를 선택했는지 정보를 제공
	public Map<String, Object> doGob(int idx,String id){
		Integer goodbad = dao.doGob(idx, id);
		Map<String, Object> result = new HashMap<>();
		result.put("goodbad", goodbad);
		return result;
	}
	
	public BDto insertGob(int idx, String id, boolean gob) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("idx", idx);
		param.put("id", id);
		param.put("gob", gob);
		dao.insertGob(param);
		BDto gbresult = dao.getGob(idx);
		return gbresult;
	}
	public BDto updateGob(int idx, String id, boolean gob) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("idx", idx);
		param.put("id", id);
		param.put("gob", gob);
		dao.updateGob(param);
		BDto gbresult = dao.getGob(idx);
		return gbresult;
	}
	public BDto deleteGob(int idx, String id) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("idx", idx);
		param.put("id", id);
		dao.deleteGob(param);
		BDto gbresult = dao.getGob(idx);
		return gbresult;
	}
	
	public Map<String, Object> getAjaxBlist(Integer idx, Integer startRownum, Integer category, Integer pagesize) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("idx", idx);
		param.put("category", category);
		int rownum = -1;
		if(startRownum == null){		//제일 처음 페이지 로딩시 조회 할때
			rownum = dao.getARowCnt(param);			//해당 idx의 게시글이 몇번째에 있는 게시글인지 알아내기(게시글이 있는 위치의 리스트를 보여주기 위해서 필요)
			startRownum = (rownum/5)*5;						//게시글을 rownum 1~5,6~10,11~15 이런식으로 보여주기 위해서 startrownum 사용
			if(rownum%5==0){ 
				startRownum = (rownum/5-1)*5;
			}
		}
		param.put("startRownum", startRownum);
		param.put("endRownum", startRownum + pagesize);
		
		List<BDto> dtos = dao.getAList(param);				//글 목록 가져오기
		int totalcnt = dao.getATotalCnt(param);
		
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("dtos", dtos);
		map.put("totalcnt", totalcnt);
		map.put("startRownum", startRownum);
		map.put("rownum", rownum);
		
		return map;
	}
	
}
