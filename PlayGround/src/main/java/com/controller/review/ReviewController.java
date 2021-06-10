package com.controller.review;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
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

	@RequestMapping("/loginCheck/reviewInsert")
	public String cartAdd(@ModelAttribute ReviewDTO rDTO, HttpSession session) {
		System.out.println("댓글 입력값 확인: "+ rDTO);
		int reviewResult=0;
		String mbrName=rDTO.getMbrName();	
		int gameNo=Integer.parseInt(rDTO.getGameNo());
		System.out.println("넘어온 정보: " + mbrName + "\t" + gameNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mbrName", mbrName);
		map.put("gameNo", gameNo);
		
		//이미 입력했는지 확인
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

	
	@RequestMapping(value = "/loginCheck/reviewLike")
	@ResponseBody
	public Object reviewLike(@RequestParam("reviewId") int reviewId, @RequestParam("gameNo") String gameNo, HttpSession session) {
		System.out.println("gameNo: " + gameNo + " reviewId: " + reviewId);
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		String mbrId=login.getMbrId();
		
		LikeDTO ldto = new LikeDTO();
		ldto.setMbrId(login.getMbrId());
		ldto.setReviewId(reviewId);
		System.out.println("ldto: "+ldto);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("mbrId", mbrId);
		map.put("reviewId", reviewId);
		int likedCount = likeService.likeReviewCount(map);
		System.out.println("LikeCountCheck: "+likedCount);
		
		//like 들어있는지 확인=> 들어있는경우
		if (likedCount != 0) {
			String mesg = "이미 좋아요를 누르셨습니다.";
			return mesg;
		}else{ //like 안들어있는 경우
			// 좋아요 누르기 (+1)
			int plus = reviewService.reviewLikePlus(reviewId);
			System.out.println("좋아요 성공 여부: " + plus);
			
			int likedAdd = likeService.likeReviewInsert(ldto);
			System.out.println("liked테이블 추가: " + likedAdd);
			}

			ReviewDTO rdto = reviewService.updatebtn(reviewId);
			System.out.println("찾기: " + rdto);
			int liked = rdto.getReviewLiked();
			System.out.println("증가된 좋아요 수 : " + rdto);

			return liked;

		}
	}

