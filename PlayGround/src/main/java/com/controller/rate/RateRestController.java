package com.controller.rate;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.service.RateService;

@RestController
@RequestMapping("/rate")
public class RateRestController {
	@Autowired
	RateService rService;
	
	@GetMapping("/tag/{tags}")
	public List<Double> rateMainMidList(@PathVariable String tags) {
		System.out.println(tags);
		List<Double> rateList = null;
		if (tags.contentEquals("noTag"))
			rateList = rService.rateRecommendSelect();
		else {
			String[] tag_array = tags.split(",");
			List<Integer> listTags = new ArrayList<Integer>();
			for (String t : tag_array)
				listTags.add(Integer.parseInt(t));
			rateList = rService.rateTagSelect(listTags);
		}
		return rateList;
	}
}
