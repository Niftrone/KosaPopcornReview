package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.ActorDao;
import com.service.popcornreview.dao.CommentDao;
import com.service.popcornreview.dao.MovieDao;
import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Movie;

@Service
public class CommentService {

	@Autowired
    private MovieDao movieDaoImpl;

    public Movie getMovie(String mId) {
        return movieDaoImpl.getMovie(mId);
    }

    public List<Movie> getAllMovies(Movie movie) {
        return movieDaoImpl.getAllMovies(movie);
    }

    public List<Movie> getRecommendedMovies() {
        return movieDaoImpl.getRecommendedMovies();
    }

    public List<Movie> getMoviesByCategory(String category) {
        return movieDaoImpl.getMoviesByCategory(category);
    }

    public List<Movie> getMoviesByActor(String actorName) {
        return movieDaoImpl.getMoviesByActor(actorName);
    }

    public List<Movie> getUpcomingMovies() {
        return movieDaoImpl.getUpcomingMovies();
    }

    public int addMovie(Movie movie) {
        return movieDaoImpl.addMovie(movie);
    }

    public int updateMovie(Movie movie) {
        return movieDaoImpl.updateMovie(movie);
    }

    public int deleteMovie(String mId) {
        return movieDaoImpl.deleteMovie(mId);
    }
}
