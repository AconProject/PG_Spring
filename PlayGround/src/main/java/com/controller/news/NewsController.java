package com.controller.news;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dto.NewsDTO;
import com.service.NewsService;

@RestController
@RequestMapping("/news/")
public class NewsController {
	@Autowired
	NewsService nService;
	
	@GetMapping("/newsList")
	public List<NewsDTO> newsMainList() {
		return nService.newsSelect();
	}
}
