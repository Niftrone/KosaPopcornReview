package com.service.popcornreview.service;
import java.util.UUID;

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
	
	public List<Movie> getBannerList(Movie movie){
		System.out.println("MovieService...getAllMovies");
		return movieDao.getAllMovies(movie).stream().limit(5).toList();
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
	    // 1. 전달받은 movie 객체의 ID가 비어있는지 확인합니다. (새로 등록하는 경우)
	    if (movie.getmId() == null || movie.getmId().isBlank()) {
	        // 2. 비어있다면, 중복되지 않는 고유 ID (UUID)를 생성하여 설정합니다.
	        String newId = UUID.randomUUID().toString();
	        movie.setmId(newId);
	        System.out.println("신규 영화 ID 생성: " + newId); // ID 생성 확인용 로그
	    }

	    // 3. ID가 보장된 movie 객체를 DAO로 전달하여 DB에 저장합니다.
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
