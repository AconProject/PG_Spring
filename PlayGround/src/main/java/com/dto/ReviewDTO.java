package com.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Alias("ReviewDTO")
@Getter
@Setter
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class ReviewDTO {

	private int reviewId;
	private String mbrId;
	private String mbrName;
	private String gameNo;
	private String reviewContent;
	private int reviewLiked;
	private Double reviewScore;
	private String reviewDate;

	public ReviewDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

}
