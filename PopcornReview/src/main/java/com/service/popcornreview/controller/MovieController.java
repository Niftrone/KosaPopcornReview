package com.service.popcornreview.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.service.popcornreview.dto.AudienceStatsDto;
import com.service.popcornreview.dto.ReviewStatsDto;
import com.service.popcornreview.dto.SummaryResponse;
import com.service.popcornreview.service.ActorService;
import com.service.popcornreview.service.CommentService;
import com.service.popcornreview.service.MovieService;
import com.service.popcornreview.service.NoticeService;
import com.service.popcornreview.service.ReportService;
import com.service.popcornreview.service.ReviewService;
import com.service.popcornreview.service.SmartService;
import com.service.popcornreview.service.UserService;
import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Review;
import java.util.stream.Collectors;

@Controller
public class MovieController {

	@Autowired
	private MovieService movieService;

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private NoticeService noticeService;

	@Autowired
	private ActorService actorService;
	
	@Autowired
	private SmartService smartService;


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
		
	@GetMapping("/movie/search")
	public String getSearchMovie(String query,Model model) {
		
		try {
			List<Movie> movies = movieService.searchMovies(query);
			
			model.addAttribute("movies",movies);
			System.out.println("movies=>"+movies);
			model.addAttribute("query", query);
			return "SearchResult";
		} catch(Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
	
	/**
	 * 영화 상세 페이지 요청을 처리합니다. (예: /movie/123)
	 */
	@GetMapping("/movie/{movieId}")
	public String getMovieDetail(@PathVariable int movieId, Model model) {
	    Movie movie = movieService.getMovie(movieId); // 영화 한 개 정보 조회
	    model.addAttribute("movie", movie);
	    return "moviedetail"; // moviedetail.jsp로 이동
	}
	
	@GetMapping("/movie/detail")
	public String getMovieDetail(Movie movie, Model model) {
		System.out.println("getMovieDetail.....Controller.....");
		
	    try {
	        // 영화 기본 정보 조회
	        movie = movieService.getMovie(movie.getmId());
	        
	        // 해당 영화의 모든 리뷰 목록 조회
	        Review review = new Review();
	        review.setMovie(movie);
	        List<Review> list = reviewService.getAllReviews(review);
	       
	        
	        for(Review r :list) {
	        	System.out.println("user=>"+r.getUser());
	        }
	        // ★ [수정됨] movieId 대신, 위에서 가져온 'list'를 그대로 전달합니다.
	        AudienceStatsDto audienceStats = movieService.getAudienceStats(list);
	        
	     // ★ [추가] 리뷰 리포트 데이터 조회
	        ReviewStatsDto reviewStats = movieService.getReviewStats(list);
	        
		        List<String> reviewTexts = list.stream()
		                                          .map(Review::getrPlot)
		                                          .collect(Collectors.toList());
		        SummaryResponse summaryResponse =  smartService.getSummary(movie,reviewTexts);
		        
		     // [수정] .getSummary()를 이용해 객체 안의 문자열(String)을 꺼냅니다.
		        String summaryText = summaryResponse.getSummary();
	        
	        
	        model.addAttribute("movie", movie);
	        model.addAttribute("reviews", list);
	        model.addAttribute("audienceStats", audienceStats);
	        model.addAttribute("reviewStats", reviewStats); // ★ 리뷰 통계 데이터 추가
	        model.addAttribute("summary", summaryText);
	        
	        
	   
	        return "moviedetail";

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error";
	    }
	}
	@GetMapping("/movie/actordetail")
	public String getActorDetail(Actor actor, Model model) {
	    // 1. 파라미터로 받은 actorId를 사용해 DB에서 해당 배우의 정보를 조회합니다.
			try {
			actor = actorService.getActor(actor.getaId());
			
		    // 2. 조회된 배우 정보를 모델에 담습니다.
		    
			model.addAttribute("actor", actor);
			// 
		    
		    // 3. 배우 상세 정보를 보여줄 JSP 페이지를 반환합니다.
		    return "actorDetail"; 
			} catch (Exception e) {
				return "error";
			}
	}
}
