package com.service;

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
}
