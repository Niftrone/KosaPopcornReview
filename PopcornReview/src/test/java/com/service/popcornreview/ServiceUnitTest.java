package com.service.popcornreview;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Collections;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import com.service.popcornreview.dao.*;
import com.service.popcornreview.service.*;
import com.service.popcornreview.vo.*;

@SpringBootTest
@DisplayName("Popcorn Review 전체 서비스 단위 테스트")
class PopcornReviewServiceTest {

    // 가짜 DAO 객체들
    @MockBean private ActorDao actorDao;
    @MockBean private CommentDao commentDao;
    @MockBean private MovieDao movieDao;
    @MockBean private NoticeDao noticeDao;
    @MockBean private ReportDao reportDao;
    @MockBean private ReviewDao reviewDao;
    @MockBean private UserDao userDao;

    // 실제 서비스 객체들
    @Autowired private ActorService actorService;
    @Autowired private CommentService commentService;
    @Autowired private MovieService movieService;
    @Autowired private NoticeService noticeService;
    @Autowired private ReportService reportService;
    @Autowired private ReviewService reviewService;
    @Autowired private UserService userService;

    // 테스트용 데이터 선언
    private User testUser;
    private Movie testMovie;
    private Review testReview;
    private Comment testComment;
    
    // @BeforeEach: 각 @Test가 실행되기 전에 항상 먼저 실행되는 부분
    @BeforeEach
    void setUp() {
        // 테스트에 사용할 객체들을 미리 생성
        testUser = new User();
        testUser.setId("testId");

        testMovie = new Movie();
        testMovie.setmId("m01");

        testReview = new Review();
        testReview.setrId(1);

        testComment = new Comment();
        testComment.setcId(1);
    }

    @Nested
    @DisplayName("ActorService 테스트")
    class ActorServiceTests {
        @Test
        @DisplayName("배우 정보 조회")
        void testGetActor() {
            // given
            when(actorDao.getActor(anyString())).thenReturn(new Actor());
            // when
            Actor actor = actorService.getActor("a01");
            // then
            assertThat(actor).isNotNull();
            verify(actorDao).getActor("a01");
        }
    }

    @Nested
    @DisplayName("CommentService 테스트")
    class CommentServiceTests {
        @Test @DisplayName("댓글 추가")
        void testAddComment() {
            when(commentDao.addComment(any(Comment.class))).thenReturn(1);
            int result = commentService.addComment(testComment);
            assertThat(result).isEqualTo(1);
            verify(commentDao).addComment(testComment);
        }

        @Test @DisplayName("댓글 삭제")
        void testDeleteComment() {
            when(commentDao.deleteComment(anyInt())).thenReturn(1);
            int result = commentService.deleteComment(1);
            assertThat(result).isEqualTo(1);
            verify(commentDao).deleteComment(1);
        }

        @Test @DisplayName("댓글 수정")
        void testUpdateComment() {
            when(commentDao.updateComment(any(Comment.class))).thenReturn(1);
            int result = commentService.updateComment(testComment);
            assertThat(result).isEqualTo(1);
            verify(commentDao).updateComment(testComment);
        }

        @Test @DisplayName("댓글 목록 조회")
        void testGetComments() {
            when(commentDao.getComments(any(Comment.class))).thenReturn(Collections.singletonList(testComment));
            List<Comment> comments = commentService.getComments(new Comment());
            assertThat(comments).isNotNull().hasSize(1);
            verify(commentDao).getComments(any(Comment.class));
        }
    }

    @Nested
    @DisplayName("MovieService 테스트")
    class MovieServiceTests {
        @Test @DisplayName("영화 단일 조회")
        void testGetMovie() {
            when(movieDao.getMovie(anyString())).thenReturn(testMovie);
            Movie movie = movieService.getMovie("m01");
            assertThat(movie).isNotNull();
            verify(movieDao).getMovie("m01");
        }

        @Test @DisplayName("모든 영화 조회")
        void testGetAllMovies() {
            when(movieDao.getAllMovies(any(Movie.class))).thenReturn(Collections.singletonList(testMovie));
            List<Movie> movies = movieService.getAllMovies(new Movie());
            assertThat(movies).isNotNull().hasSize(1);
            verify(movieDao).getAllMovies(any(Movie.class));
        }

        // ... MovieService의 나머지 테스트들도 유사하게 작성 ...
    }
    
    @Nested
    @DisplayName("NoticeService 테스트")
    class NoticeServiceTests {
        @Test @DisplayName("공지 추가")
        void testAddNotice() {
            when(noticeDao.addNotice(any(Notice.class))).thenReturn(1);
            int result = noticeService.addNotice(new Notice());
            assertThat(result).isEqualTo(1);
            verify(noticeDao).addNotice(any(Notice.class));
        }

        // ... NoticeService의 나머지 테스트들도 유사하게 작성 ...
    }
    
    @Nested
    @DisplayName("ReportService 테스트")
    class ReportServiceTests {
        @Test @DisplayName("신고 추가")
        void testInsertReported() {
            when(reportDao.insertReported(any(ReportedReview.class))).thenReturn(1);
            int result = reportService.insertReported(new ReportedReview());
            assertThat(result).isEqualTo(1);
            verify(reportDao).insertReported(any(ReportedReview.class));
        }

        // ... ReportService의 나머지 테스트들도 유사하게 작성 ...
    }

    @Nested
    @DisplayName("ReviewService 테스트")
    class ReviewServiceTests {
        @Test @DisplayName("리뷰 추가")
        void testAddReview() {
            when(reviewDao.addReview(any(Review.class))).thenReturn(1);
            int result = reviewService.addReview(testReview);
            assertThat(result).isEqualTo(1);
            verify(reviewDao).addReview(testReview);
        }

        // ... ReviewService의 나머지 테스트들도 유사하게 작성 ...
    }
    
    @Nested
    @DisplayName("UserService 테스트")
    class UserServiceTests {
        @Test @DisplayName("회원 추가")
        void testAddUser() {
            when(userDao.addUser(any(User.class))).thenReturn(1);
            int result = userService.addUser(testUser);
            assertThat(result).isEqualTo(1);
            verify(userDao).addUser(testUser);
        }
        
        @Test @DisplayName("회원 조회")
        void testGetUser() {
            when(userDao.getUser(any(User.class))).thenReturn(testUser);
            User user = userService.getUser(new User());
            assertThat(user).isNotNull();
            assertThat(user.getId()).isEqualTo("testId");
            verify(userDao).getUser(any(User.class));
        }
        
        // ... UserService의 나머지 테스트들도 유사하게 작성 ...
    }
}