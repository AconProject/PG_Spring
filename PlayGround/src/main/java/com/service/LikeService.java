package com.service;

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
	
	public int likeReplyCount(LikeDTO like) {
		return dao.likeReplyCount(like);
	}
}
