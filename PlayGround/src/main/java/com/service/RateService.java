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
	
	public List<Double> rateRecommendSelect() {
		return dao.rateRecommendSelect();
	}
	
	public List<Double> rateTagSelect(List<Integer> listTags) {
		return dao.rateTagSelect(listTags);
	}

	public RateDTO getGameScore(int gameNo) {
		return dao.getGameScore(gameNo);
	}
}
