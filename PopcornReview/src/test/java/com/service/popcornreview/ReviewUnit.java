package com.service.popcornreview;

import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

public class ReviewUnit {

    @Test
    public void addReviewTest() throws IOException {
        // 리뷰 등록 테스트
        Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
        SqlSession session = factory.openSession();

        // --- Arrange: 테스트 데이터 준비 ---
        // DB에 존재하는 User와 Movie 객체를 생성합니다.
        User testUser = new User();
        testUser.setId("user01");

        Movie testMovie = new Movie();
        testMovie.setmId("m02");

        // 등록할 Review 객체 생성
        Review review = new Review();
       
        review.setrRating(5);
        review.setrPlot("이 영화 정말 최고예요! 강력 추천합니다.");
        review.setUser(testUser);
        review.setMovie(testMovie);
        
   
        int result = session.insert("ns.sql.ReviewMapper.addReview", review);
        session.commit();
        
        System.out.println("리뷰 추가 결과 (1이면 성공): " + result);
        System.out.println("추가된 리뷰 ID: " + review.getrId()); 
        session.close();
    }
    
    @Test
    public void getLatestReviewsTest() throws IOException {
        // 최근 리뷰 목록 조회 테스트
        Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
        SqlSession session = factory.openSession();

        
        List<Review> list = session.selectList("ns.sql.ReviewMapper.getLatestReviews");
        System.out.println("--- 최근 리뷰 목록 ---");
        for (Review review : list) {
            System.out.println("리뷰 ID: " + review.getrId() + ", 내용: " + review.getrPlot() + ", 작성일: " + review.getrDate());
        }
        session.close();
    }

    @Test
    public void updateReviewTest() throws IOException {
        // 리뷰 수정 테스트
        Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
        SqlSession session = factory.openSession();

        Review review = new Review();
        review.setrId(1); 
        review.setrRating(1);
        review.setrPlot("리뷰 내용이 수정되었습니다. 생각보다 별로네요.");

        int result = session.update("ns.sql.ReviewMapper.updateReview", review);
        session.commit();
        System.out.println("리뷰 수정 결과 (1이면 성공): " + result);
        session.close();
    }

    @Test
    public void deleteReviewTest() throws IOException {
        // 리뷰 삭제 테스트
        Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
        SqlSession session = factory.openSession();

      
        int reviewIdToDelete = 15; 
        int result = session.delete("ns.sql.ReviewMapper.deleteReview", reviewIdToDelete); 
        session.commit();
        System.out.println("리뷰 삭제 결과 (1이면 성공): " + result);
        session.close();
    }
}
