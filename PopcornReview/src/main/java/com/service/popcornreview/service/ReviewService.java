package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.ActorDao;
import com.service.popcornreview.dao.CommentDao;
import com.service.popcornreview.dao.NoticeDao;
import com.service.popcornreview.dao.ReportDao;
import com.service.popcornreview.dao.ReviewDao;
import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Notice;
import com.service.popcornreview.vo.ReportedReview;
import com.service.popcornreview.vo.Review;

@Service
public class ReviewService {

	 @Autowired
	    private ReviewDao reviewDaoImpl;

	    public List<Review> getAllReviews(Review review) {
	        return reviewDaoImpl.getAllReviews(review);
	    }

	    public int addReview(Review review) {
	        return reviewDaoImpl.addReview(review);
	    }

	    public int updateReview(Review review) {
	        return reviewDaoImpl.updateReview(review);
	    }

	    public int deleteReview(int rId) {
	        return reviewDaoImpl.deleteReview(rId);
	    }
}
