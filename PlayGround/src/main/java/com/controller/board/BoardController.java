package com.controller.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dto.BoardDTO;
import com.service.BoardService;

@RestController
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardService bService;
	
	@GetMapping("/gameInfoCategory/{gameInfoCategory}")
	public List<BoardDTO> gameInfoMainList(@PathVariable String gameInfoCategory) {
		List<BoardDTO> boardList = null;
		if (gameInfoCategory == null || gameInfoCategory.contentEquals("recommend")) {
			boardList = bService.recommendInfoBoardSelect();
		} else {
			boardList = bService.hitInfoBoardSelect();
		}
		return boardList;
	}
	
	@GetMapping("/qnaCategory/{qnaCategory}")
	public List<BoardDTO> qnaMainList(@PathVariable String qnaCategory){
		List<BoardDTO> boardList = null;
		if (qnaCategory == null || qnaCategory.contentEquals("recommend")) {
			boardList = bService.recommendQnaBoardSelect();
		} else {
			boardList = bService.hitQnaBoardSelect();
		}
		return boardList;
	}
}
