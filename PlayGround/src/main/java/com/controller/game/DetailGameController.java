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
public class DetailGameController {
	@Autowired
	GameService gameService;
	@Autowired
	ReviewService reviewService;
	@Autowired
	RateService rateService;



	@RequestMapping("/Game/detailPage/{gameNo}")
	public ModelAndView gameDetail(@PathVariable String gameNo) {
		ModelAndView model = new ModelAndView();
		int gameNumber=Integer.parseInt(gameNo);
		System.out.println("게임번호: "+gameNo +"\t"+gameNumber);
		//1-1: 게임정보 
		GameDTO gameDTO= gameService.detailGameSelect(gameNumber);
		System.out.println("게임정보: "+gameDTO);
		model.addObject("topPageGame",gameDTO);
		
		//1-2: 점수
		RateDTO rateDTO = rateService.getGameScore(gameNumber);
		System.out.println("게임점수: "+rateDTO);
		model.addObject("topPageScore",rateDTO);

		//2. 중단: 게임댓글
		List<ReviewDTO> reviewDTO = reviewService.reviewSelect(gameNumber);
		System.out.println("게임댓글: "+reviewDTO);
		model.addObject("midPage",reviewDTO);
		
		//3. 하단: 관련게임
		String gameCategory = gameDTO.getGameCategory();
		List<GameDTO> relatedGameList = gameService.relatedGameList(gameCategory); 
		System.out.println("관련게임: "+relatedGameList);
		model.addObject("botPage",relatedGameList);
		
		model.setViewName("Game/detailPage");
		return model;
	}
	
	
	@RequestMapping("/loginCheck/reviewInsert")
	public String cartAdd(@ModelAttribute ReviewDTO rDTO, HttpSession session) {
		System.out.println("댓글 입력값 확인: "+ rDTO);
		int reviewResult=0;
		String rName=rDTO.getMbrName();	
		int gameNo=Integer.parseInt(rDTO.getGameNo());
		System.out.println("넘어온 정보: " + rName + "\t" + gameNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mbrname", rName);
		map.put("gameNo", gameNo);
		
		int nameCheck = reviewService.nameCheck(map);
		if(nameCheck==0) {
			reviewResult = reviewService.reviewInsert(rDTO);
			System.out.println("댓글삽입 성공: " + reviewResult);
		}else {
			System.out.println("댓글삽입 실패: " + reviewResult);

		}
		return "detailPage?gameNo="+rDTO.getGameNo();
	}
	
	@RequestMapping(value = "/loginCheck/reviewDelete")
	@ResponseBody
	public void cartDelte(@RequestParam("reviewId") int reviewId) {
		System.out.println("삭제할 reviewId: "+reviewId);
		int result = reviewService.reviewDelete(reviewId);
		System.out.println("댓글 삭제 성공 여부: "+result);
		
	}
	
	@RequestMapping(value = "/loginCheck/reviewUpdate")
	@ResponseBody
	public void cartUpdate(@ModelAttribute ReviewDTO rDTO) {
		System.out.println("댓글 수정값 확인: "+rDTO.toString());
		int result = reviewService.reviewUpdate(rDTO);
		System.out.println("댓글 수정 성공 여부: "+result);
	}
	
	
}
