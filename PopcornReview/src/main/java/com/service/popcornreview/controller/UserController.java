package com.service.popcornreview.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.service.popcornreview.service.CommentService;
import com.service.popcornreview.service.NoticeService;
import com.service.popcornreview.service.ReportService;
import com.service.popcornreview.service.UserService;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Review;

import ch.qos.logback.core.net.SyslogOutputStream;
import com.service.popcornreview.service.ReviewService;
import com.service.popcornreview.service.UserService;


@Controller
public class UserController {
	
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private ReportService reportService;
	@Autowired
	private UserService userService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private CommentService commentService;


	
	// USER-01: 로그인 (POST)
	@PostMapping("/user/login")
	public String doLogin() {
		// 사용자 로그인 처리 로직
		return "redirect:/"; // or other page
	}

	// USER-02: 회원가입 (POST)
	@PostMapping("/user/register")
	public String addUser() {
		// 신규 회원 정보를 DB에 추가하는 로직
		return "redirect:/user/login";
	}

	public String doaddReview() {
		// 사용자가 작성한 리뷰를 DB에 등록하는 로직
		return "reviewdetail";
	}

	// REVIEW-05: 리뷰 삭제 (POST)
	@PostMapping("/review/delete")
	public String doDeleteReview() {
		// 사용자가 자신의 리뷰를 삭제하는 로직
		return "mypage";
	}
	
	// REVIEW-06: 리뷰 수정 (POST)
	@PostMapping("/review/update")
	public String doUpdateReview() {
		// 사용자가 자신의 리뷰를 수정하는 로직
		return "reviewdetail";
	}

	// REVIEW-07: 리뷰 신고 (POST)
	@PostMapping("/review/reported")
	public String doAddReported() {
		// 사용자가 불쾌한 리뷰를 신고하는 로직
		return "reviewdetail";
	}
	
	// REVIEW-08: 내 리뷰 목록 (GET)
	@GetMapping("/review/mypage")
	public String doUserReviews() {
		// 마이페이지에서 내가 작성한 모든 리뷰 목록을 가져오는 로직
		return "mypage";
	}

	// REVIEW-09: 내 댓글 목록 (GET)
	@GetMapping("/review/my-comments")
	public String getMyCommentList() {
		// 마이페이지에서 내가 작성한 모든 댓글 목록을 가져오는 로직
		return "mypage";
	}

	// SEARCH-01: 영화 검색 (GET)
	@GetMapping("/search")
	public String doSearch() {
		// 키워드로 영화를 검색하는 로직
		return "search";
	}


}