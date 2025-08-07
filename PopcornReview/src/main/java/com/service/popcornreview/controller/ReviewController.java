package com.service.popcornreview.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.service.popcornreview.service.CommentService;
import com.service.popcornreview.service.MovieService;
import com.service.popcornreview.service.NoticeService;
import com.service.popcornreview.service.ReportService;
import com.service.popcornreview.service.ReviewService;
import com.service.popcornreview.service.UserService;
import com.service.popcornreview.vo.Review;

@Controller
public class ReviewController {

	
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
	
	@PostMapping("/review/add")
	public String getaddReview(Review review) {
		
		try {
			int result = reviewService.addReview(review);
			System.out.println(result);
			return "moviedetail";
		} catch(Exception e) {
			return "error";
		}
	}
}
