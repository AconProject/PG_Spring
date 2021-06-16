package com.controller.member;

import java.util.HashMap;
<<<<<<< HEAD
import java.util.List;
=======
>>>>>>> 95ba9321f3f8b8d0f24e54a53bcc4473aaa157be
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
	@Autowired
	BCryptPasswordEncoder pwdEncoder;
<<<<<<< HEAD

	@RequestMapping(value = "/idDuplicateCheck", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String idDuplicatedCheck(@RequestParam("id") String mbrId) {
		MemberDTO dto = service.mypage(mbrId);
		String mesg = "사용가능한 아이디입니다.";
		if (dto != null) {
			mesg = "이미 사용 중인 아이디입니다.";
		}
		return mesg;
	}

	@RequestMapping(value = "/emailDuplicateCheck", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String emailDuplicatedCheck(@RequestParam("mbrEmail") String mbrEmail) {
		List<MemberDTO> list = service.email_mypage(mbrEmail);
		System.out.println("이메일 체크: " + list);
		String mesg = "사용가능한 이메일입니다.";
		if (!list.isEmpty()) {
			mesg = "이미 사용 중인 이메일입니다.";
		}
		return mesg;
	}

	@RequestMapping(value = "/nameDuplicateCheck", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String nameDuplicatedCheck(@RequestParam("mbrName") String mbrName) {
		List<MemberDTO> list = service.name_mypage(mbrName);
		String mesg = "사용가능한 닉네임입니다.";
		if (!list.isEmpty()) {
			mesg = "이미 사용 중인 닉네임입니다.";
=======
	
	@RequestMapping(value = "/idDuplicateCheck", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String idDuplicatedCheck(@RequestParam("id") String mbrId) {
		MemberDTO dto= service.mypage(mbrId);
		String mesg="사용가능한 아이디입니다.";
		if(dto != null) {
			mesg="이미 사용 중인 아이디입니다.";
>>>>>>> 95ba9321f3f8b8d0f24e54a53bcc4473aaa157be
		}
		return mesg;
	}

	@RequestMapping(value = "/loginCheck/myPage")
	public String myPage(HttpSession session) {
		MemberDTO dto = (MemberDTO) session.getAttribute("login");
		String userid = dto.getMbrId();
		dto = service.mypage(userid);
<<<<<<< HEAD
		System.out.println("회원정보 출력: " + dto);
		return "redirect:../MyPage";
	}

=======
		System.out.println("회원정보 출력: " +dto);
		return "redirect:../MyPage";
	}
>>>>>>> 95ba9321f3f8b8d0f24e54a53bcc4473aaa157be
///이동 부분
	@RequestMapping(value = "/loginCheck/updatePage")
	public String updatePage() {
		return "redirect:../memberUpdate";
	}
<<<<<<< HEAD

=======
	
>>>>>>> 95ba9321f3f8b8d0f24e54a53bcc4473aaa157be
	@RequestMapping(value = "/loginCheck/deletePage")
	public String deletePage() {
		return "redirect:../memberDelete";
	}
<<<<<<< HEAD

=======
	
>>>>>>> 95ba9321f3f8b8d0f24e54a53bcc4473aaa157be
	@RequestMapping(value = "/Member/tagPage")
	public String tagPage() {
		return "redirect:../tagPage";
	}
<<<<<<< HEAD

////수행 부분
	@RequestMapping(value = "/memberAdd")
	public String memberAdd(MemberDTO dto, Model model) {
		String inputPass = dto.getMbrPw();
		String crytPass = pwdEncoder.encode(inputPass); // 기존패스워드 암호화 저장
		dto.setMbrPw(crytPass);
		int result = service.memberAdd(dto);
=======
	
	
////수행 부분
	@RequestMapping(value = "/memberAdd")
	public String memberAdd(MemberDTO dto, Model model) {
		String inputPass=dto.getMbrPw();
		String crytPass= pwdEncoder.encode(inputPass); //기존패스워드 암호화 저장
		dto.setMbrPw(crytPass);
		int result=service.memberAdd(dto);
>>>>>>> 95ba9321f3f8b8d0f24e54a53bcc4473aaa157be
		if (result == 1) {
			model.addAttribute("success", "환영합니다. 회원가입성공하셨습니다");
		} else {
			model.addAttribute("mesg", "이용 불가. 입력하신 정보를 다시 확인해 주십시오");
		}
		return "Main";
	}
<<<<<<< HEAD

	@RequestMapping(value = "/loginCheck/memberUpdate")
	public String memberUpdate(HttpSession session, MemberDTO dto,Model model) {
		session.setAttribute("login", dto); // session에는 저장될 값은: 변경된 값 + 암호화되지않은 PW
		String mbrEmail = dto.getMbrEmail();
		String mbrName = dto.getMbrName();
		List<MemberDTO>  dbDTO1 = service.email_mypage(mbrEmail);
		List<MemberDTO> dbDTO2 = service.name_mypage(mbrName);
		System.out.println("Hi: "+dbDTO1 +"\t"+dbDTO2);
		if (dbDTO1.isEmpty() && dbDTO2.isEmpty()) { // mbrName & mbrEmail 중복 안되는 경우
			System.out.println("암호화되기 전 DTO: " + dto);
			String inputPass = dto.getMbrPw(); // 바뀔 비밀번호
			String crytPass = pwdEncoder.encode(inputPass); // 암호화된 비밀번호
			dto.setMbrPw(crytPass); // 암호화된 PW을 DTO에 설정
			service.memberUpdate(dto); // 암호화된 PW가 DB에 설정
			System.out.println("회원정보 암호화된  출력: " + dto);
		} else {
			model.addAttribute("dupInfo","입력하신 name 혹은 email이 중복됩니다");
			System.out.println("회원정보 수정 불가");
		}

		return "redirect:../";
	}

	@RequestMapping(value = "/loginCheck/memberDelete")
	public String memberDelete(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		System.out.println(">>mbrId값: " + map.get("mbrId") + "\t" + "mbrPw값: " + map.get("mbrPw"));
		int result = service.memberDelete(map.get("mbrId"));
		session.invalidate();
		System.out.println("Delete 결과: " + result);
=======
	
	@RequestMapping(value = "/loginCheck/memberUpdate")
	public String memberUpdate(HttpSession session,MemberDTO dto) {
		session.setAttribute("login", dto); //session에는 저장될 값은: 변경된 값 + 암호화되지않은 PW
		System.out.println("암호화되기 전 DTO: "+dto);
		String inputPass=dto.getMbrPw(); //바뀔 비밀번호
		String crytPass=pwdEncoder.encode(inputPass); //암호화된 비밀번호
		dto.setMbrPw(crytPass); //암호화된 PW을 DTO에 설정
		service.memberUpdate(dto); //암호화된 PW가 DB에 설정
		System.out.println("회원정보 암호화된  출력: " +dto);
		return "redirect:../";
	}
	
	@RequestMapping(value = "/loginCheck/memberDelete")
	public String memberDelete(@RequestParam Map<String, String> map, Model model,HttpSession session) {
		System.out.println(">>mbrId값: " + map.get("mbrId") + "\t" + "mbrPw값: " + map.get("mbrPw"));
		int result = service.memberDelete(map.get("mbrId"));
		session.invalidate();
		System.out.println("Delete 결과: "+result);
>>>>>>> 95ba9321f3f8b8d0f24e54a53bcc4473aaa157be
		if (result == 1) {
			model.addAttribute("deleteResult", "성공적으로 회원 탈퇴를 하셨습니다. ");
		} else {
			model.addAttribute("mesg", "이용 불가. 입력하신 정보를 다시 확인해 주십시오");
		}
		return "redirect:../";
	}

<<<<<<< HEAD
=======


>>>>>>> 95ba9321f3f8b8d0f24e54a53bcc4473aaa157be
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
<<<<<<< HEAD
	public String MemberPwSearch(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		System.out.println(">>mbrId값: " + map.get("mbrId") + "\t" + "mbrEmail값: " + map.get("mbrEmail"));
		String mbrPw = service.pwSearch(map); // 비밀번호 존재
=======
	public String MemberPwSearch(@RequestParam Map<String, String> map, Model model,HttpSession session) {
		System.out.println(">>mbrId값: " + map.get("mbrId") + "\t" + "mbrEmail값: " + map.get("mbrEmail"));
		String mbrPw = service.pwSearch(map); //비밀번호 존재
>>>>>>> 95ba9321f3f8b8d0f24e54a53bcc4473aaa157be
		if (mbrPw != null) {
			String changedPw = "123456789a";
			HashMap<String, String> changedMap = new HashMap<String, String>();
			changedMap.put("mbrId", map.get("mbrId"));
			changedMap.put("mbrEmail", map.get("mbrEmail"));
			changedMap.put("mbrPw", changedPw);
<<<<<<< HEAD
			// 효용성에 대해 물어보기

			int result = service.changeMbrPw(changedMap);
			if (result != 0) {
				model.addAttribute("mbrPw", "회원님의 비밀번호가 [ " + changedPw + " ]로 변경되었습니다.");
				// note: @유나님. .jsp에서 변경

				// 다시 암호화 해주기
				String crytPass = pwdEncoder.encode(changedPw);
=======
			//효용성에 대해 물어보기 

			int result=service.changeMbrPw(changedMap);
			if(result!=0) {
				model.addAttribute("mbrPw", "회원님의 비밀번호가 [ "+changedPw+" ]로 변경되었습니다");
				//note: @유나님. .jsp에서 변경
				
				//다시 암호화 해주기
				String crytPass= pwdEncoder.encode(changedPw);
>>>>>>> 95ba9321f3f8b8d0f24e54a53bcc4473aaa157be
				HashMap<String, String> reEncryptMap = new HashMap<String, String>();
				reEncryptMap.put("mbrId", map.get("mbrId"));
				reEncryptMap.put("mbrEmail", map.get("mbrEmail"));
				reEncryptMap.put("mbrPw", crytPass);
<<<<<<< HEAD
				int reEncrypt = service.changeMbrPw(reEncryptMap);
				System.out.println("다시 암호화된 결과: " + reEncrypt + "\t" + "다시암호화 된 PW: " + crytPass);

			} else {
=======
				int reEncrypt=service.changeMbrPw(reEncryptMap);
				System.out.println("다시 암호화된 결과: "+reEncrypt+"\t"+"다시암호화 된 PW: "+crytPass);
				
			}else {
>>>>>>> 95ba9321f3f8b8d0f24e54a53bcc4473aaa157be
				model.addAttribute("mesg", "비밀번호 변경이 불가합니다. 관리자에게 연락해주십시오. ");
			}
		} else {
			model.addAttribute("mesg", "확인할 수 없습니다. Id 혹은 Email을 확인해 주십시오");
		}
		return "LoginForm";
	}

}
