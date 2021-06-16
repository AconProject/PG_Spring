package com.controller.game;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.dto.GameDTO;
import com.dto.RateDTO;
import com.dto.ReviewDTO;
import com.service.GameService;
import com.service.RateService;
import com.service.ReviewService;

@Controller
public class TagDetailController {
	@Autowired
	GameService gameService;
	@Autowired
	ReviewService reviewService;
	@Autowired
	RateService rateService;

	@RequestMapping("/Game/tagDetail/{gameCategory}")
	public ModelAndView tagDetail(@PathVariable String gameCategory) {
		ModelAndView model = new ModelAndView();
		
		List<GameDTO> relatedGameList= gameService.tagDetailSelect(gameCategory);
		System.out.println("관련게임: "+relatedGameList);
		model.addObject("tagDetail",relatedGameList);
		
		model.setViewName("Game/tagDetail");
		return model;
	}
}
