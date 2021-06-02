package com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.NewsDTO;

@Repository
public class NewsDAO {
	@Autowired
	SqlSessionTemplate session;
	
	public List<NewsDTO> newsSelect() {
		return session.selectList("NewsMapper.newsSelect");
	}
}
