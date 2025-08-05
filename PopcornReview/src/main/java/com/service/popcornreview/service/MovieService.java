              package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.MovieDao;
import com.service.popcornreview.vo.Movie;

@Service
public class MovieService {

	@Autowired
	private MovieDao movieDao;

	public Movie getMovie(String mId) {
		System.out.println("MovieService...getMovie");
		return movieDao.getMovie(mId);
	}

	public List<Movie> getAllMovies(Movie movie) {
		System.out.println("MovieService...getAllMovies");
		return movieDao.getAllMovies(movie);
	}

	public List<Movie> getRecommendedMovies() {
		System.out.println("MovieService...getRecommendedMovies");
		return movieDao.getRecommendedMovies();
	}

	public List<Movie> getMoviesByCategory(String category) {
		System.out.println("MovieService...getMoviesByCategory");
		return movieDao.getMoviesByCategory(category);
	}

	public List<Movie> getMoviesByActor(String actorName) {
		System.out.println("MovieService...getMoviesByActor");
		return movieDao.getMoviesByActor(actorName);
	}

	public List<Movie> getUpcomingMovies() {
		System.out.println("MovieService...getUpcomingMovies");
		return movieDao.getUpcomingMovies();
	}

	public int addMovie(Movie movie) {
		System.out.println("MovieService...addMovie");
		return movieDao.addMovie(movie);
	}

	public int updateMovie(Movie movie) {
		System.out.println("MovieService...updateMovie");
		return movieDao.updateMovie(movie);
	}

	public int deleteMovie(String mId) {
		System.out.println("MovieService...deleteMovie");
		return movieDao.deleteMovie(mId);
	}
}
