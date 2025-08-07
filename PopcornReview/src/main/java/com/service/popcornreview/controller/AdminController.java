package com.service.popcornreview.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.service.popcornreview.service.MovieService;
import com.service.popcornreview.service.NoticeService;
import com.service.popcornreview.service.ReportService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	MovieService movieService;
	@Autowired
	NoticeService noticeService;
	@Autowired
	ReportService reportService;
	
	// ADMIN-01: 영화 정보 등록 (POST)
	@PostMapping("/movie/add")
	public String doAddMovie() {
		// 관리자가 새로운 영화 정보를 DB에 등록하는 로직
		return "admin"; // or redirect
	}
	
	// ADMIN-02: 영화 정보 수정 (POST)
	@PostMapping("/movie/update")
	public String doUpdateMovie() {
		// 관리자가 기존 영화 정보를 수정하는 로직
		return "admin"; // or redirect
	}
	
	// ADMIN-03: 영화 정보 삭제 (POST)
	@PostMapping("/movie/delete")
	public String doDeleteMovie() {
		// 관리자가 영화 정보를 DB에서 삭제하는 로직
		return "admin"; // or redirect
	}

	// ADMIN-04: 신고 리뷰 목록 (GET)
	@GetMapping("/review/list")
	public String getReviewListAdmin() {
		// 관리자가 시스템의 모든 신고된 리뷰 목록을 확인하는 로직
		return "admin"; // or redirect
	}

	// ADMIN-05: 리뷰 삭제 (POST)
	@PostMapping("/review/delete")
	public String doDeleteReviewAdmin() {
		// 관리자가 특정 리뷰를 삭제하는 로직
		return "admin"; // or redirect
	}

	// ADMIN-06: 공지사항 목록 (GET)
	@GetMapping("/notice/list")
	public String getNoticeListAdmin() {
		// 관리자가 모든 공지사항 목록을 확인하는 로직
		return "admin"; // or redirect
	}

	// ADMIN-07: 공지사항 등록 (POST)
	@PostMapping("/notice/add")
	public String doAddNotice() {
		// 관리자가 새로운 공지사항을 등록하는 로직
		return "admin"; // or redirect
	}

	// ADMIN-08: 공지사항 수정 (POST)
	@PostMapping("/notice/update")
	public String doUpdateNotice() {
		// 관리자가 기존 공지사항을 수정하는 로직
		return "admin"; // or redirect
	}

	// ADMIN-09: 공지사항 삭제 (POST)
	@PostMapping("/notice/delete")
	public String doDeleteNotice() {
		// 관리자가 공지사항을 삭제하는 로직
		return "admin"; // or redirect
	}
}