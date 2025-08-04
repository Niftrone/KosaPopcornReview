package com.service.popcornreview;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.jupiter.api.Test;

import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.ReportedReview;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;

public class ReviewUnitTest {
	private static final String NS = "ns.sql.ReviewrMapper.";
	private SqlSession getSqlSession() throws Exception {
		Reader reader = Resources.getResourceAsReader("config/SqlMapConfig.xml");
		SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(reader);
		SqlSession session = factory.openSession();
		return session;
	}
	
	@Test
	public void getAllReviews() throws Exception {
		SqlSession session = getSqlSession();
		List<Review> list = session.selectList(NS+"getAllReviews");
		for (Review r : list) {
            System.out.println("신고된 리뷰 : " + r);
        }
	}
	
    @Test
    public void addReviewTest() throws Exception {
        // 리뷰 등록 테스트
        SqlSession session = getSqlSession();

        // --- Arrange: 테스트 데이터 준비 ---
        // DB에 존재하는 User와 Movie 객체를 생성합니다.
        User testUser = new User();
        testUser.setId("user10");

        Movie testMovie = new Movie();
        testMovie.setmId("m02");

        // 등록할 Review 객체 생성
        Review review = new Review();
       
        review.setrRating(5);
        review.setrPlot("이 영화 정말 최고예요! 강력 추천합니다.");
        review.setUser(testUser);
        review.setMovie(testMovie);
   
        int result = session.insert(NS + "addReview", review);
        session.commit();
        
        System.out.println("리뷰 추가 결과 (1이면 성공): " + result);
        System.out.println("추가된 리뷰 ID: " + review.getrId()); 
        session.close();
    }
	
    @Test
    public void updateReviewTest() throws Exception {
        // 리뷰 수정 테스트
        SqlSession session = getSqlSession();

        Review review = new Review();
        review.setrId(1); 
        review.setrRating(1);
        review.setrPlot("리뷰 내용이 수정되었습니다. 생각보다 별로네요.");

        int result = session.update(NS + "updateReview", review);
        session.commit();
        System.out.println("리뷰 수정 결과 (1이면 성공): " + result);
        session.close();
    }
    
    @Test
    public void deleteReviewTest() throws Exception {
        // 리뷰 삭제 테스트
        SqlSession session = getSqlSession();

        int reviewIdToDelete = 15; 
        int result = session.delete(NS + "deleteReview", reviewIdToDelete); 
        session.commit();
        System.out.println("리뷰 삭제 결과 (1이면 성공): " + result);
        session.close();
    }

}
