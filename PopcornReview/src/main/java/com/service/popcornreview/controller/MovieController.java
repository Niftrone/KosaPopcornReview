package com.service.popcornreview.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.service.popcornreview.dto.AudienceStatsDto;
import com.service.popcornreview.dto.ReviewStatsDto;
import com.service.popcornreview.service.ActorService;
import com.service.popcornreview.service.CommentService;
import com.service.popcornreview.service.MovieService;
import com.service.popcornreview.service.NoticeService;
import com.service.popcornreview.service.ReportService;
import com.service.popcornreview.service.ReviewService;
import com.service.popcornreview.service.UserService;
import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Review;


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
	        System.out.println("list=>"+list);

	        // ★ [수정됨] movieId 대신, 위에서 가져온 'list'를 그대로 전달합니다.
	        AudienceStatsDto audienceStats = movieService.getAudienceStats(list);
	        
	     // ★ [추가] 리뷰 리포트 데이터 조회
	        ReviewStatsDto reviewStats = movieService.getReviewStats(list);
	        
	        // ... (요약 서비스 및 모델 추가 로직) ...
	        
	        model.addAttribute("movie", movie);
	        model.addAttribute("reviews", list);
	        model.addAttribute("audienceStats", audienceStats);
	        model.addAttribute("reviewStats", reviewStats); // ★ 리뷰 통계 데이터 추가
	        model.addAttribute("summary", """
	        	    🙇‍♀️ 정말 미안해… 조금만 기다려줘
	        	    안녕!
	        	    지금 너무 바쁘게 움직이고 있었는데, 네가 기다리고 있을 걸 생각하니 마음이 계속 쓰였어.

	        	    🕒 생각보다 오래 걸리게 해서 정말 미안해.
	        	    일부러 그런 건 아니야.
	        	    조금만 정리하면 바로 끝나니까 진짜 금방 끝내고 네게 갈게.

	        	    🙏 너무 기다리게 해서 미안하고, 고맙고, 미안해.
	        	    나를 이해해주고 기다려줘서 늘 고마워.
	        	    이런 사소한 약속이라도 소중하게 여기는 너니까, 나도 더 책임감 있게 움직일게.

	        	    💨 조금만 더! 진짜 금방 할게!
	        	    딱! 잠깐만 기다려줘.
	        	    최대한 빨리 끝내고, 미소 지으며 네 앞에 다시 나타날게. 약속할게 🤞
	        	""");
	        // ...

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
