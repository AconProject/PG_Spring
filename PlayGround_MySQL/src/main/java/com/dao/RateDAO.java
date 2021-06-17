package com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.RateDTO;

@Repository
public class RateDAO {
	@Autowired
	SqlSessionTemplate session;
	
	public List<RateDTO> rateRecommendSelect() {
		return session.selectList("RateMapper.rateRecommendSelect");
	}
	
	public List<RateDTO> rateTagSelect(List<Integer> listTags) {
		return session.selectList("RateMapper.rateTagSelect", listTags);
	}

	public RateDTO getGameScore(int gameNo) {
		System.out.println("check gameNo in DAO: "+ gameNo);
		return session.selectOne("RateMapper.getGameScore", gameNo);
	}

	public int scoreInsert(RateDTO rateDTO) {
		return session.insert("RateMapper.scoreInsert",rateDTO);
	}

	public int scoreUpdate(RateDTO rateDTO) {
		return session.update("RateMapper.scoreUpdate",rateDTO);
	}
}
