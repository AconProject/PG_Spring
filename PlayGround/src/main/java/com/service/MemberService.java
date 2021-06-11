package com.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MemberDAO;
import com.dto.MemberDTO;


@Service
public class MemberService {
	@Autowired
	MemberDAO dao;

	public String idSearch(MemberDTO dto) {
		String userid = dao.idSearch(dto);
		return userid;
	}

	public int memberUpdate(MemberDTO dto) {
		int n = dao.memberUpdate(dto);
		return n;
	}// end memberUpdate

	public int memberAdd(MemberDTO dto) {
		int n = dao.memberAdd(dto);
		return n;
	}// end memberAdd

	public int idCheck(String mbrId) {
		int count = dao.idCheck(mbrId);
		return count;
	}// end idCheck

	public MemberDTO login(String mbrId) {
		System.out.println("sysout in Service"+mbrId);
		MemberDTO dto = dao.login(mbrId);
		return dto;
	}// end idCheck

	public MemberDTO mypage(String userid) {
		MemberDTO dto = dao.mypage(userid);
		return dto;
	}// end idCheck


	public int memberDelete(String mbrId) {
		int result = dao.memberDelete(mbrId);
		return result;
	}// end memberDelete

	public String idSearch(Map<String, String> map) {
		String mbrId =dao.idSearch(map);
		return mbrId;
	}//end idSearch
	public String pwSearch(Map<String, String> map) {
		String mbrPw =dao.pwSearch(map);
		return mbrPw;
	}//end idSearch



	
}// end class
