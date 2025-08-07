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
	MovieService movieService;
	@Autowired
	NoticeService noticeService;
	@Autowired
	ReportService reportService;
	@Autowired
	UserService userService;
	@Autowired
	ReviewService reviewService;
	@Autowired
	CommentService commentService;
	
	// SERVICE-01: 영화 상세 페이지 접속 (GET)
	@GetMapping("/movie/detail")
	public String getMovieDetail(Movie movie,Model model) throws Exception {
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
