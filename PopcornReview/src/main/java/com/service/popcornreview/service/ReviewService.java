package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.MovieDao;
import com.service.popcornreview.dao.ReviewDao;
import com.service.popcornreview.dao.UserDao;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;

@Service
public class ReviewService {

	@Autowired
	private ReviewDao reviewDao;
	
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private MovieDao movieDao;
	
	public List<Review> getAllReviews(Review review) {
		List<Review> list = reviewDao.getAllReviews(review);

	    for(Review r : list) {
	        // User 정보 채우기
	        User partialUser = r.getUser(); // id만 있는 유저 객체
	        if (partialUser != null && partialUser.getId() != null) {
	            User fullUser = userDao.getUser(partialUser); // DB에서 전체 정보 조회
	            
	            // ✅ 새로 조회한 정보가 null이 아닐 때만 덮어쓰기
	            if (fullUser != null) {
	                r.getUser().setName(fullUser.getName());
	            }
	        }

			// 2. [수정] Movie 정보 채우기
			Movie movie = r.getMovie();
			if (movie != null && movie.getmId() != null) {
				movie = movieDao.getMovie(movie.getmId()); // MovieDao를 통해 전체 영화 정보 조회
				r.getMovie().setmTitle(movie.getmTitle()); // 조회된 정보로 교체
			}
		}
		return list;
	}

	
	public Review getReview(Review review) {
		System.out.println("ReviewService...getReview");
		return reviewDao.getReview(review);
	}

	public int addReview(Review review) {
		System.out.println("ReviewService...addReview");
		return reviewDao.addReview(review);
	}

	public int updateReview(Review review) {
		System.out.println("ReviewService...updateReview");
		return reviewDao.updateReview(review);
	}

	public int deleteReview(int rId) {
		System.out.println("ReviewService...deleteReview");
		return reviewDao.deleteReview(rId);
	}
}
