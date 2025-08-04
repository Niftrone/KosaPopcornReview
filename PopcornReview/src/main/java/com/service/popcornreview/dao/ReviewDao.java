package com.service.popcornreview.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Notice;
import com.service.popcornreview.vo.Review;
@Repository
public class ReviewDao {
	
	public static final String NS = "ns.sql.NoticeMapper.";

	 @Autowired
	    private SqlSession sqlSession;

	 
	
	    public List<Review> getAllReviews(Review review) {
	        return sqlSession.selectList(NS + "getAllReviews", review);
	    }

	   
	    public int addReview(Review review) {
	        return sqlSession.insert(NS + "addReview", review);
	    }

	
	    public int updateReview(Review review) {
	        return sqlSession.update(NS + "updateReview", review);
	    }

	
	    public int deleteReview(int rId) {
	        return sqlSession.delete(NS + "deleteReview", rId);
	    }
}