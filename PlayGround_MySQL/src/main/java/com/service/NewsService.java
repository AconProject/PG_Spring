package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.NewsDAO;
import com.dto.NewsDTO;

@Service
public class NewsService {
	@Autowired
	NewsDAO dao;
	
	public List<NewsDTO> newsSelect() {
		return dao.newsSelect();
	}
}
