package com.service.popcornreview.dto;

import java.util.List;

import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Review;

public class ReviewDetailDto {
    private final Review review;
    private final Movie movie;
    private final List<Comment> comments;

    public ReviewDetailDto(Review review, Movie movie, List<Comment> comments) {
        this.review = review;
        this.movie = movie;
        this.comments = comments;
    }

    public static ReviewDetailDto of(Review review, Movie movie, List<Comment> comments) {
        return new ReviewDetailDto(review, movie, comments);
    }

	public Review getReview() {
		return review;
	}

	public Movie getMovie() {
		return movie;
	}

	public List<Comment> getComments() {
		return comments;
	}

    
    // 게터 수동 추가 또는 record 사용도 가능(Java 16+)
}

