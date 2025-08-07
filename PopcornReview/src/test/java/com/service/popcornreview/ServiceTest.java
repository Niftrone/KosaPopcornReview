package com.service.popcornreview;

import com.service.popcornreview.service.ActorService;
import com.service.popcornreview.service.CommentService;
import com.service.popcornreview.service.MovieService;
import com.service.popcornreview.service.NoticeService;
import com.service.popcornreview.service.ReportService;
import com.service.popcornreview.service.ReviewService;
import com.service.popcornreview.service.UserService;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Notice;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;

import org.junit.jupiter.api.Test; // JUnit 5 for testing
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest; // Spring Boot test annotation
import org.springframework.test.context.ActiveProfiles; // Optional: if you have different profiles

import java.util.List;

// This annotation tells Spring Boot to load the full application context
// for testing purposes.
@SpringBootTest
// Optional: If you have different profiles (e.g., 'test' profile for H2 database)
// @ActiveProfiles("test")
public class ServiceTest {

    // All services are now properly injected by Spring
    @Autowired
    private ActorService actorService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private MovieService movieService;
    @Autowired
    private NoticeService noticeService;
    @Autowired
    private ReportService reportService;
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private UserService userService;

    // Use @Test annotation to define a test method that JUnit will run
    @Test
    public void runServiceTests() throws Exception { // Renamed from 'run' for clarity as a test method
        System.out.println("==============================================");
        System.out.println("======= 서비스 기능 실행을 시작합니다. =======");
        System.out.println("==============================================");

        // 각 서비스의 메서드를 순차적으로 호출합니다.
        // 주의: 실제 DB에 데이터를 넣고 조회하므로, 실행 순서가 중요할 수 있습니다.

        // 1. UserService 테스트
        System.out.println("\n---------- [UserService] 실행 ----------");
        User testUser = new User();
        testUser.setId("test-user-01");
        testUser.setPwd("1234");
        testUser.setName("테스트유저");
        testUser.setEmail("test@test.com");
        // ... 나머지 필드 설정

        System.out.println("addUser 호출...");
        int addUserResult = userService.addUser(testUser);
        System.out.println("-> addUser 결과: " + addUserResult);

        System.out.println("getUser 호출...");
        User foundUser = userService.getUser(testUser);
        System.out.println("-> getUser 결과: " + foundUser);

        // 2. MovieService 테스트
        System.out.println("\n---------- [MovieService] 실행 ----------");
        System.out.println("getRecommendedMovies 호출...");
        List<Movie> movies = movieService.getRecommendedMovies();
        System.out.println("-> getRecommendedMovies 결과 개수: " + (movies != null ? movies.size() : 0));

        System.out.println("getMovie(id) 호출...");
        // DB에 'm001' ID를 가진 영화가 있다고 가정합니다. 없다면 null이 반환됩니다.
        Movie foundMovie = movieService.getMovie("m001");
        System.out.println("-> getMovie 결과: " + foundMovie);

        // 3. ReviewService 테스트
        System.out.println("\n---------- [ReviewService] 실행 ----------");
        Review testReview = new Review();
        testReview.setUser(testUser); // 위에서 생성한 유저
        testReview.setMovie(foundMovie); // 위에서 찾은 영화
        testReview.setrRating(5);
        testReview.setrPlot("정말 재미있는 영화였어요!");

        System.out.println("addReview 호출...");
        int addReviewResult = reviewService.addReview(testReview);
        System.out.println("-> addReview 결과: " + addReviewResult);

        // 4. CommentService 테스트
        System.out.println("\n---------- [CommentService] 실행 ----------");
        Comment testComment = new Comment();
        testComment.setUser(testUser); // 위에서 생성한 유저
        testComment.setReview(testReview); // 위에서 생성한 리뷰
        testComment.setcPlot("리뷰 잘 봤습니다!");

        System.out.println("addComment 호출...");
        int addCommentResult = commentService.addComment(testComment);
        System.out.println("-> addComment 결과: " + addCommentResult);

        // 5. NoticeService, ReportService, ActorService 등 나머지 서비스도 동일한 방식으로 테스트 가능
        System.out.println("\n---------- [NoticeService] 실행 ----------");
        System.out.println("getNotices 호출...");
        List<Notice> notices = noticeService.getNotices(new Notice());
        System.out.println("-> getNotices 결과 개수: " + (notices != null ? notices.size() : 0));

        System.out.println("\n==============================================");
        System.out.println("========= 모든 서비스 기능 실행 완료! ========");
        System.out.println("==============================================");
    }
}