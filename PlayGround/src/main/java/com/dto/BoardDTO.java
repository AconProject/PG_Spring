package com.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Alias("BoardDTO")
@Getter
@Setter
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class BoardDTO {
	private int boardId;
	private String mbrId;
	private String mbrName;
	private String boardName;
	private String boardCategory;
	private String boardContent;
	private int boardLiked;
	private int boardCount;
	private Date boardDate;
	
	public BoardDTO() {
		super();
	}
	
}
