package com.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.MemberDTO;
import com.service.MemberSerivce;

@Controller
public class LoginController {
	@Autowired
	MemberSerivce service;

	@RequestMapping(value = "/login")
	public String login(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		System.out.println(map);
		MemberDTO dto = service.login(map); // userid='xxx', passwd='zzzz'
		System.out.println(dto);

		if (dto != null) {// 로그인 된경우
			session.setAttribute("login", dto);
			return "main"; // main.jsp
		} else {// 로그인 안된 경우
			model.addAttribute("mesg", "아이디 또는 비번이 잘못되었습니다.");
			return "loginForm"; // loginForm.jsp
		}
	}
}
