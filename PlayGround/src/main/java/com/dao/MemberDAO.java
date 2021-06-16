package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.MemberDTO;

@Repository
public class MemberDAO {
	
	@Autowired
	SqlSessionTemplate template;
		
	public String idSearch(MemberDTO dto) {
		String userid = template.selectOne("MemberMapper.idSearch", dto);
		return userid;
	}

	public int memberUpdate(MemberDTO dto) {
		int n = template.update("MemberMapper.memberUpdate", dto);
		return n;
	}

	public int memberAdd(MemberDTO dto) {
		int n = template.insert("MemberMapper.memberAdd", dto);
		return n;
	}

	public int idCheck(String mbrId) {
		int count = template.selectOne("MemberMapper.idCheck", mbrId);
		return count;
	}

	public MemberDTO login(String mbrId) {
		MemberDTO n = template.selectOne("MemberMapper.login", mbrId);
		return n;
	}

	public MemberDTO mypage(String userid) {
		MemberDTO n = template.selectOne("MemberMapper.mypage", userid);
		return n;
	}

	public List<MemberDTO> email_mypage(String mbrEmail) {
		List<MemberDTO> n = template.selectList("MemberMapper.email_mypage", mbrEmail);
		return n;
	}
	public List<MemberDTO> name_mypage(String mbrName) {
		List<MemberDTO> n = template.selectList("MemberMapper.name_mypage", mbrName);
		return n;
	}
	
	public int memberDelete(String mbrId) {
		System.out.println("DAO에서 찍어보는 MAP: "+mbrId);
		int result = template.delete("MemberMapper.memberDelete", mbrId);
		return result;
	}

	public String idSearch(Map<String, String> map) {
		String mbrId= template.selectOne("MemberMapper.idSearch",map);
		System.out.println("과연 ID 는 나올것인가: "+mbrId);
		return mbrId;
	}
	public String pwSearch(Map<String, String> map) {
		String mbrPw= template.selectOne("MemberMapper.pwSearch",map);
		return mbrPw;
	}

	public int changeMbrPw(HashMap<String, String> changedMap) {
		int result = template.update("MemberMapper.changeMbrPw",changedMap);
		return result;
	}

	


	
}
