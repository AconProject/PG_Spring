package com.controller.news;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/news")
public class NewsController {
	@GetMapping("/list")
	public String newsList() {
		return "News/newsList";
	}
}
