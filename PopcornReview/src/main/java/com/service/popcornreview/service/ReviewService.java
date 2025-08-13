package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.service.popcornreview.dao.CommentDao;
import com.service.popcornreview.dao.MovieDao;
import com.service.popcornreview.dao.ReviewDao;
import com.service.popcornreview.dao.UserDao;
import com.service.popcornreview.dto.ReviewDetailDto;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Service
public class ReviewService {

    @Autowired private ReviewDao reviewDao;
    @Autowired private UserDao userDao;
    @Autowired private MovieDao movieDao;
    @Autowired private CommentDao commentDao;

    @Transactional(readOnly = true)
    public List<Review> getAllReviews(Review condition) {
        List<Review> list = reviewDao.getAllReviews(condition);
        hydrateReviews(list); // ✅ 공통 헬퍼 호출
        return list;
    }

    @Transactional(readOnly = true)
    public Review getReview(int rId) {
        System.out.println("ReviewService...getReview");
        Review found = reviewDao.getReview(rId);
        hydrateReview(found); 
        return found;
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

    /* =========================
       🔧 공통 헬퍼 메서드들
       ========================= */

    /** 단일 리뷰의 연관(User, Movie) 정보를 보강 */
    private void hydrateReview(Review r) {
        if (r == null) return;

        // 1) User 정보 보강: id만 채워진 경우 전체 정보로 대체
        User partialUser = r.getUser();
        if (partialUser != null && partialUser.getId() != null) {
            User fullUser = userDao.getUser(partialUser);
            if (fullUser != null) {
            		fullUser.setPwd(null);
                r.setUser(fullUser);
            }
        }

        // 2) Movie 정보 보강: mId만 채워진 경우 제목 등 세부정보 채우기
        Movie movie = r.getMovie();
        if (movie != null && movie.getmId() != null) {
            Movie fullMovie = movieDao.getMovie(movie.getmId());
            if (fullMovie != null) {
                r.setMovie(fullMovie);
            }
        }
    }

    /** 리스트에 대해 일괄 보강 */
    private void hydrateReviews(List<Review> list) {
        if (list == null || list.isEmpty()) return;
        for (Review r : list) {
            hydrateReview(r);
        }
    }
}



