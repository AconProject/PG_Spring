package com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.BoardDTO;

@Repository
public class BoardDAO {
	@Autowired
	SqlSessionTemplate session;
	
	public List<BoardDTO> recommendInfoBoardSelect() {
		return session.selectList("BoardMapper.recommendInfoBoardSelect");
	}

	public List<BoardDTO> hitInfoBoardSelect() {
		return session.selectList("BoardMapper.hitInfoBoardSelect");
	}
	
	public List<BoardDTO> recommendQnaBoardSelect() {
		return session.selectList("BoardMapper.recommendQnaBoardSelect");
	}
	
	public List<BoardDTO> hitQnaBoardSelect() {
		return session.selectList("BoardMapper.hitQnaBoardSelect");
	}
}
