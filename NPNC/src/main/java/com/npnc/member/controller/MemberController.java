package com.npnc.member.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@RequestMapping("/doLogin")
	public String doLogin(String id, String pw,HttpSession session,Model model) {
		MDto result  = service.login(id, pw);
		if(result != null) {
			if(result.getUsergrade()==100) {
				model.addAttribute("grade", result.getUsergrade());
				return "member/login";
			}
			session.setAttribute("id", result.getId());
			session.setAttribute("pw", result.getPw());
			session.setAttribute("grade", result.getUsergrade());
			return "redirect:/";
		}else {
			model.addAttribute("denied",true);
			return "member/login";
		}
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	@RequestMapping("/doFindid")
	public String doFindid(String name,@RequestParam(value="phonenum",required=false) String phonenum,@RequestParam(value="phonenum",required=false) String email,String idnum,Model model) {
	      String result = service.findId(name,phonenum,email,idnum);
	      model.addAttribute("id",result);
	      return "member/tryfind";
	}
	@RequestMapping("/doFindpw")
	public String doFindpw(String id,String phonenum,String idnum,Model model) {
		int result = service.findPw(id,phonenum,idnum);
		if(result==1) {
			return "member/changepw";
		}else {
			model.addAttribute("denied",true);
			return "member/findpw";
		}
	}
	@RequestMapping("/doChangepw")
	public String doChangepw(String id,String pw) {
		service.changePw(id, pw);
		return "redirect:/member/login";
	}
	@RequestMapping("/doLeg")
	public String doLeg(MDto dto,Model model) {
		int result=service.legMember(dto);
		model.addAttribute("result", result);
		return "member/tryleg"; // 회원가입 성공인지 실패인지 보여주는 페이지
	}
	@RequestMapping("/mypage")
	public void mypage(HttpSession session,Model model) {
		MDto result = service.getInfo((String)session.getAttribute("id"));
		model.addAttribute("dto", result);
	}
	@RequestMapping("/update")
	public String update(MDto dto,RedirectAttributes rAttr) {
		int result = service.update(dto);
		rAttr.addFlashAttribute("result", true);
		return "redirect:/member/mypage";
	}
	@RequestMapping("/delmember")
	public String delmember(HttpSession session, RedirectAttributes rAttr) {
		int result = service.delmember((String)session.getAttribute("id"));
		if(result==1) {
			rAttr.addFlashAttribute("delmember", true);
		}
		session.invalidate();
		return "redirect:/board/";
	}
	
	
	/*
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String viewpage="";							//이동할 jsp 페이지
		String cmd = request.getParameter("cmd");	//사용자 요청 기능
		CommandHandler handler = null;
		if(cmd.equals("leg")){
			handler = new MLegHandler();	//cmd파라미터에 맞는 handler생성
		}else if(cmd.equals("login")){
			handler = new MLoginHandler();	
		}else if(cmd.equals("logout")){
			handler = new MLogoutHandler();
			handler.process(request, response);
			response.sendRedirect("board");
			return;
		}else if(cmd.equals("update")){
			handler = new MInfoUpdateHandler();
			viewpage = handler.process(request, response);
			response.sendRedirect(viewpage);
			return;
		}else if(cmd.equals("delmember")){
			handler = new MDelmemberHandler();	
			viewpage = handler.process(request, response);
			response.sendRedirect(viewpage);
			return;
		}else if(cmd.equals("findid")){
			handler = new MFindIdHandeler();	
		}else if(cmd.equals("findpw")){
			handler = new MFindPwHandler();	
		}else if(cmd.equals("changepw")){
			handler = new MChangePwHandler();	
		}else {
			
		}
		viewpage = handler.process(request,response);	//dao 호출 및 필요 기능 실행하고 jsp페이지 받아오기
		CommandHandler clistHandler = new CListHandler();	//모든 페이지에 카테고리를 불러와야되기 때문에
		clistHandler.process(request, response);
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewpage);
		dispatcher.forward(request, response);
	}*/

}
