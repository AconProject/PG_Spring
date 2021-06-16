package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.GameDAO;
import com.dto.GameDTO;

@Service
public class GameService {
	@Autowired
	GameDAO dao;
	
	public List<GameDTO> newGameListSelect() {
		return dao.newGameListSelect();
	}
	
	public List<GameDTO> recommendGameListSelect(int limit) {
		return dao.recommendGameListSelect(limit);
	}
	
	public List<GameDTO> recommendUserTagListSelect(String mbrId) {
		return dao.recommendUserTagListSelect(mbrId);
	}
	
	public List<GameDTO> tagGameListSelect(List<Integer> listTags) {
		return dao.tagGameListSelect(listTags);
	}

	public GameDTO detailGameSelect(int gameNo) {
		GameDTO dto = dao.detailGameSelect(gameNo);
		return dto;
	}

	public List<GameDTO> relatedGameList(HashMap <String, String> map) {
		return dao.relatedGameList(map);
	}

	public List<GameDTO> gameSearch(String search) {
		return dao.gameSearch(search);
	}
	
	public List<GameDTO> saleGameListSelect() {
		return dao.saleGameListSelect();
	}
		
	public List<GameDTO> tagDetailSelect(String gameCategory) {
		return dao.tagDetailSelect(gameCategory);
	}
}
