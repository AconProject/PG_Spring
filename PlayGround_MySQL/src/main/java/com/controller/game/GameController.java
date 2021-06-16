package com.controller.game;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dto.GameDTO;
import com.service.GameService;

@Controller
@RequestMapping("/game")
public class GameController {
	@Autowired
	GameService gService;
	
	
	@GetMapping("/search/{search}")
	public String gameSearch(@PathVariable String search, Model m) {
		System.out.println("검색어 : " + search);
		List<GameDTO> gameList = gService.gameSearch(search);
		m.addAttribute("tagDetail", gameList);
		return "Game/tagDetail";
	}
}
