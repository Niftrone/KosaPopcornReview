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
            reviewService.addReview(review);
            
            // ★★★ [핵심] ★★★
            // 리뷰 등록 후, 현재 영화 상세 페이지로 '다시 접속(redirect)'하게 만듭니다.
            // 이렇게 해야 새로고침해도 리뷰가 중복 등록되지 않습니다.
            return "redirect:/movie/detail?mId=" + review.getMovie().getmId();

        } catch(Exception e) {
            e.printStackTrace(); // 에러 로그를 콘솔에 출력
            return "error"; // 에러 발생 시 error.jsp 페이지로 이동
        }
    }
}
