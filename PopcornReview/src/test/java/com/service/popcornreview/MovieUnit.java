package com.service.popcornreview;

import com.service.popcornreview.vo.Movie; // Movie 도메인 클래스 경로
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

public class MovieUnit {

    @Test
    public void getMovieTest() throws IOException {
        // 특정 영화 조회
        Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
        SqlSession session = factory.openSession();

        Movie movie = session.selectOne("ns.sql.MovieMapper.getMovie", "m11"); // m01은 DB에 존재하는 ID여야 함
        System.out.println("조회된 영화: " + movie);
        session.close();
    }

    @Test
    public void getAllMoviesTest() throws IOException {
        // 전체 영화 목록 조회
        Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
        SqlSession session = factory.openSession();
       
        List<Movie> list = session.selectList("ns.sql.MovieMapper.getAllMovies");
        System.out.println("--- 전체 영화 목록 ---");
        for (Movie m : list) {
            System.out.println(m.getmTitle());
        }
        session.close();
    }

    @Test
    public void addMovieTest() throws IOException {
        // 영화 등록
        Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
        SqlSession session = factory.openSession();

        // DB에 추가할 Movie 객체 생성 및 데이터 설정
        Movie movie = new Movie();
        movie.setmId("test01"); // 고유한 ID로 설정
        movie.setmTitle("테스트로 추가한 영화");
        movie.setmSubtitle("테스트 부제");
        movie.setmRelease("2025-12-25"); // 날짜 형식
        movie.setmShowtime("120"); // [수정] VO 필드 타입에 맞게 String으로 변경
        movie.setmPlot("이것은 테스트를 위한 영화 줄거리입니다.");
        movie.setmCategories("액션");
        movie.setmScreeningType("2D");
        movie.setmMovieTheater("일반관");
        movie.setmUrlImage("http://example.com/image.jpg");
        movie.setmUrlMovie("http://example.com/trailer.mp4");
        // movie.setId("admin"); // Movie VO에 id 필드가 있는 경우 사용
        
        // DB에 insert 실행
        int result = session.insert("ns.sql.MovieMapper.addMovie", movie);
        session.commit(); // commit 필수
        
        System.out.println("추가 결과 (1이면 성공): " + result);
        session.close();
    }
    
    @Test
    public void updateMovieTest() throws IOException {
        // 영화 수정
        Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
        SqlSession session = factory.openSession();

        Movie movie = new Movie();
        movie.setmId("m01"); // 수정할 영화의 ID
        movie.setmTitle("열이의 마음은 뜨거웠다");
        movie.setmPlot("줄거리가 수정되었습니다.");
        movie.setmCategories("드라마");

        int result = session.update("ns.sql.MovieMapper.updateMovie", movie);
        session.commit();
        System.out.println("수정 결과 (1이면 성공): " + result);
        session.close();
    }

    @Test
    public void deleteMovieTest() throws IOException {
        // 영화 삭제
        Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
        SqlSession session = factory.openSession();

        int result = session.delete("ns.sql.MovieMapper.deleteMovie", "test01"); // 삭제할 영화의 ID
        session.commit();
        System.out.println("삭제 결과 (1이면 성공): " + result);
        session.close();
    }
}