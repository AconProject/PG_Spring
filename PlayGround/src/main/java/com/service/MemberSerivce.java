package com.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MemberDAO;
import com.dto.MemberDTO;

@Service
public class MemberSerivce {
	@Autowired
	MemberDAO dao;  // @Repository + Component-scan 빈생성
	
	public void memberAdd(MemberDTO m) {
		System.out.println("dao"+ dao);
		dao.memberAdd(m);
	}
	
	public MemberDTO login(Map<String, String> map) {
		MemberDTO dto = dao.login(map); 
		return dto;
	}
}
