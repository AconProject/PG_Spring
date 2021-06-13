package com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.GenreDTO;

@Repository
public class GenreDAO {
	@Autowired
	SqlSessionTemplate session;
	
	public List<GenreDTO> genreList() {
		return session.selectList("GenreMapper.genreSelect");
	}
	
	public List<GenreDTO> genreSearch(String search) {
		return session.selectList("GenreMapper.genreSearch", search);
	}
}
