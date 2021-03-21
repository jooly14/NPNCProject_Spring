package com.npnc.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
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
import com.npnc.board.service.BoardServiceImpl;
import com.npnc.member.dto.MDto;

@Controller
@RequestMapping({"/","/board"})
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private ServletContext context;
	private String uploadpath = "/resources/upload"; 
	
	@RequestMapping({"/","list"})
	public String list(String type,String keyword,Integer category,
			@RequestParam(value="page",required=false,defaultValue="1")int page,
			@RequestParam(value="psize",required=false,defaultValue="20")int pagesize, Model model,HttpServletRequest request) {
		Map<String, Object> rAttr = (Map<String, Object>) RequestContextUtils.getInputFlashMap(request);  
		Map<String, Object> data = service.getList(type, keyword, (rAttr!=null?(Integer)rAttr.get("category"):category), page, pagesize);
		model.addAllAttributes(data);
		data = service.getGradeList();
		model.addAllAttributes(data);
		data = service.getCategoryList();
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
		//조회수를 쿠키로 처리	//다음날에 쿠키가 사라지도록
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
		
		Map<String, Object> data = service.read(idx);
		model.addAllAttributes(data);
		data = service.getGradeList();
		model.addAllAttributes(data);
		data = service.getCategoryList();
		model.addAllAttributes(data);
		if(session.getAttribute("id")!=null) {
			data = service.doGob(idx,(String)session.getAttribute("id"));
			model.addAllAttributes(data);
		}
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
	public String doUpdate(@RequestParam(value="file", required=false)MultipartFile file,int idx,String title,String content,int category,String savedfile,HttpSession session,RedirectAttributes rAttr) {
		BDto dto = null;
		String contextpath = context.getRealPath("/");
		File path = new File(contextpath,uploadpath);
		if(!path.exists()) {
			path.mkdirs();
		}
		if(savedfile!=null && !savedfile.isEmpty()) {
			File savedfile_ = new File(path,savedfile);
			savedfile_.delete();
		}
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
	public String delete(int idx, int category,RedirectAttributes rAttr) {
		int result = service.delete(idx);
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
	
	@RequestMapping("/deleteReply")
	@ResponseBody
	public Map<String, Object> deleteReply(int ridx,int bidx,HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		List<RDto> newR = service.deleteReply(bidx,ridx,(String)session.getAttribute("id"));
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
}
