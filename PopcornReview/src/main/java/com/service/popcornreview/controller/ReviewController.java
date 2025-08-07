package com.service.popcornreview.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.service.popcornreview.service.ReviewService;
import com.service.popcornreview.vo.Review;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	// REVIEW-02, 03, 10: 리뷰 상세 보기 (GET /review/detailreview?id=...)
	@GetMapping("/{reviewrId}")
	public String getReviewDetail() {
		// DB에서 특정 리뷰의 상세 정보를 가져오는 로직
		return "reviewdetail";
	}

	// REVIEW-04: 리뷰 등록 (POST /review/add)
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

	// REVIEW-05: 리뷰 삭제 (POST /review/delete)
	@PostMapping("/delete")
	public String deleteReview() {
		// 사용자가 자신의 리뷰를 삭제하는 로직
		return "redirect:/mypage";
	}
	
	// REVIEW-06: 리뷰 수정 (POST /review/update)
	@PostMapping("/update")
	public String updateReview() {
		// 사용자가 자신의 리뷰를 수정하는 로직
		return "redirect:/review/detailreview?id=...";
	}

	// REVIEW-07: 리뷰 신고 (POST /review/reported)
	@PostMapping("/reported")
	public String addReported() {
		// 사용자가 불쾌한 리뷰를 신고하는 로직
		return "redirect:/review/detailreview?id=...";
	}
}
