package com.npnc.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.npnc.board.dto.BDto;
import com.npnc.board.dto.RDto;
import com.npnc.board.service.BoardServiceImpl;
import com.npnc.member.dto.MDto;

@Controller
@RequestMapping({"/","/board"})
public class BoardController {
	
	@Autowired
	private BoardServiceImpl service;
	
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
	public String read(int idx,Model model) {
		Map<String, Object> data = service.read(idx);
		model.addAllAttributes(data);
		data = service.getGradeList();
		model.addAllAttributes(data);
		data = service.getCategoryList();
		model.addAllAttributes(data);
		return "board/read";
	}
	@RequestMapping("/doWrite")
	public String doWrite(MultipartFile file,String title,String content,int category,HttpSession session,RedirectAttributes rAttr) {
		BDto dto = null;
		if(file!=null) {
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
	@RequestMapping("/insertReply")
	@ResponseBody
	public Map<String, Object> insertReply(String reply,int bidx,HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		List<RDto> newR = service.insertReply(bidx,(String)session.getAttribute("id"),reply);
		map.put("newR", newR);
		return map;
    	
	}
}
