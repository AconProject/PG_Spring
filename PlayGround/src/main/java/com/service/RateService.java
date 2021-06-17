package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.RateDAO;
import com.dto.RateDTO;

@Service
public class RateService {
	@Autowired
	RateDAO dao;
	
	public List<RateDTO> rateRecommendSelect() {
		return dao.rateRecommendSelect();
	}
	
	public List<RateDTO> rateTagSelect(List<Integer> listTags) {
		return dao.rateTagSelect(listTags);
	}

	public RateDTO getGameScore(int gameNo) {
		return dao.getGameScore(gameNo);
	}

	public int scoreInsert(RateDTO rateDTO) {
		return dao.scoreInsert(rateDTO);
	}

	public int scoreUpdate(RateDTO rateDTO) {
		return dao.scoreUpdate(rateDTO);		
	}
}
