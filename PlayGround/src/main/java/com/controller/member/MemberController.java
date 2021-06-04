package com.controller.member;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	MemberService service;

	@RequestMapping(value = "/loginCheck/myPage")
	public String myPage(HttpSession session) {
		MemberDTO dto = (MemberDTO)session.getAttribute("login");
		String userid= dto.getMbrId();
		dto= service.mypage(userid);
		session.setAttribute("login", dto); //해당라인없으면, 변경되는 값이 저장되지 않음. 
		return "redirect:../MyPage";	
	}
	
	@RequestMapping(value = "/loginCheck/updatePage")
	public String updatePage(HttpSession session) {
		MemberDTO dto = (MemberDTO)session.getAttribute("login");
		String userid= dto.getMbrId();
		dto= service.mypage(userid);
		return "redirect:../memberUpdate";	
	}

	@RequestMapping(value="/loginCheck/memberUpdate")
	public String memberUpdate(MemberDTO m) {
		System.out.println("memberUpdate====="+ m);
		System.out.println("update하는중입니다@@@@@@@@@@@@@@@@@@@@@@@@@@");
		service.memberUpdate(m);
		return "redirect:../";
	}
	
	@RequestMapping(value = "/memberAdd")
	public String memberAdd(MemberDTO m,Model model) {
		service.memberAdd(m);
		model.addAttribute("success", "회원가입성공");
		return "Main";
	}
}
