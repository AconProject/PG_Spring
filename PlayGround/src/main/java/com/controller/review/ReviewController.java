package com.controller.review;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.LikeDTO;
import com.dto.MemberDTO;
import com.dto.ReviewDTO;
import com.service.LikeService;
import com.service.ReviewService;

@Controller
public class ReviewController {
	@Autowired
	ReviewService reviewService;
	@Autowired
	LikeService likeService;

	@RequestMapping(value ="/loginCheck/reviewInsert")
	public String cartAdd(@ModelAttribute ReviewDTO rDTO, HttpSession session) {
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		System.out.println("댓글 입력값 확인: "+ rDTO);
		int reviewResult=0;

		rDTO.setMbrId(login.getMbrId());
		rDTO.setMbrName(login.getMbrName());
		String mbrName=rDTO.getMbrName();	
		int gameNo=Integer.parseInt(rDTO.getGameNo());
		
		
		System.out.println("여기는 rDTO 값: "+rDTO.toString());
		
		System.out.println("넘어온 정보: " + mbrName + "\t" + gameNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mbrName", mbrName);
		map.put("gameNo", gameNo);
		
		System.out.println("map값 확인: "+map.toString());
		//이미 입력했는지 확인
		int nameCheck = reviewService.nameCheck(map);
		if(nameCheck==0) {
			reviewResult = reviewService.reviewInsert(rDTO);
			System.out.println("댓글삽입 성공: " + reviewResult);
		}else {
			System.out.println("댓글삽입 실패: " + reviewResult);

		}
		return "redirect:../Game/detailPage/"+rDTO.getGameNo();
	}
	
	@RequestMapping(value = "/loginCheck/reviewDelete")
	public String cartDelte(@RequestParam("reviewId") int reviewId, @ModelAttribute ReviewDTO rDTO) {
		System.out.println("삭제할 reviewId: "+reviewId);
		int result = reviewService.reviewDelete(reviewId);
		System.out.println("댓글 삭제 성공 여부: "+result);
		
		return "redirect:../Game/detailPage/"+rDTO.getGameNo();
		
	}
	
	@RequestMapping(value = "/loginCheck/reviewUpdate", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String cartUpdate(@RequestParam Map<String, String>map) {
		System.out.println("댓글 수정값 확인: "+ map);
		reviewService.reviewUpdate(map);
		
		int reviewId = Integer.parseInt(map.get("reviewId"));
		System.out.println("reviewId: " + reviewId);
		String content = reviewService.findContent(reviewId);
		System.out.println("수정된 content: "+content);
		return content;
	}

	
	@RequestMapping(value = "/loginCheck/reviewLike", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public Object reviewLike(@RequestParam("reviewId") String reviewId, HttpSession session) {
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		String mbrId=login.getMbrId();
		
		int likeNo = 0; // 추천
		int boardId = 0; // 게번호시글 ID
		int replyId = 0; // 게시판 댓글ID
		LikeDTO ldto = new LikeDTO(likeNo, login.getMbrId(), boardId, Integer.parseInt(reviewId), replyId);
		System.out.println("likeDTO 확인: "+ldto);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("mbrId", mbrId);
		map.put("reviewId", reviewId);
		int likedCount = likeService.likeReviewCount(map);
		System.out.println("LikeCountCheck: "+likedCount);
		
		String mesg="";
	
		//like 들어있는지 확인=> 들어있는경우
		if (likedCount == 1) {
			System.out.println("좋아요가 있어서, -1했습니다");
			int reviewMinus = reviewService.reviewLikeMinus(Integer.parseInt(reviewId)); // review 댓글 -1
			System.out.println("좋아요 빼기 여부: " + reviewMinus);
			
			int likedDel = likeService.likeReviewDelete(ldto); //
			System.out.println("liked테이블 제거: " + likedDel);
			
			ReviewDTO rdto = reviewService.updatebtn(Integer.parseInt(reviewId));
			System.out.println("찾기: " + rdto);
			int liked = rdto.getReviewLiked();
			mesg = Integer.toString(liked);
			
		}else if (likedCount==0){ //like 안들어있는 경우
			System.out.println("좋아요가 없어서, +1했습니다");

			int plus = reviewService.reviewLikePlus(Integer.parseInt(reviewId));
			System.out.println("좋아요 더하기 여부: " + plus);
			
			int likedAdd = likeService.likeReviewInsert(ldto);
			System.out.println("liked테이블 추가: " + likedAdd);
			ReviewDTO rdto = reviewService.updatebtn(Integer.parseInt(reviewId));
			System.out.println("찾기: " + rdto);
			int liked = rdto.getReviewLiked();
			mesg=Integer.toString(liked);
			
			
		} 

		
			return mesg;
			

		}
	}


