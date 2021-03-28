package com.npnc.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.npnc.board.dto.RDto;
import com.npnc.member.dao.MDao;
import com.npnc.member.dto.MDto;
import com.npnc.member.service.MemberService;
@Controller
@RequestMapping("/member")
public class MemberController{
	
	@Autowired
	private MemberService service;
	
	@RequestMapping("/login")
	public String login() {
		return "/member/login";
	}
	@RequestMapping("/leg")
	public void leg() {	
	}
	@RequestMapping("/findid")
	public void findid(){
	}
	@RequestMapping("/findpw")
	public void findpw(){
	}
	@RequestMapping("/del_mem_pop")
	public void del_mem_pop(){
	}
	@RequestMapping("/chgpw_pop")
	public void chgpw_pop(){
	}
	
	@RequestMapping("/doLogin")
	public String doLogin(String id, String pw,HttpSession session,Model model) {
		MDto result  = service.login(id, pw);
		if(result != null) {
			if(result.getUsergrade()==100) {	// 계정 정지인 경우
				model.addAttribute("grade", result.getUsergrade());
				return "member/login";
			}
			session.setAttribute("id", result.getId());
			session.setAttribute("pw", result.getPw());
			session.setAttribute("grade", result.getUsergrade());
			return "redirect:/";
		}else {									//로그인 아이디 또는 비밀번호가 틀린 경우
			model.addAttribute("denied",true);
			return "member/login";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	// 이름, 주민등록번호와 email또는 전화번호로 아이디를 찾음
	@RequestMapping("/doFindid")
	public String doFindid(String name,@RequestParam(value="phonenum",required=false) String phonenum,@RequestParam(value="phonenum",required=false) String email,String idnum,Model model) {
	      String result = service.findId(name,phonenum,email,idnum);
	      model.addAttribute("id",result);
	      return "member/tryfind";
	}
	// 아이디, 주민등록번호, 전화번호로 비밀번호를 찾음
	@RequestMapping("/doFindpw")
	public String doFindpw(String id,String phonenum,String idnum,Model model) {
		int result = service.findPw(id,phonenum,idnum);
		if(result==1) {
			model.addAttribute("id",id);
			return "member/changepw";
		}else {
			model.addAttribute("denied",true);
			return "member/findpw";
		}
	}
	//비밀번호를 찾은 후 비밀번호 변경
	@RequestMapping("/doChangepw")
	public String doChangepw(String id,String pw) {
		service.changePw(id, pw);
		return "redirect:/member/login";
	}
	//회원가입
	@RequestMapping("/doLeg")
	public String doLeg(MDto dto,Model model) {
		int result=service.legMember(dto);
		model.addAttribute("result", result);
		return "member/tryleg"; // 회원가입 성공인지 실패인지 보여주는 페이지
	}
	//마이페이지
	@RequestMapping("/mypage")
	public void mypage(HttpSession session,Model model) {
		MDto result = service.getInfo((String)session.getAttribute("id"));
		model.addAttribute("dto", result);
	}
	@RequestMapping("/update")
	public String update(MDto dto,HttpSession session,RedirectAttributes rAttr) {
		dto.setId((String)session.getAttribute("id"));
		int result = service.update(dto);
		rAttr.addFlashAttribute("result", true);
		return "redirect:/member/mypage";
	}
	//회원탈퇴
	@RequestMapping("/delmember")
	@ResponseBody
	public Map<String, Object> delmember(HttpSession session,String pw) {
		HashMap<String, Object> map = new HashMap<>();
		int result = service.delmember((String)session.getAttribute("id"),pw);
		if(result==1) {
			session.invalidate();
		}
		map.put("result", result);
		return map;
	}
	//회원가입 시 아이디 중복여부 체크
	@RequestMapping("/chkId")
	@ResponseBody
	public Map<String, Object> chkId(String id) {
		HashMap<String, Object> map = new HashMap<>();
		int result = service.chkId(id);
		map.put("result", result);
		return map;
	}
	//마이페이지에서 비밀번호 변경
	@RequestMapping("/chgpw")
	@ResponseBody
	public Map<String, Object> chgpw(String oldpw,String newpw,HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		int result = service.chgpw((String)session.getAttribute("id"),oldpw,newpw);
		map.put("result", result);
		return map;
	}
	
	

}
