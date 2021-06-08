package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ReviewDAO;
import com.dto.ReviewDTO;

@Service
public class ReviewService {
	@Autowired
	ReviewDAO dao;

	public List<ReviewDTO> reviewSelect(int gameNo) {
		return dao.reviewSelect(gameNo);
	}

	///////////////////////////////////

	public ReviewService() {
		dao = new ReviewDAO();
	}

	public List<ReviewDTO> selectAllReview() {
		return dao.selectAllReview();
	}

	/////// 댓글 삽입////////
	public int reviewInsert(ReviewDTO rdto) {
		return dao.reviewInsert(rdto);
	}

	////// 댓글 수정///////
	public int reviewUpdate(ReviewDTO rdto) {
		return dao.reviewUpdate(rdto);
	}

	////// 댓글 삭제///////
	public int reviewDelete(int reviewId) {
		return dao.reviewDelete(reviewId);
	}

/////////////////////////////////////// 0520
	////// 댓글 좋아요 +1///////
	public int reviewLikePlus(int reviewId) {
		return dao.reviewLikePlus(reviewId);
	}

	////// 댓글 좋아요 -1///////
	public int reviewLikeMinus(int reviewId) {
		return dao.reviewLikeMinus(reviewId);
	}
///////////////////////////////////

	// 증가된 좋아요 가져오기
	public int reviewLikeSelect(int reviewId) {
		return dao.reviewLikeSelect(reviewId);
	}

	public int selectreviewId(HashMap<String, Object> map) {
		return dao.selectreviewId(map);
	}

	// 중복된 닉네임 찾기
	public int nameCheck(Map<String, Object> map) {
		return dao.nameCheck(map);
	}

	// 댓글 수정버튼 클릭시 reviewId로 댓글 찾기
	public ReviewDTO updatebtn(int reviewId) {
		return dao.updatebtn(reviewId);
	}

}
