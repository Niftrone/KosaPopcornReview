<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.service.popcornreview.vo.*, java.text.SimpleDateFormat" %>
<%
    // 1. 테스트용 가짜 Movie 객체를 만듭니다.
    Movie movie = new Movie();
    movie.setmId("m12345");
    movie.setmTitle("피스메이커 (테스트 버전)");
    movie.setmSubtitle("TV Series 2022-TV-MA 40m");
    
    // ★★★ 영화 포스터 이미지 파일 이름을 'movie_poster02.jpg'로 변경 ★★★
    movie.setmUrlImage("movie_poster02.jpg"); 
    
    movie.setmUrlMovie("movie.mp4"); // 예고편 동영상
    movie.setmPlot("고도로 훈련된 킬러이자 히어로. 세계 평화를 위해서라면 살인, 방화, 납치, 그 어떤 것도 서슴지 않는 '피스메이커'의 이야기. 그가 임무를 수행하며 겪는 유쾌하고 폭력적인 모험을 그린다.");
    movie.setmDirector("제임스 건");
    movie.setmRelease("2025-08-05"); // VO에 따라 String 타입으로 설정
    movie.setmShowtime("45");       // VO에 따라 String 타입으로 설정
    movie.setmAverageScore(7.8);
	movie.setmCategory("서사, 드라마, 코미디");
    // 2. 테스트용 가짜 배우(Actor) 리스트를 만듭니다.
    List<Actor> actors = new ArrayList<>();
    
    Actor actor1 = new Actor();
    actor1.setaName("존 시나");
    // ★★★ 배우 이미지 파일 이름을 'actor02.jpg'로 변경 ★★★
    actor1.setaUrlImage("actor02.jpg");
    actors.add(actor1);

    Actor actor2 = new Actor();
    actor2.setaName("다니엘 브룩스");
    // ★★★ 배우 이미지 파일 이름을 'actor03.jpg'로 변경 ★★★
    actor2.setaUrlImage("actor03.jpg");
    actors.add(actor2);
    
    Actor actor3 = new Actor();
    actor3.setaName("프레디 스트로마");
    // ★★★ 배우 이미지 파일 이름을 'actor04.jpg'로 변경 ★★★
    actor3.setaUrlImage("actor04.jpg");
    actors.add(actor3);

    movie.setActors(actors); // 영화 객체에 배우 리스트를 설정합니다.

    // 3. 테스트용 가짜 리뷰(Review) 리스트를 만듭니다.
    List<Review> reviews = new ArrayList<>();
    Review review1 = new Review();
    review1.setrId(101);
    review1.setrRating(5);
    review1.setrPlot("정말 최고입니다! 시즌2 기대돼요.");
    review1.setrDate("2025-08-04");
    User user1 = new User();
    user1.setId("testuser1");
    review1.setUser(user1);
    reviews.add(review1);
    
    Review review2 = new Review();
    review2.setrId(102);
    review2.setrRating(4);
    review2.setrPlot("B급 감성이 너무 좋아요. 시간 가는 줄 모르고 봤습니다.");
    review2.setrDate("2025-08-02");
    User user2 = new User();
    user2.setId("happy_user");
    review2.setUser(user2);
    reviews.add(review2);

    // 4. request 객체에 가짜 데이터를 'movie'와 'reviews'라는 이름으로 담습니다.
    request.setAttribute("movie", movie);
    request.setAttribute("reviews", reviews);
%>

<jsp:forward page="/WEB-INF/views/moviedetail.jsp" />