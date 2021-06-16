package com.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Alias("NewsDTO")
@Getter
@Setter
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class NewsDTO {
	private String newsTitle;
	private String newsUrl;
	private Date newsDate;
	
	public NewsDTO() {
		super();
	}

}
