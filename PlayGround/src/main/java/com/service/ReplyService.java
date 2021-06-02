package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ReplyDAO;
import com.dto.ReplyDTO;

@Service
public class ReplyService {
	@Autowired
	ReplyDAO dao;
	
	public List<ReplyDTO> replyRead(int boardId) {
		return dao.replyRead(boardId);
	}
	
	public int replyUpdate(ReplyDTO reply) {
		return dao.replyUpdate(reply);
	}
	
	public int replyInsert(ReplyDTO reply) {
		return dao.replyInsert(reply);
	}
	
	public int replyDelete(int replyId) {
		return dao.replyDelete(replyId);
	}
	
	public int replyLikeMinus(int replyId) {
		return dao.replyLikeMinus(replyId);
	}
	
	public int replyLikePlus(int replyId) {
		return dao.replyLikePlus(replyId);
	}
}
