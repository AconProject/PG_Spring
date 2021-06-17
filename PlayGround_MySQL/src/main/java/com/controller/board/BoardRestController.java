package com.controller.board;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dto.BoardDTO;
import com.dto.LikeDTO;
import com.dto.MemberDTO;
import com.service.BoardService;
import com.service.LikeService;

@RestController
@RequestMapping("/board")
public class BoardRestController {
	@Autowired
	BoardService bService;
	@Autowired
	LikeService lService;
	
	
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
	
	@GetMapping("/boards/{boardId}")
	public BoardDTO boardRead(@PathVariable int boardId) {
		BoardDTO board = bService.boardRead(boardId);
		bService.boardHitAdd(boardId);
		return board;
	}
	
	@PostMapping("/boards")
	public int boardInsert(@RequestBody BoardDTO board) {
		System.out.println(board);
		int boardId = bService.getBoardId();
		board.setBoardId(boardId);
		int result = bService.boardInsert(board);
		if (result == 1)
			return boardId;
		else
			return -1;
	}
	
	@PatchMapping("/boards")
	public int boardUpdate(@RequestBody BoardDTO board) {
		System.out.println(board);
		int result = bService.boardUpdate(board);
		if (result == 0)
			return -1;
		return board.getBoardId();
	}
	
	@DeleteMapping("/boards/{boardId}")
	public int boardDelete(@PathVariable int boardId) {
		int result = bService.boardDelete(boardId);
		if (result == 0) 
			return -1;
		return result;
	}
	
	@GetMapping("/boardList/{boardCategory}")
	public List<BoardDTO> boardListSelect(@PathVariable String boardCategory) {
		List<BoardDTO> boardList = bService.boardListSelect(boardCategory);
		return boardList;
	}
	
	@GetMapping("/boardCategory/{boardCategory}/words/{searchWord}/searchCategory/{searchCategory}")
	public List<BoardDTO> boardSearchList(@PathVariable HashMap<String, String> searchMap) {
		List<BoardDTO> boardList = bService.boardSearchList(searchMap);
		return boardList;
	}
	
	@GetMapping("/boardLikeCount/{boardId}")
	public int likeBoardCount(@PathVariable int boardId, HttpSession session) {
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		LikeDTO like = null;
		if (login != null)
			like = new LikeDTO(0, login.getMbrId(), boardId, 0, 0);
		int cnt = lService.likeBoardCount(like);

		return cnt;
	}
	
	@PatchMapping("/boardLikePlus")
	public int boardLikePlus(@RequestBody HashMap<String, Integer> boardMap,
							 HttpSession session) {
		int boardLike = boardMap.get("boardLike");
		System.out.println("현재 좋아요 개수 : " + boardLike);
		MemberDTO login = (MemberDTO)session.getAttribute("login");
		LikeDTO like = new LikeDTO(0, login.getMbrId(), boardMap.get("boardId"), 0, 0);
		boolean isComplete = false;
		int cnt = lService.likeBoardCount(like);
		boardLike += bService.boardLikePlus(boardMap.get("boardId"));
		isComplete = lService.likeBoardInsert(like);
		System.out.println("좋아요 : " + boardLike + " , boardLiked 개수 : " + cnt + " , 삭제, 삽입 : " + isComplete);
		return boardLike;
	}
	
	@PatchMapping("/boardLikeMinus")
	public int boardLikeMinus(@RequestBody HashMap<String, Integer> boardMap,
							 HttpSession session) {
		int boardLike = boardMap.get("boardLike");
		System.out.println("현재 좋아요 개수 : " + boardLike);
		MemberDTO login = (MemberDTO)session.getAttribute("login");
		LikeDTO like = new LikeDTO(0, login.getMbrId(), boardMap.get("boardId"), 0, 0);
		boolean isComplete = false;
		int cnt = lService.likeBoardCount(like);
		boardLike += bService.boardLikeMinus(boardMap.get("boardId"));
		isComplete = lService.likeBoardDelete(like);
		System.out.println("좋아요 : " + boardLike + " , boardLiked 개수 : " + cnt + " , 삭제, 삽입 : " + isComplete);
		return boardLike;
	}

}
