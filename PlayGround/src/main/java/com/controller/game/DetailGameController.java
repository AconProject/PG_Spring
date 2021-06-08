package com.controller.game;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dto.GameDTO;
import com.dto.RateDTO;
import com.dto.ReviewDTO;
import com.service.GameService;
import com.service.RateService;
import com.service.ReviewService;

@Controller
public class DetailGameController {
	@Autowired
	GameService gameService;
	@Autowired
	ReviewService reviewService;
	@Autowired
	RateService rateService;



	@RequestMapping("/Game/detailPage")
	public ModelAndView gameDetail(@RequestParam("gameNo") int gameNo) {
		
		ModelAndView model = new ModelAndView();
		//1-1: 게임정보 
		GameDTO gameDTO= gameService.detailGameSelect(gameNo);
		System.out.println("게임정보: "+gameDTO);
		model.addObject("topPageGame",gameDTO);
		
		//1-2: 점수
		RateDTO rateDTO = rateService.getGameScore(gameNo);
		System.out.println("게임점수: "+rateDTO);
		model.addObject("topPageScore",rateDTO);

		//2. 중단: 게임댓글
		List<ReviewDTO> reviewDTO = reviewService.reviewSelect(gameNo);
		System.out.println("게임댓글: "+reviewDTO);
		model.addObject("midPage",reviewDTO);
		
		//3. 하단: 관련게임
		String gameCategory = gameDTO.getGameCategory();
		List<GameDTO> relatedGameList = gameService.relatedGameList(gameCategory); 
		System.out.println("관련게임: "+relatedGameList);
		model.addObject("botPage",relatedGameList);
		
		model.setViewName("../detailPage");
		return model;
	}
}
