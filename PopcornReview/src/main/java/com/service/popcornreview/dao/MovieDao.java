package com.service.popcornreview.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Movie;
@Repository
public class MovieDao {
	
	public static final String NS = "ns.sql.MovieMapper.";

    @Autowired
    private SqlSession sqlSession;

 
    public Movie getMovie(String mId) {
        return sqlSession.selectOne(NS + "getMovie", mId);
    }

   
    public List<Movie> getAllMovies(Movie movie) {
        return sqlSession.selectList(NS + "getAllMovies", movie);
    }

   
    public List<Movie> getRecommendedMovies() {
        return sqlSession.selectList(NS + "getRecommendedMovies");
    }

   
    public List<Movie> getMoviesByCategory(String category) {
        return sqlSession.selectList(NS + "getMoviesByCategory", category);
    }

  
    public List<Movie> getMoviesByActor(String actorName) {
        return sqlSession.selectList(NS + "getMoviesByActor", actorName);
    }

    
    public List<Movie> getUpcomingMovies() {
        return sqlSession.selectList(NS + "getUpcomingMovies");
    }

    public int addMovie(Movie movie) {
        return sqlSession.insert(NS + "addMovie", movie);
    }

    
    public int updateMovie(Movie movie) {
        return sqlSession.update(NS + "updateMovie", movie);
    }

   
    public int deleteMovie(String mId) {
        return sqlSession.delete(NS + "deleteMovie", mId);
    }
}