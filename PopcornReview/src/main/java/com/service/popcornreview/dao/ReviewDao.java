package com.service.popcornreview.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.popcornreview.vo.Review;

@Repository
public class ReviewDao {

	public static final String NS = "ns.sql.ReviewMapper.";

	@Autowired
	private SqlSession sqlSession;

	public List<Review> getAllReviews(Review review) {
		System.out.println("ReviewDao...getAllReviews");
		return sqlSession.selectList(NS + "getAllReviews", review);
	}

	public Review getReview(Review review) {
		System.out.println("ReviewDao...getAllReviews");
		return sqlSession.selectOne(NS + "getAllReviews", review);
	}
	
	public int addReview(Review review) {
		System.out.println("ReviewDao...addReview");
		return sqlSession.insert(NS + "addReview", review);
	}

	public int updateReview(Review review) {
		System.out.println("ReviewDao...updateReview");
		return sqlSession.update(NS + "updateReview", review);
	}

	public int deleteReview(int rId) {
		System.out.println("ReviewDao...deleteReview");
		return sqlSession.delete(NS + "deleteReview", rId);
	}
	//user 삭제될떄 추가하기 위해서 
	public int deleteReviewsByUserId(String userId) {
	    System.out.println("ReviewDao...deleteReviewsByUserId");
	    return sqlSession.delete(NS + "deleteReviewsByUserId", userId);
	}
}