package com.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.LikeDAO;
import com.dao.ReplyDAO;
import com.dto.LikeDTO;
import com.dto.MemberDTO;
import com.dto.ReplyDTO;
import com.dto.ReplyRestDTO;

@Service
public class ReplyService {
	@Autowired
	ReplyDAO rDao;
	@Autowired
	LikeDAO lDao;
	
	public List<ReplyDTO> replyRead(int boardId) {
		return rDao.replyRead(boardId);
	}
	
	public int replyUpdate(ReplyDTO reply) {
		return rDao.replyUpdate(reply);
	}
	
	public int replyInsert(ReplyDTO reply) {
		return rDao.replyInsert(reply);
	}
	
	public int replyDelete(int replyId) {
		return rDao.replyDelete(replyId);
	}
	
	public int replyLikeMinus(int replyId) {
		return rDao.replyLikeMinus(replyId);
	}
	
	public int replyLikePlus(int replyId) {
		return rDao.replyLikePlus(replyId);
	}
	
	public List<ReplyRestDTO> replyCount(List<ReplyDTO> replyList, MemberDTO login, int boardId) {
		List<ReplyRestDTO> list = new ArrayList<>();
		if (login == null) {
			for (ReplyDTO dto : replyList) {
				list.add(new ReplyRestDTO(dto.getReplyId(), dto.getBoardId(), dto.getMbrId(), dto.getMbrName(), 
						dto.getReplyContent(), dto.getReplyLiked(), dto.getReplyDate(), 0));
			}
		}
		else {
			for (ReplyDTO dto : replyList) {
				if (dto.getReplyLiked() == 0)
					list.add(new ReplyRestDTO(dto.getReplyId(), dto.getBoardId(), dto.getMbrId(),
						dto.getMbrName(), dto.getReplyContent(), 0, dto.getReplyDate(), 0));
				else {
					LikeDTO like = new LikeDTO(0, login.getMbrId(), boardId, 0, dto.getReplyId());
					int cnt = lDao.likeReplyCount(like);
					list.add(new ReplyRestDTO(dto.getReplyId(), dto.getBoardId(), dto.getMbrId(),
							dto.getMbrName(), dto.getReplyContent(), dto.getReplyLiked(), dto.getReplyDate(), cnt));
				}
			}
		}
		return list;
	}

}
