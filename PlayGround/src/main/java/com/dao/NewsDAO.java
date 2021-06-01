package com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;

import com.dto.NewsDTO;

public class NewsDAO {
	SqlSessionTemplate session;
	
	public List<NewsDTO> newsSelect() {
		return session.selectList("NewsMapper.newsSelect");
	}
}
