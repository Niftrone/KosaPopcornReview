package com.service.popcornreview.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam; // RequestParam을 사용하기 위해 import 추가

import com.service.popcornreview.service.CommentService;
import com.service.popcornreview.service.MovieService;
import com.service.popcornreview.service.ReportService;
import com.service.popcornreview.service.ReviewService;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.ReportedReview;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;
import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/review") // 리뷰 관련 URL은 /review로 시작하도록 그룹화
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private CommentService commentService;
    
    @Autowired
    private MovieService movieService;
    
    @Autowired
    private ReportService rReviewService;
    

    /**
     * 리뷰 상세 페이지 요청을 처리합니다.
     * @param reviewId URL 경로에서 받아온 리뷰의 ID (예: /review/101)
     * @param model JSP로 데이터를 전달할 객체
     */
    @GetMapping("/{reviewId}") // [수정] 파라미터명을 reviewId로 명확하게 변경
    public String getReviewDetail(@PathVariable int reviewId, Model model) {
        Review review = reviewService.getReview(reviewId); 
        
        if (review != null) {
            // 2. [수정] 조회된 리뷰 객체에서 영화 ID를 꺼내 관련 영화 정보를 가져옵니다.
            // Movie VO의 getmId()는 Integer를 반환하므로 int 타입으로 받아야 합니다.
            int movieId = review.getMovie().getmId();
            Movie movie = movieService.getMovie(movieId);
            Comment comment = new Comment();
            comment.setReview(review);
            
            List<Comment> foundComments = commentService.getComments(comment);
            
            // 3. [수정] Model을 사용해 JSP로 데이터를 전달합니다. (HttpSession 대신)
            model.addAttribute("reviewDetail", review);
            model.addAttribute("movieDetail", movie);
            model.addAttribute("commentList",foundComments);
        } else {
            // 해당 ID의 리뷰가 없을 경우 예외 처리
            System.out.println(reviewId + "번 리뷰를 찾을 수 없습니다.");
        }
        
        return "reviewdetail"; // /WEB-INF/views/reviewdetail.jsp
    }
    

	// REVIEW-04: 리뷰 등록 (POST /review/add)
	@PostMapping("/add")
	public String getaddReview(Review review,HttpSession session) {
		
		 try {
		        // 1. 세션에서 로그인한 사용자 정보를 가져옵니다.
		        User loginUser = (User) session.getAttribute("loginUser");

		        // 2. 만약 로그인 정보가 없다면, 에러 페이지로 보냅니다.
		        if (loginUser == null) {
		            // Or redirect to the login page
		            return "error"; 
		        }

		        // 3. 리뷰 객체에 사용자 정보를 설정합니다.
		        review.setUser(loginUser);

		        // 4. 사용자 정보가 포함된 리뷰를 서비스로 전달하여 저장합니다.
		        reviewService.addReview(review);
		        
		        return "redirect:/movie/detail?mId=" + review.getMovie().getmId();

		    } catch(Exception e) {
		        e.printStackTrace();
		        return "error";
		    }
    }

	// REVIEW-05: 리뷰 삭제 (POST /review/delete)
	@PostMapping("/delete")
	public String deleteReview(@RequestParam("rId") int rId, HttpSession session) {
		/* [보안 강화] 현재 로그인한 사용자가 리뷰 작성자인지 확인하는 로직을 추가하는 것이 좋습니다.
		   User loginUser = (User) session.getAttribute("loginUser");
		   Review review = reviewService.getReviewById(rId);
		   if (review == null || !review.getUser().getId().equals(loginUser.getId())) {
		       return "error"; // 권한 없음
		   }
		*/


		// 1. 삭제하기 전에, 리다이렉트할 영화 ID(mId)를 먼저 조회해서 변수에 저장합니다.
		Review review = reviewService.getReview(rId); // ID로 리뷰 전체 정보를 가져오는 서비스 메서드가 필요합니다.
		if (review == null) {
			return "error"; // 또는 적절한 에러 페이지
		}
		int movieId = review.getMovie().getmId();

		// 2. 리뷰 삭제 서비스를 호출합니다.
		reviewService.deleteReview(rId);
		
		// 3. 저장해둔 movieId를 이용해 영화 상세 페이지로 돌아갑니다.
		return "redirect:/movie/detail?mId=" + movieId;
	}
	
	// REVIEW-06: 리뷰 수정 (POST /review/update)
	@PostMapping("/update")
	public String updateReview(Review review, HttpSession session) { // 수정할 내용(rId, rRating, rPlot)을 Review 객체로 받습니다.
		/*
		   [보안 강화] 삭제와 마찬가지로 작성자 본인인지 확인하는 로직을 추가하는 것이 좋습니다.
		*/

		// 1. 리다이렉트에 필요한 영화 ID(mId)를 얻기 위해 원본 리뷰 정보를 조회합니다.
		Review originalReview = reviewService.getReview(review.getrId());
		if (originalReview == null) {
			return "error";
		}
		int movieId = originalReview.getMovie().getmId();
		originalReview.setrPlot(review.getrPlot());
		originalReview.setrRating(review.getrRating());
		
		// 2. 폼에서 넘어온 새로운 내용으로 리뷰 수정을 요청합니다.
		//    (서비스에서는 rId를 기준으로 rRating과 rPlot을 업데이트하도록 구현)
		reviewService.updateReview(originalReview);
		System.out.println(movieId);
		// 3. 조회해둔 movieId를 이용해 영화 상세 페이지로 돌아갑니다.
		return "redirect:/movie/detail?mId=" + movieId;
	}

	// REVIEW-07: 리뷰 신고 (POST /review/reported)
	@PostMapping("/reported")
	public String addReported(ReportedReview rReview, HttpSession session) { 
		
		// 1. 세션에서 로그인 사용자 정보를 가져와 신고자 정보로 설정합니다.
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        // 비로그인 사용자는 신고할 수 없도록 처리
	        return "error"; 
	    }
	    rReview.setUser(loginUser);
		/*
	       [보안 강화] 로그인한 사용자만 신고할 수 있도록 세션 정보를 활용해
	       rReview 객체에 신고자(User) 정보를 설정해주는 것이 좋습니다.
	       User loginUser = (User) session.getAttribute("loginUser");
	       if (loginUser == null) return "error";
	       rReview.setUser(loginUser);
	    */
	 // 2. 리다이렉트에 필요한 영화 ID를 얻기 위해 원본 리뷰 정보를 조회합니다.
	    Review reportedReview = reviewService.getReview(rReview.getReview().getrId());
	    if (reportedReview == null) {
	        return "error"; // 신고하려는 리뷰가 없는 경우
	    }
	    int movieId = reportedReview.getMovie().getmId();

	    // 3. 모든 정보가 담긴 rReview 객체를 DB에 저장합니다.
	    rReviewService.insertReported(rReview);
	    
	    // 4. 원래의 영화 상세 페이지로 돌아갑니다.
	    return "redirect:/movie/detail?mId=" + movieId;	}
}