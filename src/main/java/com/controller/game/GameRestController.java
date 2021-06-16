package com.controller.game;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dto.GameDTO;
import com.dto.MemberDTO;
import com.service.GameService;

@RestController
@RequestMapping("/game")
public class GameRestController {
	@Autowired
	GameService gService;

	
	@GetMapping("/category/{category}") // app/game/category/new | recommend
	public List<GameDTO> gameMainTopList(@PathVariable String category,
										HttpSession session) {
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		List<GameDTO> gameList = null;
		if (category == null || category.contentEquals("new"))
			gameList = gService.newGameListSelect();
		else if (category.contentEquals("sales"))
			gameList = gService.saleGameListSelect();
		else if (login == null && category.contentEquals("recommend"))
			gameList = gService.recommendGameListSelect(11);
		else if (login != null && category.contentEquals("recommend"))
			gameList = gService.recommendUserTagListSelect(login.getMbrId());
		System.out.println(gameList);
		return gameList;
	}
	
	
	@GetMapping("/tag/{tags}") // app/game/tag/tags
	public List<GameDTO> gameMainMidList(@PathVariable String tags) {
		System.out.println(tags);
		List<GameDTO> gameList = null;
		if (tags.contentEquals("noTag"))
			gameList = gService.recommendGameListSelect(6);
		else {
			String[] tag_array = tags.split(",");
			List<Integer> listTags = new ArrayList<Integer>();
			for (String t : tag_array) 
				listTags.add(Integer.parseInt(t));
			gameList = gService.tagGameListSelect(listTags);
		}
		return gameList;
	}
	
	@GetMapping("/search/{search}")
	public List<GameDTO> gameSearch(@PathVariable String search) {
		System.out.println("검색어 : " + search);
		return gService.gameSearch(search);
	}
}
