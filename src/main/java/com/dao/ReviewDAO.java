package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.GameDTO;
import com.dto.ReviewDTO;

@Repository
public class ReviewDAO {

	@Autowired
	SqlSessionTemplate session;
	
	public List<ReviewDTO> reviewSelect(int gameNo) {
		List<ReviewDTO> list = session.selectList("ReviewMapper.reviewSelect", gameNo);
		return list;
	}

	///////////////////////////////////////////////////////////////////////////////


	public List<ReviewDTO> selectAllReview() {
		List<ReviewDTO> list = session.selectList("ReviewMapper.selectAll");
		return list;
	}

//////////////////댓글 삽입 부분
	public int reviewInsert(ReviewDTO rdto) {
		int result = session.insert("ReviewMapper.reviewInsert", rdto);
		return result;
	}

//////////////////댓글 수정 부분
	public int reviewUpdate(Map<String, String> map) {
		int result = session.update("ReviewMapper.reviewUpdate", map);
		return result;
	}

//////////////////댓글 삭제 부분
	public int reviewDelete(int reviewId) {
		int result = session.delete("ReviewMapper.reviewDelete", reviewId);
		return result;
	}

////////////////
	public int reviewLikePlus(int reviewId) {
		int result = session.update("ReviewMapper.reviewLikePlus", reviewId);
		return result;
	}

	public int reviewLikeMinus(int reviewId) {
		int result = session.update("ReviewMapper.reviewLikeMinus", reviewId);
		return result;
	}
////////////////

	public int reviewLikeSelect(int reviewId) {
		int result = session.selectOne("ReviewMapper.reviewLikeSelect", reviewId);
		return result;
	}

	public int selectreviewId(HashMap<String, Object> map) {
		int result = session.selectOne("ReviewMapper.selectreviewId", map);
		return result;
	}

	public int nameCheck(Map<String, Object> map) {
		int count = session.selectOne("ReviewMapper.nameCheck", map);
		return count;
	}

	public ReviewDTO updatebtn(int reviewId) {
		ReviewDTO result = session.selectOne("ReviewMapper.updatebtn", reviewId);
		return result;
	}

	public String findContent(int reviewId) {
		String result = session.selectOne("ReviewMapper.findContent", reviewId);
		return result;
	}


}
