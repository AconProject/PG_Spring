package com.dao;

import java.util.HashMap;
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
	
	public List<BoardDTO> boardListSelect(String boardCategory) {
		return session.selectList("BoardMapper.boardListSelect", boardCategory);
	}
	
	public List<BoardDTO> boardAllSelect() {
		return session.selectList("BoardMapper.boardAllSelect");
	}

	public List<BoardDTO> boardTitleSearchSelect(HashMap<String, String> searchMap) {
		return session.selectList("BoardMapper.boardTitleSearchSelect", searchMap);
	}

	public List<BoardDTO> boardContentSearchSelect(HashMap<String, String> searchMap) {
		return session.selectList("BoardMapper.boardContentSearchSelect", searchMap);
	}
	
	public int boardInsert(BoardDTO dto) {
		return session.insert("BoardMapper.boardInsert", dto);
	}
	
	public int boardUpdate(BoardDTO dto) {
		return session.update("BoardMapper.boardUpdate", dto);
	}
	
	public int boardDelete(int boardId) {
		return session.delete("BoardMapper.boardDelete", boardId);
	}
	
	public int boardLikePlus(int boardId) {
		return session.update("BoardMapper.boardLikePlus", boardId);
	}
	
	public int boardLikeMinus(int boardId) {
		return session.update("BoardMapper.boardLikeMinus", boardId);
	}
	
	public BoardDTO boardRead(int boardId) {
		return session.selectOne("BoardMapper.boardRead", boardId);
	}
	
	public int getBoardId() {
		return session.selectOne("BoardMapper.getBoardId");
	}
	
	public List<BoardDTO> boardWriterSearchSelect(HashMap<String, String> searchMap) {
		return session.selectList("BoardMapper.boardWriterSearchSelect", searchMap);
	}
}
