package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.ReviewDao;
import com.service.popcornreview.vo.Review;

@Service
public class ReviewService {

	@Autowired
	private ReviewDao reviewDaoImpl;

	public List<Review> getAllReviews(Review review) {
		System.out.println("ReviewService...getAllReviews");
		return reviewDaoImpl.getAllReviews(review);
	}

	public int addReview(Review review) {
		System.out.println("ReviewService...addReview");
		return reviewDaoImpl.addReview(review);
	}

	public int updateReview(Review review) {
		System.out.println("ReviewService...updateReview");
		return reviewDaoImpl.updateReview(review);
	}

	public int deleteReview(int rId) {
		System.out.println("ReviewService...deleteReview");
		return reviewDaoImpl.deleteReview(rId);
	}
}
