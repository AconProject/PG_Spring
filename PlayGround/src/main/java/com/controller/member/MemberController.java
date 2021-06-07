package com.controller.member;

import java.util.Map;

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
	
	@RequestMapping(value = "/idDuplicateCheck", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String idDuplicatedCheck(@RequestParam("id") String mbrId) {
		MemberDTO dto= service.mypage(mbrId);
		String mesg="아이디 사용가능";
		if(dto != null) {
			mesg="아이디 중복";
		}
		return mesg;
	}

	@RequestMapping(value = "/loginCheck/myPage")
	public String myPage(HttpSession session) {
		MemberDTO dto = (MemberDTO) session.getAttribute("login");
		String userid = dto.getMbrId();
		dto = service.mypage(userid);
		System.out.println("회원정보 출력: " +dto);
		return "redirect:../MyPage";
	}
///이동 부분
	@RequestMapping(value = "/loginCheck/updatePage")
	public String updatePage() {
		return "redirect:../memberUpdate";
	}
	
	@RequestMapping(value = "/loginCheck/deletePage")
	public String deletePage() {
		return "redirect:../memberDelete";
	}
	
	@RequestMapping(value = "/Member/tagPage")
	public String tagPage() {
		System.out.println("TagPage 이동@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		return "redirect:../tagPage";
	}
	
	
////수행 부분
	@RequestMapping(value = "/memberAdd")
	public String memberAdd(MemberDTO m, Model model) {
		int result=service.memberAdd(m);
		if (result == 1) {
			model.addAttribute("success", "환영합니다. 회원가입성공하셨습니다");
		} else {
			model.addAttribute("mesg", "이용 불가. 입력하신 정보를 다시 확인해 주십시오");
		}
		return "Main";
	}
	
	@RequestMapping(value = "/loginCheck/memberUpdate")
	public String memberUpdate(HttpSession session,MemberDTO dto) {
		MemberDTO beforeChange = (MemberDTO) session.getAttribute("login");
		System.out.println("회원정보 변경전 출력: " +beforeChange);
		service.memberUpdate(dto);
		session.setAttribute("login", dto); 
		System.out.println("회원정보 변경후 출력: " +dto);
		return "redirect:../";
	}
	
	@RequestMapping(value = "/loginCheck/memberDelete")
	public String memberDelete(@RequestParam Map<String, String> map, Model model,HttpSession session) {
		System.out.println(">>mbrId값: " + map.get("mbrId") + "\t" + "mbrPw값: " + map.get("mbrPw"));
		int result = service.memberDelete(map);
		session.invalidate();
		System.out.println("Delete 결과: "+result);
		if (result == 1) {
			model.addAttribute("deleteResult", "성공적으로 회원 탈퇴를 하셨습니다. ");
		} else {
			model.addAttribute("mesg", "이용 불가. 입력하신 정보를 다시 확인해 주십시오");
		}
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
