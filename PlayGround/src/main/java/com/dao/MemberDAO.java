package com.dao;

import java.util.HashMap;

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

	public MemberDTO login(HashMap<String, String> map) {
		MemberDTO n = template.selectOne("MemberMapper.login", map);
		return n;
	}

	public MemberDTO mypage(String userid) {
		MemberDTO n = template.selectOne("MemberMapper.mypage", userid);
		return n;
	}

	public String pwSearch(MemberDTO dto) {
		String userpw = template.selectOne("MemberMapper.pwSearch", dto);
		return userpw;
	}

	public int memberDelete(HashMap<String, String> map) {
		int result = template.delete("MemberMapper.memberDelete", map);
		return result;
	}
}
