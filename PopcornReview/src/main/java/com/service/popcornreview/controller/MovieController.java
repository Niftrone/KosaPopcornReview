package com.service.popcornreview.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.service.popcornreview.service.MovieService;
import com.service.popcornreview.service.NoticeService;
import com.service.popcornreview.service.ReviewService;
import com.service.popcornreview.vo.Movie;

@Controller
public class MovieController {

	@Autowired
	private MovieService movieService;

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private NoticeService noticeService;

	@GetMapping("/")
	public String getIndexData(Model model) {
		System.out.println("MovieController: / 요청 확인");

	    model.addAttribute("bannerMovies", movieService.getAllMovies(null).stream().limit(5).toList()); 
	    model.addAttribute("recommendedMovies", movieService.getRecommendedMovies());
	    model.addAttribute("latestReviews", reviewService.getAllReviews(null).stream().limit(10).toList());
	    model.addAttribute("top10Movies", movieService.getAllMovies(null).stream().limit(10).toList());
	    model.addAttribute("upcomingMovies", movieService.getUpcomingMovies());
	    model.addAttribute("notices", noticeService.getNotices(null));
		
	    return "index";
	}
	
	/**
	 * 영화 상세 페이지 요청을 처리합니다. (예: /movie/123)
	 */
	@GetMapping("/movie/{movieId}")
	public String getMovieDetail(@PathVariable String movieId, Model model) {
	    Movie movie = movieService.getMovie(movieId); // 영화 한 개 정보 조회
	    model.addAttribute("movie", movie);
	    return "moviedetail"; // moviedetail.jsp로 이동
	}
	


}
