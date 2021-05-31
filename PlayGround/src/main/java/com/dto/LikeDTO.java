package com.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Alias("LikeDTO")
@Getter
@Setter
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class LikeDTO {

	int likeNo;
	String mbrId;
	int boardId;
	int reviewId;
	int replyId;
	
	public LikeDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
}
