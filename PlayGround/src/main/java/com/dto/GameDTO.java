package com.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Alias("GameDTO")
@Getter
@Setter
@AllArgsConstructor
@ToString
@EqualsAndHashCode

public class GameDTO {
	private String gameNo;
	private String gameName;
	private String gameImage;
	private int gamePrice;
	private String gameContent;
	private String gameCategory;
	private String gameGenre;
	private String gameReleasedDate;
	private double discountRate;

	public GameDTO() {
		super();
	}

}