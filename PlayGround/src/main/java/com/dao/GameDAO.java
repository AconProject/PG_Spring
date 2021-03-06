package com.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.GameDTO;

@Repository
public class GameDAO {
	@Autowired
	SqlSessionTemplate session;
	
	public List<GameDTO> newGameListSelect() {
		List<GameDTO> list = session.selectList("GameMapper.newGameListSelect");
		return list;
	}

	public List<GameDTO> recommendGameListSelect(int limit) {
		List<GameDTO> list = session.selectList("GameMapper.recommendGameListSelect", limit);
		return list;
	}
	
	public List<GameDTO> recommendUserTagListSelect(String mbrId) {
		List<GameDTO> list = session.selectList("GameMapper.recommendUserTagListSelect", mbrId);
		return list;
	}
	
	public List<GameDTO> tagGameListSelect(List<Integer> listTags) {
		List<GameDTO> list = session.selectList("GameMapper.tagGameListSelect", listTags);
		return list;
	}

	public GameDTO detailGameSelect(int gameNo) {
		GameDTO dto = session.selectOne("GameMapper.detailGameSelect", gameNo);
		return dto;
	}

	public List<GameDTO> relatedGameList(HashMap <String, String> map) {
		return session.selectList("GameMapper.relatedGameList", map);
	}
	
	public List<GameDTO> gameSearch(String search) {
		return session.selectList("GameMapper.gameSearch", search);
	}

	public List<GameDTO> saleGameListSelect() {
		return session.selectList("GameMapper.saleGameListSelect"); 
	}
	
	public List<GameDTO> tagDetailSelect(String gameCategory) {
		return session.selectList("GameMapper.tagDetailSelect", gameCategory);
	}
}
