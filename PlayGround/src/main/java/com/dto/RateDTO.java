package com.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Alias("RateDTO")
@Getter
@Setter
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class RateDTO {
	String gameNo;
	Double gameScore; 
	int rateCount; 
	

	public RateDTO() {
		super();
	}

}
