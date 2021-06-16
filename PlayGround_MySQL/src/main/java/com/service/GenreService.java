package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.GenreDAO;
import com.dto.GenreDTO;

@Service
public class GenreService {
	@Autowired
	GenreDAO dao;
	
	public List<GenreDTO> genreList() {
		return dao.genreList();
	}
	
	public List<GenreDTO> genreSearch(String search) {
		return dao.genreSearch(search);
	}
}
