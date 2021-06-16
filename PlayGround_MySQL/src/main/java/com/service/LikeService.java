package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.LikeDAO;
import com.dto.LikeDTO;

@Service
public class LikeService {
	@Autowired
	LikeDAO dao;
	
	public boolean likeBoardDelete(LikeDTO like) {
		int result = dao.likeBoardDelete(like);
		return result >= 1 ? true:false;
	}
	
	public boolean likeBoardInsert(LikeDTO like) {
		int result = dao.likeBoardInsert(like);
		return result >= 1 ? true:false;
	}
	
	public int likeBoardCount(LikeDTO like) {
		return dao.likeBoardCount(like);
	}
	
	public boolean likeReplyDelete(LikeDTO like) {
		int result = dao.likeReplyDelete(like);
		return result >= 1 ? true:false;
	}
	
	public boolean likeReplyInsert(LikeDTO like) {
		int result = dao.likeReplyInsert(like);
		return result >= 1 ? true:false;
	}
	
	/////////Review(게임 댓글 부분)//////////////////
	
	//like 테이블 +1
	public int likeReviewInsert(LikeDTO ldto) {
		return dao.likeReviewInsert(ldto);
	}
	//like 테이블 -1	
	public int likeReviewDelete(LikeDTO ldto) {
		return dao.likeReviewDelete(ldto);
	}
	////
	public int likeReviewCount(Map<String, Object> map) {
		return dao.likeReviewCount(map);
	}

}
