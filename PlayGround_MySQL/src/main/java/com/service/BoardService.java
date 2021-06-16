package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.BoardDAO;
import com.dto.BoardDTO;

@Service
public class BoardService {
	@Autowired
	BoardDAO dao;
	
	public List<BoardDTO> recommendInfoBoardSelect() {
		return dao.recommendInfoBoardSelect();
	}

	public List<BoardDTO> hitInfoBoardSelect() {
		return dao.hitInfoBoardSelect();
	}
	
	public List<BoardDTO> recommendQnaBoardSelect() {
		return dao.recommendQnaBoardSelect();
	}
	
	public List<BoardDTO> hitQnaBoardSelect() {
		return dao.hitQnaBoardSelect();
	}
	
	public int getBoardId() {
		return dao.getBoardId();
	}
	
	public int boardInsert(BoardDTO board) {
		return dao.boardInsert(board);
	}
	
	public int boardUpdate(BoardDTO board) {
		return dao.boardUpdate(board);
	}
	
	public int boardDelete(int boardId) {
		return dao.boardDelete(boardId);
	}
	
	public BoardDTO boardRead(int boardId) {
		return dao.boardRead(boardId);
	}
	
	public List<BoardDTO> boardListSelect(String boardCategory) {
		if (boardCategory.contentEquals("all"))
			return dao.boardAllSelect();
		return dao.boardListSelect(boardCategory);
	}
	
	public List<BoardDTO> boardSearchList(HashMap<String, String> searchMap) {
		List<BoardDTO> boardList = null;
		if (searchMap.get("searchCategory").contentEquals("title"))
			boardList = dao.boardTitleSearchSelect(searchMap);
		else if (searchMap.get("searchCategory").contentEquals("contents"))
			boardList = dao.boardContentSearchSelect(searchMap);
		else
			boardList = dao.boardWriterSearchSelect(searchMap);
		return boardList;
	}
	
	public int boardLikeMinus(int boardId) {
		return dao.boardLikeMinus(boardId);
	}
	
	public int boardLikePlus(int boardId) {
		return dao.boardLikePlus(boardId);
	}
	
	public int boardHitAdd(int boardId) {
		return dao.boardHitAdd(boardId);
	}
}
