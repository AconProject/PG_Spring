package com.controller.board;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@GetMapping("/list")
	public String boardList() {
		return "Board/boardList";
	}
	
	@GetMapping("/page/{boardId}")
	public String boardPage(@PathVariable int boardId, Model m) {
		m.addAttribute("boardId", boardId);
		return "Board/boardPage";
	}
	
	@GetMapping("/write/{boardId}")
	public String writeBoard(@PathVariable String boardId, Model m) {
		m.addAttribute("boardId", boardId);
		return "Board/writeBoard";
	}
}
