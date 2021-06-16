package com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.ReplyDTO;

@Repository
public class ReplyDAO {
	@Autowired
	SqlSessionTemplate session;
	
	public int replyLikeMinus(int replyId) {
		return session.update("ReplyMapper.replyLikeMinus", replyId);
	}
	
	public int replyLikePlus(int replyId) {
		return session.update("ReplyMapper.replyLikePlus", replyId);
	}

	public List<ReplyDTO> replyRead(int boardId) {
		return session.selectList("ReplyMapper.replyRead", boardId);
	}
	
	public int replyInsert(ReplyDTO dto) {
		return session.insert("ReplyMapper.replyInsert", dto);
	}
	
	public int replyUpdate(ReplyDTO dto) {
		return session.update("ReplyMapper.replyUpdate", dto);
	}
	
	public int replyDelete(int replyId) {
		return session.delete("ReplyMapper.replyDelete", replyId);
	}
}
