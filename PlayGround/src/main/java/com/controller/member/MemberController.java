package com.controller.member;

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
public class MemberController {
	@Autowired
	MemberService service;

	@RequestMapping(value = "/loginCheck/myPage")
	public String myPage(HttpSession session) {
		MemberDTO dto = (MemberDTO) session.getAttribute("login");
		String userid = dto.getMbrId();
		dto = service.mypage(userid);
		session.setAttribute("login", dto); // 해당라인없으면, 변경되는 값이 저장되지 않음.
		return "redirect:../MyPage";
	}

	@RequestMapping(value = "/loginCheck/updatePage")
	public String updatePage(HttpSession session) {
		MemberDTO dto = (MemberDTO) session.getAttribute("login");
		String userid = dto.getMbrId();
		dto = service.mypage(userid);
		return "redirect:../memberUpdate";
	}

	@RequestMapping(value = "/loginCheck/memberUpdate")
	public String memberUpdate(MemberDTO m) {
		service.memberUpdate(m);
		return "redirect:../";
	}

	@RequestMapping(value = "/memberAdd")
	public String memberAdd(MemberDTO m, Model model) {
		System.out.println("회원가입 페이지로 이동 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		service.memberAdd(m);
		model.addAttribute("success", "회원가입성공");
		return "Main";
	}

	@RequestMapping(value = "/MemberIdSearch", produces = "text/plain;charset=UTF-8")
	public String MemberIdSearch(@RequestParam Map<String, String> map, Model model) {
		System.out.println(">>mbrName값: " + map.get("mbrName") + "\t" + "mbrEmail값: " + map.get("mbrEmail"));
		String mbrId = service.idSearch(map);
		if (mbrId != null) {
			model.addAttribute("mbrId", mbrId);
		} else {
			model.addAttribute("mesg", "확인할 수 없습니다. 닉네임 혹은 Email을 확인해 주십시오");
		}
		return "LoginForm";
	}

	@RequestMapping(value = "/MemberPwSearch", produces = "text/plain;charset=UTF-8")
	public String MemberPwSearch(@RequestParam Map<String, String> map, Model model) {
		System.out.println(">>mbrId값: " + map.get("mbrId") + "\t" + "mbrEmail값: " + map.get("mbrEmail"));
		String mbrPw = service.pwSearch(map);
		if (mbrPw != null) {
			model.addAttribute("mbrPw", mbrPw);
		} else {
			model.addAttribute("mesg", "확인할 수 없습니다. Id 혹은 Email을 확인해 주십시오");
		}
		return "LoginForm";
	}

}
