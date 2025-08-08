package com.service.popcornreview.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.service.popcornreview.service.MovieService;
import com.service.popcornreview.service.ReviewService;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Review;


@Controller
@RequestMapping("/review") // 리뷰 관련 URL은 /review로 시작하도록 그룹화
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private MovieService movieService;

    /**
     * 리뷰 상세 페이지 요청을 처리합니다.
     * @param reviewId URL 경로에서 받아온 리뷰의 ID (예: /review/101)
     * @param model JSP로 데이터를 전달할 객체
     */
    @GetMapping("/{reviewId}") // [수정] 파라미터명을 reviewId로 명확하게 변경
    public String getReviewDetail(@PathVariable int reviewId, Model model) {
    		Review foundReview = new Review();
    		foundReview.setrId(reviewId);
        Review review = reviewService.getReview(foundReview); 
        
        
        if (review != null) {
            // 2. [수정] 조회된 리뷰 객체에서 영화 ID를 꺼내 관련 영화 정보를 가져옵니다.
            String movieId = review.getMovie().getmId();
            Movie movie = movieService.getMovie(movieId);

            // 3. [수정] Model을 사용해 JSP로 데이터를 전달합니다. (HttpSession 대신)
            model.addAttribute("reviewDetail", review);
            model.addAttribute("movieDetail", movie);
        } else {
            // 해당 ID의 리뷰가 없을 경우 예외 처리
            System.out.println(reviewId + "번 리뷰를 찾을 수 없습니다.");
        }
        
        return "reviewdetail"; // /WEB-INF/views/reviewdetail.jsp
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
