package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.MovieDao;
import com.service.popcornreview.vo.Movie;

@Service
public class MovieService {

	@Autowired
	private MovieDao movieDaoImpl;

	public Movie getMovie(String mId) {
		System.out.println("MovieService...getMovie");
		return movieDaoImpl.getMovie(mId);
	}

	public List<Movie> getAllMovies(Movie movie) {
		System.out.println("MovieService...getAllMovies");
		return movieDaoImpl.getAllMovies(movie);
	}

	public List<Movie> getRecommendedMovies() {
		System.out.println("MovieService...getRecommendedMovies");
		return movieDaoImpl.getRecommendedMovies();
	}

	public List<Movie> getMoviesByCategory(String category) {
		System.out.println("MovieService...getMoviesByCategory");
		return movieDaoImpl.getMoviesByCategory(category);
	}

	public List<Movie> getMoviesByActor(String actorName) {
		System.out.println("MovieService...getMoviesByActor");
		return movieDaoImpl.getMoviesByActor(actorName);
	}

	public List<Movie> getUpcomingMovies() {
		System.out.println("MovieService...getUpcomingMovies");
		return movieDaoImpl.getUpcomingMovies();
	}

	public int addMovie(Movie movie) {
		System.out.println("MovieService...addMovie");
		return movieDaoImpl.addMovie(movie);
	}

	public int updateMovie(Movie movie) {
		System.out.println("MovieService...updateMovie");
		return movieDaoImpl.updateMovie(movie);
	}

	public int deleteMovie(String mId) {
		System.out.println("MovieService...deleteMovie");
		return movieDaoImpl.deleteMovie(mId);
	}
}
