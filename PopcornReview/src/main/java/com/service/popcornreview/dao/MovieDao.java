package com.service.popcornreview.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.popcornreview.vo.Movie;

@Repository
public class MovieDao {

	public static final String NS = "ns.sql.MovieMapper.";

	@Autowired
	private SqlSession sqlSession;

	public Movie getMovie(String mId) {
		System.out.println("MovieDao...getMovie");
		return sqlSession.selectOne(NS + "getMovie", mId);
	}

	public List<Movie> getAllMovies(Movie movie) {
		System.out.println("MovieDao...getAllMovies");
		return sqlSession.selectList(NS + "getAllMovies", movie);
	}

	public List<Movie> getRecommendedMovies() {
		System.out.println("MovieDao...getRecommendedMovies");
		return sqlSession.selectList(NS + "getRecommendedMovies");
	}

	public List<Movie> getMoviesByCategory(String category) {
		System.out.println("MovieDao...getMoviesByCategory");
		return sqlSession.selectList(NS + "getMoviesByCategory", category);
	}

	public List<Movie> getMoviesByActor(String actorName) {
		System.out.println("MovieDao...getMoviesByActor");
		return sqlSession.selectList(NS + "getMoviesByActor", actorName);
	}

	public List<Movie> getUpcomingMovies() {
		System.out.println("MovieDao...getUpcomingMovies");
		return sqlSession.selectList(NS + "getUpcomingMovies");
	}

	public int addMovie(Movie movie) {
		System.out.println("MovieDao...addMovie");
		return sqlSession.insert(NS + "addMovie", movie);
	}

	public int updateMovie(Movie movie) {
		System.out.println("MovieDao...updateMovie");
		return sqlSession.update(NS + "updateMovie", movie);
	}

	public int deleteMovie(String mId) {
		System.out.println("MovieDao...deleteMovie");
		return sqlSession.delete(NS + "deleteMovie", mId);
	}
  
	// [추가] 영화-배우 관계 삭제 메서드
	public int deleteMovieActorRelations(String mId) {
	    System.out.println("MovieDao...deleteMovieActorRelations");
	    return sqlSession.delete(NS + "deleteMovieActorRelations", mId);
	}
	
	public List<Movie> searchMovies(String query) {
		return sqlSession.selectList(NS+"searchMovies",query);

	}
}