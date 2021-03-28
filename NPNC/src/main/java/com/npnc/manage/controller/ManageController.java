package com.npnc.manage.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.npnc.board.dto.CDto;
import com.npnc.board.service.BoardService;
import com.npnc.manage.dao.MgrDao;
import com.npnc.manage.service.ManageService;

@Controller
@RequestMapping("/manage")
public class ManageController {
	@Autowired
	private ManageService service;
	@Autowired
	private BoardService bservice;
	
	//게시글 관리
	@RequestMapping({"/","/blist"})
	public String blist(String type,String keyword,Integer category,
			@RequestParam(value="page",required=false,defaultValue="1")int page,
			@RequestParam(value="psize",required=false,defaultValue="20")int pagesize, Model model,HttpServletRequest request) {
		Map<String, Object> rAttr = (Map<String, Object>) RequestContextUtils.getInputFlashMap(request);  
		Map<String, Object> data = bservice.getList(type, keyword, (rAttr!=null?(Integer)rAttr.get("category"):category), page, pagesize);
		model.addAllAttributes(data);
		data = bservice.getGradeList();
		model.addAllAttributes(data);
		data = bservice.getCategoryList();
		model.addAllAttributes(data);
		return "manage/blist";
	}
	
	@RequestMapping("/move_category_pop")
	public void move_category_pop() {
	}
	@RequestMapping("/move_all_pop")
	public void move_all_pop() {
	}
	//게시글의 카테고리 변경
	@RequestMapping("/movecategory")
	public String movecategory(int idx, int category) {
		int result = service.moveCategory(idx, category);
		return "manage/move_complete";
	}
	//일괄 삭제
	@RequestMapping("/onepassdel")
	public String onepassdel(int[] del_idx, String type,String keyword,Integer category,
			@RequestParam(value="page",required=false,defaultValue="1")int page,
			@RequestParam(value="psize",required=false,defaultValue="20")int pagesize, RedirectAttributes rAttr) {
		String del_idxs ="";
//		일괄 삭제이므로 받아온 여러개의 글 번호 값을 정리해서 dao에 전달
		for(int i=0;i<del_idx.length;i++){
			if(i==0){
				del_idxs = del_idx[i]+"";
			}
			del_idxs += ","+del_idx[i];
		}
		System.out.println(page+"/"+pagesize);
		int result = service.onepassdelete(del_idxs);
		if(type!=null&&!type.isEmpty()){
			rAttr.addAttribute("type",type);
		}
		if(keyword!=null&&!keyword.isEmpty()){
			rAttr.addAttribute("keyword",keyword);
		}
		if(page != 1){
			rAttr.addAttribute("page",page);
		}
		if(pagesize != 20){
			rAttr.addAttribute("psize",pagesize);
		}
		if(category!=null){
			rAttr.addAttribute("category",category);
		}
		return "redirect:/manage/blist";
	}
	// 카테고리 관리
	@RequestMapping("/clist")
	public String clist(Model model) {
		Map<String, Object> data = bservice.getGradeList();
		model.addAllAttributes(data);
		model.addAttribute("clist", service.getCategoryList());
		return "/manage/clist";
	}
	//메인카테고리 삭제
	@RequestMapping("/delmainc")
	public String delmaincategory(String name) {
		String maincategory = "";
		try {
			maincategory = URLDecoder.decode(name,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int result = service.deleteMainCategory(maincategory);
		return "redirect:/manage/clist";
	}
	//카테고리 삭제
	@RequestMapping("/delc")
	public String delCategory(int idx) {
		int result = service.deleteCategory(idx);
		return "redirect:/manage/clist";
	}
	//특정 카테고리 게시글 전체 이동
	@RequestMapping("/moveall")
	public String moveall(@RequestParam("idx") int old, @RequestParam("category") int newca) {
		service.moveAllCategory(newca, old);
		return "manage/move_complete";
	}
	//카테고리의 읽기, 쓰기권한 변경
	@RequestMapping("/chgRWgrade")
	@ResponseBody
	public Map<String, Object> chgRWgrade(int idx, String rw, int grade) {
		HashMap<String, Object> map = new HashMap<>();
		
		if(rw.equals("r")){
			rw = "readgrade";
		}else{
			rw = "writegrade";
		} 
		int result = service.chgRWgrade(idx,rw, grade);
		return map;
	}
	//회원등급 변경
	@RequestMapping("/chgMemGrade")
	@ResponseBody
	public Map<String, Object> chgMemGrade(String id, int grade) {
		HashMap<String, Object> map = new HashMap<>();
		String result = service.chgMemGrade(id,grade);
		map.put("sign", result);
		return map;
	}
	//카테고리 추가
	@RequestMapping("/addcategory")
	public String addcategory(String name, int readgrade, int writegrade, String maincategory) {
		CDto dto = new CDto(0, maincategory, name, readgrade, writegrade,0);
		service.addCategory(dto);
		return "redirect:/manage/clist";
	}
	//회원 관리
	@RequestMapping("/mlist")
	public String mlist(String type,String keyword,
			@RequestParam(value="page",required=false,defaultValue="1")int page,
			@RequestParam(value="psize",required=false,defaultValue="20")int pagesize, Model model,HttpServletRequest request) {
		
		Map<String, Object> data = service.getMemberList(type,keyword,page,pagesize);
		model.addAllAttributes(data);
		data = bservice.getGradeList();
		model.addAllAttributes(data);
		return "manage/mlist";
	}
	
}
