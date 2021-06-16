package com.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Alias("ReplyDTO")
@Getter
@Setter
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class ReplyRestDTO {
	private int replyId;
	private int boardId;
	private String mbrId;
	private String mbrName;
	private String replyContent;
	private int replyLiked;
	private Date replyDate;
	private int visit;
	
	public ReplyRestDTO() {}
	
}
