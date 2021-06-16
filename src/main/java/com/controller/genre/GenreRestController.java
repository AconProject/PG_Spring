package com.controller.genre;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dto.GenreDTO;
import com.service.GenreService;

@RestController
@RequestMapping("/genre")
public class GenreRestController {
	@Autowired
	GenreService gService;
	
	@GetMapping("/genreList")
	public List<GenreDTO> genreList() {
		return gService.genreList();
	}
	
	@GetMapping("/search/{search}")
	public List<GenreDTO> genreSearch(@PathVariable String search) {
		System.out.println("장르 검색어 : " + search);
		return gService.genreSearch(search);
	}
}
