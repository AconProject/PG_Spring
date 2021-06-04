package com.controller.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class LoginController {
	@Autowired
	MemberService service;
	
	@RequestMapping(value = "/loginCheck/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		System.out.println("로그아웃 완료 !!!!!!!!!!!!!!!!!!!!!!!!!");
		return "redirect:../"; 
	}
	
	@RequestMapping(value = "/login")
	public String login(@RequestParam HashMap<String, String> map, Model model, HttpSession session) {
		MemberDTO dto = service.login(map);
		System.out.println("로그인 성공 여부"+dto);
		session.setAttribute("login", dto);
		return "Main";
	
	}
}
