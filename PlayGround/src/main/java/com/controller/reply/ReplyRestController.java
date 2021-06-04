package com.controller.reply;

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
import org.springframework.web.bind.annotation.RestController;

import com.dto.LikeDTO;
import com.dto.MemberDTO;
import com.dto.ReplyDTO;
import com.service.LikeService;
import com.service.ReplyService;

@RestController
@RequestMapping("/reply")
public class ReplyRestController {
	@Autowired
	ReplyService rService;
	@Autowired
	LikeService lService;
	
	@GetMapping("/read/{boardId}")
	public List<ReplyDTO> replyRead(@PathVariable int boardId) {
		List<ReplyDTO> replyList = rService.replyRead(boardId);
		System.out.println(replyList);
		return replyList;
	}
	
	@PostMapping("/insert")
	public int replyInsert(@RequestBody ReplyDTO reply) {
		System.out.println(reply);
		int result = rService.replyInsert(reply);
		if (result == 0)
			return -1;
		return result;
	}
	
	@PatchMapping("/update")
	public int replyUpdate(@RequestBody ReplyDTO reply) {
		System.out.println(reply);
		int result = rService.replyUpdate(reply);
		if (result == 0)
			return -1;
		return result;
	}
	
	@DeleteMapping("/delete/{replyId}")
	public int replyDelete(@PathVariable int replyId) {
		int result = rService.replyDelete(replyId);
		if (result == 0) 
			return -1;
		return result;
	}
	
	@PatchMapping("/like/{replyLike}/{replyId}")
	public int replyLike(@PathVariable int replyLike, @PathVariable int replyId,
							 HttpSession session) {
		System.out.println("현재 좋아요 개수 : " + replyLike);
		MemberDTO login = (MemberDTO)session.getAttribute("login");
		LikeDTO like = new LikeDTO(0, login.getMbrId(), 0, 0, replyId);
		boolean isComplete = false;
		int cnt = lService.likeReplyCount(like);
		if (cnt >= 1) {
			replyLike += rService.replyLikeMinus(replyId) * -1;
			isComplete = lService.likeBoardDelete(like);
		} else {
			replyLike += rService.replyLikePlus(replyId);
			isComplete = lService.likeBoardInsert(like);
		}
		System.out.println("좋아요 : " + replyLike + " , replyLiked 개수 : " + cnt + " , 삭제, 삽입 : " + isComplete);
		return replyLike;
	}
}
