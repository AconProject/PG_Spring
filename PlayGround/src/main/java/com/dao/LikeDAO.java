package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.LikeDTO;

@Repository
public class LikeDAO {
	@Autowired
	SqlSessionTemplate session;
	
	public int likeBoardCount(LikeDTO like) {
		return session.selectOne("LikeMapper.likeBoardCount", like);
	}
	
	public int likeBoardInsert(LikeDTO like) {
		return session.insert("LikeMapper.likeBoardInsert", like);
	}
	
	public int likeBoardDelete(LikeDTO like) {
		return session.delete("LikeMapper.likeBoardDelete", like);
	}
	
	public int likeReplyDelete(LikeDTO like) {
		return session.delete("LikeMapper.likeReplyDelete", like);
	}
	
	public int likeReplyInsert(LikeDTO like) {
		return session.insert("LikeMapper.likeReplyInsert", like);
	}
	public int likeReplyCount(LikeDTO like) {
		return session.selectOne("LikeMapper.likeReplyCount", like);
	}
	
	/////게임 댓글에 대한  좋아요 삽입 가능
	public int likeReviewInsert(LikeDTO ldto) {
		return session.insert("LikeMapper.likeReviewInsert",ldto); 
	}
	/////게임 댓글에 대한  좋아요 삭제 가능
	public int likeReviewDelete(LikeDTO ldto) {
		return session.delete("LikeMapper.likeReviewDelete",ldto); 
	}
	
	public int likeReviewCount(Map<String, Object> map) {
		System.out.println("Map in DAO: "+map);
		return session.selectOne("LikeMapper.likeReviewCount", map);
	}
	
}
	

