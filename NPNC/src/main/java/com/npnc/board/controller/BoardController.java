package com.npnc.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.npnc.board.dto.BDto;
import com.npnc.board.dto.RDto;
import com.npnc.board.service.BoardService;

@Controller
@RequestMapping({"/","/board"})
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private ServletContext context;
	private String uploadpath = "/resources/upload"; 
	
	
	//do�� ������ ������ ó���� �ϰ� �� ������ ȭ���� ������
	@RequestMapping({"/","list"})
	public String list(String type,String keyword,Integer category,
			@RequestParam(value="page",required=false,defaultValue="1")int page,
			@RequestParam(value="psize",required=false,defaultValue="20")int pagesize, Model model,HttpServletRequest request) {
		Map<String, Object> rAttr = (Map<String, Object>) RequestContextUtils.getInputFlashMap(request);  									//doWrite ���� �����̷�Ʈ�� ī�װ� �޾ƿ�
		Map<String, Object> data = service.getList(type, keyword, (rAttr!=null?(Integer)rAttr.get("category"):category), page, pagesize);	//�Խñ� ����Ʈ �޾ƿ���
		model.addAllAttributes(data);
		data = service.getGradeList();																										//ȸ����� ����Ʈ �޾ƿ���
		model.addAllAttributes(data);
		data = service.getCategoryList();																									//ī�װ� ����Ʈ �޾ƿ���
		model.addAllAttributes(data);
		return "board/list";
	}
	
	@RequestMapping("/write")
	public void write(String category,Model model) {
		model.addAttribute("category",category);
		Map<String, Object> data = service.getGradeList();
		model.addAllAttributes(data);
		data = service.getCategoryList();
		model.addAllAttributes(data);
	}
	
	@RequestMapping("/read")
	public String read(int idx,Model model,@CookieValue(value="hit", required=false) Cookie hit,HttpServletResponse response,HttpSession session) {
		//��ȸ���� ��Ű�� ó��	//�������� ��Ű�� ���������
		Cookie hitC = null;
		if(hit==null) {
			hitC = new Cookie("hit", idx+"");
			service.upHit(idx);
		}else {
			String tmp_hit = hit.getValue();
			List<String> idx_list = (List<String>) Arrays.asList(tmp_hit.split("/"));
			if(!idx_list.contains(idx+"")) {
				service.upHit(idx);
				tmp_hit += "/" + idx;
			}
			hitC = new Cookie("hit", tmp_hit);
		}
		Calendar tomorrow = Calendar.getInstance();
		tomorrow.set(Calendar.DATE, 1);
		tomorrow.set(Calendar.HOUR, 0);
		tomorrow.set(Calendar.MINUTE, 0);
		tomorrow.set(Calendar.SECOND, 0);
		Calendar now = Calendar.getInstance();
		int diff = (int)(tomorrow.getTimeInMillis() - now.getTimeInMillis());
		hitC.setMaxAge(diff/1000);
		response.addCookie(hitC);
		
		Map<String, Object> data = service.read(idx);						// �Խñ� dto,���ƿ� �� �Ⱦ�� ����, ī�װ�, ��� ����Ʈ �� ��� ���� ������
		model.addAllAttributes(data);
		data = service.getGradeList();
		model.addAllAttributes(data);
		data = service.getCategoryList();
		model.addAllAttributes(data);
		if(session.getAttribute("id")!=null) {
			data = service.doGob(idx,(String)session.getAttribute("id"));	//�ش� ���̵� ���ƿ� �� �Ⱦ�並 �ߴ��� �˾Ƴ�
			model.addAllAttributes(data);
		}
		model.addAttribute("uploadpath", uploadpath);						//���� �ٿ�ε尡 �����ϵ��� ���� ��θ� ����
		return "board/read";
	}
	
	@RequestMapping("/update")
	public String update(int idx,Model model) {
		Map<String, Object> data = service.read(idx);
		model.addAllAttributes(data);
		data = service.getGradeList();
		model.addAllAttributes(data);
		data = service.getCategoryList();
		model.addAllAttributes(data);
		return "board/update";
	}
	
	@RequestMapping("/doUpdate")
	public String doUpdate(@RequestParam(value="file", required=false)MultipartFile file,@RequestParam(value="noUpdatefile", required=false) String noUpdatefile,int idx,String title,String content,int category,String savedfile,HttpSession session,RedirectAttributes rAttr) {
		BDto dto = null;
		String contextpath = context.getRealPath("/");
		File path = new File(contextpath,uploadpath);
		if(!path.exists()) {
			path.mkdirs();
		}
		// ������ ����� ������ ������ ������ ���� �� ���� ����
		if(savedfile!=null && !savedfile.isEmpty()) {
			if(file!=null) {
				File savedfile_ = new File(path,savedfile);
				savedfile_.delete();
			}
		}
		if(file!=null) {
			if(file.getOriginalFilename()!=null&&!file.getOriginalFilename().isEmpty()) {
				String uuid = UUID.randomUUID().toString();
				try {
					file.transferTo(new File(path.getAbsolutePath(),uuid+"_"+file.getOriginalFilename()));
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				dto = new BDto(idx, title, (String)session.getAttribute("id"), content, null, 0, file.getOriginalFilename(),uuid+"_"+file.getOriginalFilename(), category, 0, 0, null, 0);
				
			}else {
				dto = new BDto(idx, title, (String)session.getAttribute("id"), content, null, 0, null ,null, category, 0, 0, null, 0);
			}
		}else if(noUpdatefile!=null){
			dto = new BDto(idx, title, (String)session.getAttribute("id"), content, null, 0, noUpdatefile ,savedfile, category, 0, 0, null, 0);
		}else {
			dto = new BDto(idx, title, (String)session.getAttribute("id"), content, null, 0, null ,null, category, 0, 0, null, 0);
		}
		int result = service.update(dto);
		rAttr.addAttribute("idx", dto.getIdx());
		return "redirect:/board/read";
	}
	
	@RequestMapping("/doWrite")
	public String doWrite(MultipartFile file,String title,String content,int category,HttpSession session,RedirectAttributes rAttr) {
		BDto dto = null;
		if(file.getOriginalFilename()!=null&&!file.getOriginalFilename().isEmpty()) {
			String contextpath = context.getRealPath("/");
			File path = new File(contextpath,uploadpath);
			if(!path.exists()) {
				path.mkdirs();
			}
			String uuid = UUID.randomUUID().toString();
			try {
				file.transferTo(new File(path.getAbsolutePath(),uuid+"_"+file.getOriginalFilename()));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			dto = new BDto(0, title, (String)session.getAttribute("id"), content, null, 0, file.getOriginalFilename(),uuid+"_"+file.getOriginalFilename(), category, 0, 0, null, 0);
		}else {
			dto = new BDto(0, title, (String)session.getAttribute("id"), content, null, 0, null ,null, category, 0, 0, null, 0);
		}
		int result = service.write(dto);
		rAttr.addFlashAttribute("category", dto.getCategory());
		return "redirect:/board/";
	}
	
	@RequestMapping("/delete")
	public String delete(int idx, int category,RedirectAttributes rAttr,HttpSession session) {
		int result = service.delete(idx,(String)session.getAttribute("id"),(int)session.getAttribute("grade"));
		if(result == 1) {
			rAttr.addFlashAttribute("category", category);
			rAttr.addFlashAttribute("delete", true);
		}
		return "redirect:/board/";
	}
	
	@RequestMapping("/insertReply")
	@ResponseBody
	public Map<String, Object> insertReply(String reply,int bidx,HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		List<RDto> newR = service.insertReply(bidx,(String)session.getAttribute("id"),reply);
		map.put("newR", newR);
		return map;
	}
	
	@RequestMapping("/updateReply")
	@ResponseBody
	public Map<String, Object> updateReply(String content,int ridx,int bidx,HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		List<RDto> newR = service.updateReply(ridx,bidx,(String)session.getAttribute("id"),content);
		map.put("newR", newR);
		return map;
	}
	@RequestMapping("/getReplyList")
	@ResponseBody
	public Map<String, Object> getReplyList(int bidx,HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		List<RDto> newR = service.getReplyList(bidx);
		map.put("newR", newR);
		return map;
	}
	
	@RequestMapping("/deleteReply")
	@ResponseBody
	public Map<String, Object> deleteReply(int ridx,int bidx,HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		List<RDto> newR = service.deleteReply(bidx,ridx,(String)session.getAttribute("id"),(int)session.getAttribute("grade"));
		map.put("newR", newR);
		return map;
	}
	
	@RequestMapping("/insertGob")
	@ResponseBody
	public Map<String, Object> insertGob(int idx,boolean gob,HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		BDto gbresult = service.insertGob(idx,(String)session.getAttribute("id"),gob);
		map.put("gbresult", gbresult);
		map.put("dogob", "insert");
		map.put("goodbad", gob);
		return map;
	}
	@RequestMapping("/updateGob")
	@ResponseBody
	public Map<String, Object> updateGob(int idx,boolean gob,HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		BDto gbresult = service.updateGob(idx,(String)session.getAttribute("id"),gob);
		map.put("gbresult", gbresult);
		map.put("dogob", "update");
		map.put("goodbad", gob);
		return map;
	}
	@RequestMapping("/deleteGob")
	@ResponseBody
	public Map<String, Object> deleteGob(int idx,HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		BDto gbresult = service.deleteGob(idx,(String)session.getAttribute("id"));
		map.put("gbresult", gbresult);
		map.put("dogob", "delete");
		return map;
	}
	
	//�Խñ� �б� ������ �ϴܿ� �Խñ� ����Ʈ�� ajax�� ����
	@RequestMapping("/rblist")
	@ResponseBody
	public Map<String, Object> getAjaxBlist(Integer idx,Integer startRownum, Integer category) {
		int pagesize = 5;								//�� �������� ������ �Խñ� ����
		Map<String, Object> result = service.getAjaxBlist(idx,startRownum,category,pagesize);
		int curpage = (Integer)result.get("startRownum")/5+1;												//����������(����¡  ���ؼ�)
		int totalpage = (Integer)result.get("totalcnt")/pagesize;		//��ü �Խñ� ����/�� ������ �� �Խñ� ���� = ��ü ������ ����
		if((Integer)result.get("totalcnt")%pagesize!=0){				//�������� �ִ� ��쿡�� �� ������ �� �ʿ�
			totalpage++;
		}
		int pagelistsize = 5;					//����¡:����������Ʈ(�Խñ۸���Ʈ �ϴܿ� �ִ� ��������ũ�� �ǹ�) �ѹ��� �������� ������ ����(�������� ������ �̸� �ʰ��ϸ� ������ư�� ������)
		int start = (curpage/pagelistsize)*pagelistsize+1;	//����������Ʈ�� �����ϴ� ����
		if(curpage%pagelistsize==0){
			start = (curpage/pagelistsize-1)*pagelistsize+1;
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("pagesize", pagesize);
		map.put("rownum", result.get("rownum"));
		map.put("startRownum", result.get("startRownum"));
		map.put("dtos", result.get("dtos"));	//��ü�� json��ü�� �������ִ� Gson - jar�� ���� �߰�����
		map.put("curpage", curpage);
		map.put("totalpage", totalpage);
		map.put("start", start);
		map.put("end", start+pagelistsize-1);
		return map;
	}
}
