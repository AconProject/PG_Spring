package com.controller.member;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class LoginController {
	@Autowired
	MemberService service;
	@Autowired
	BCryptPasswordEncoder pwdEncoder;

	@RequestMapping(value = "/loginCheck/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		System.out.println("로그아웃 완료 !!!!!!!!!!!!!!!!!!!!!!!!!");
		return "redirect:../";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@RequestParam HashMap<String, String> map, Model model, HttpSession session) {
		System.out.println("Map의 값입니다: " + map);
		MemberDTO dbDTO = service.login(map.get("mbrId")); 
		session.setAttribute("login", dbDTO);
		String dbPassword=dbDTO.getMbrPw();
		System.out.println(dbPassword);
		boolean pwdEqual=pwdEncoder.matches(map.get("mbrPw"), dbPassword);
		System.out.println("패스워드 비교 결과: "+pwdEqual);
		if(pwdEqual) {
			dbDTO.setMbrPw(map.get("mbrPw"));
			System.out.println("암호해제된 DTO: "+dbDTO.toString());
			//45번째 줄, jsp에서 사용하기 위해서는 session에 암호화된 암호가 아닌, 입력한 암호(암호화되지 않은 암호) 저장
		}
		   return "Main";
		 
	}
}
