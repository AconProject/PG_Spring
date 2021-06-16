package com.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Alias("MemberDTO")
@Getter
@Setter
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class MemberDTO {

	
	private String mbrId;
	private String mbrPw;
	private String mbrName;
	private String mbrEmail;
	private String mbrRegdate;
	private String mbrGenre;
	
	public MemberDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

}
