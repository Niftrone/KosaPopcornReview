package com.service.popcornreview.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.service.popcornreview.service.MovieService;
import com.service.popcornreview.vo.Movie;

@Controller
public class MovieController {

	@Autowired
	private MovieService movieService;
	
	@GetMapping("/")
	public String getMovieList(Model model) {		
		List<Movie> movieList = movieService.getAllMovies(null); 
		model.addAttribute("bannerMovies", movieList); 
		System.out.println("조회된 배너 영화 수: " + movieList);
		return "index";
	}
	
	// SERVICE-01: 영화 메인 페이지 (GET)
	@GetMapping("/index")
	public String getStats() {
		return "movietalkIndex";
	}
	
}
