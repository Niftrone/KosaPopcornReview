package com.service.popcornreview.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.service.popcornreview.service.CommentService;
import com.service.popcornreview.service.MovieService;
import com.service.popcornreview.service.NoticeService;
import com.service.popcornreview.service.ReportService;
import com.service.popcornreview.service.ReviewService;
import com.service.popcornreview.service.UserService;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Review;


@Controller
public class MovieController {

	@Autowired
	private MovieService movieService;
	private ReviewService reviewService;
	
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
	
	// SERVICE-01: 영화 상세 페이지 접속 (GET)
	@GetMapping("/movie/detail")
	public String getMovieDetail(Movie movie,Model model)  {
		Review review = new Review();
		
		try {
			movie = movieService.getMovie(movie.getmId());
			review.setMovie(movie);
			List<Review> list = reviewService.getAllReviews(review);
			model.addAttribute("movie", movie);
			model.addAttribute("list", list);
			model.addAttribute("summary","여기는 요약하는 부분입니다. 요약 하는 과정이 쉽지는 않겠지만, 모두 친절히 바라봐주세요.");
			return "moviedetail";
		} catch(Exception e) {
			return "error";
		}
	}
}
