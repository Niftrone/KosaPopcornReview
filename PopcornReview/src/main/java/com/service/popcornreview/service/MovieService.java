package com.service.popcornreview.service;
import java.util.UUID;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.service.popcornreview.dao.MovieDao;
import com.service.popcornreview.dto.AudienceStatsDto;
import com.service.popcornreview.dto.ReviewStatsDto;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;

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

	 @Transactional
	    public int deleteMovie(String mId) {
	        System.out.println("MovieService...deleteMovie (and relations)");
	        
	        // 1. 자식 테이블(mov_act) 데이터 먼저 삭제
	        movieDao.deleteMovieActorRelations(mId);
	        
	        // 2. 부모 테이블(movie) 데이터 삭제
	        return movieDao.deleteMovie(mId);
	    }
	
	
	// --- MovieService 클래스 내부에 아래 메서드를 추가 ---

	/**
	 * 전달받은 리뷰 목록을 기반으로 관람객 통계를 계산하는 서비스 메서드
	 * @param reviews 통계를 계산할 리뷰 데이터 목록
	 * @return AudienceStatsDto 통계 결과가 담긴 DTO
	 */
	public AudienceStatsDto getAudienceStats(List<Review> reviews) {
	    
	    if (reviews == null || reviews.isEmpty()) {
	        return new AudienceStatsDto(); 
	    }

	    int totalCount = reviews.size();
	    
	    int maleCount = 0;
	    Map<String, Integer> ageGroupCounts = new HashMap<>();
	    ageGroupCounts.put("10대", 0);
	    ageGroupCounts.put("20대", 0);
	    ageGroupCounts.put("30대", 0);
	    ageGroupCounts.put("40대", 0);
	    ageGroupCounts.put("50대 이상", 0);

	    for (Review review : reviews) {
	        User user = review.getUser();
	        if (user == null) {
	            continue;
	        }

	        // ★ 1. user.isGender()가 true이면 남성으로 간주하여 카운트합니다.
	        if (user.isGender()) {
	            maleCount++;
	        }

	        // ★ 2. String 타입의 생년월일을 LocalDate로 변환하여 나이를 계산합니다.
	        String birthdateStr = user.getBirthdate();
	        if (birthdateStr != null && !birthdateStr.isEmpty()) {
	            try {
	                LocalDate birthDate = LocalDate.parse(birthdateStr); // "YYYY-MM-DD" 형식 가정
	                int age = Period.between(birthDate, LocalDate.now()).getYears();
	                
	                if (age >= 10 && age < 20) {
	                    ageGroupCounts.merge("10대", 1, Integer::sum);
	                } else if (age >= 20 && age < 30) {
	                    ageGroupCounts.merge("20대", 1, Integer::sum);
	                } else if (age >= 30 && age < 40) {
	                    ageGroupCounts.merge("30대", 1, Integer::sum);
	                } else if (age >= 40 && age < 50) {
	                    ageGroupCounts.merge("40대", 1, Integer::sum);
	                } else if (age >= 50) {
	                    ageGroupCounts.merge("50대 이상", 1, Integer::sum);
	                }
	            } catch (DateTimeParseException e) {
	                // 날짜 형식이 잘못된 경우, 로그를 남기거나 조용히 무시할 수 있습니다.
	                System.err.println("잘못된 날짜 형식입니다: " + birthdateStr);
	            }
	        }
	    }

	    // 비율 계산 및 DTO 반환 로직은 이전과 동일합니다.
	    Map<String, Double> genderStats = new LinkedHashMap<>();
	    double malePercent = ((double) maleCount / totalCount) * 100;
	    genderStats.put("남성", malePercent);
	    genderStats.put("여성", 100.0 - malePercent);

	    Map<String, Double> ageStats = new LinkedHashMap<>();
	    ageStats.put("10대", ((double) ageGroupCounts.get("10대") / totalCount) * 100);
	    ageStats.put("20대", ((double) ageGroupCounts.get("20대") / totalCount) * 100);
	    ageStats.put("30대", ((double) ageGroupCounts.get("30대") / totalCount) * 100);
	    ageStats.put("40대", ((double) ageGroupCounts.get("40대") / totalCount) * 100);
	    ageStats.put("50대 이상", ((double) ageGroupCounts.get("50대 이상") / totalCount) * 100);

	    AudienceStatsDto statsDto = new AudienceStatsDto();
	    statsDto.setGenderDistribution(genderStats);
	    statsDto.setAgeDistribution(ageStats);

	    return statsDto;
	}
	
	/**
	 * 전달받은 리뷰 목록으로 평균 평점과 점수 분포도를 계산하는 메서드
	 * @param reviews 통계를 계산할 리뷰 데이터 목록
	 * @return ReviewStatsDto 리뷰 통계 결과가 담긴 DTO
	 */
	public ReviewStatsDto getReviewStats(List<Review> reviews) {
	    if (reviews == null || reviews.isEmpty()) {
	        return new ReviewStatsDto(); 
	    }

	    int totalCount = reviews.size();
	    
	    double totalScoreSum = 0;
	    Map<Integer, Integer> scoreCounts = new HashMap<>();
	    for (int i = 1; i <= 5; i++) {
	        scoreCounts.put(i, 0); 
	    }

	    for (Review review : reviews) {
	        // ★ review.getScore()를 실제 VO에 맞는 review.getrRating()으로 수정
	        int score = review.getrRating(); 
	        totalScoreSum += score;
	        scoreCounts.merge(score, 1, Integer::sum);
	    }

	    // 평균 평점 계산 (10점 만점으로 변환)
	    double averageScore = (totalScoreSum / totalCount) * 2;

	    // 점수별 분포도(%) 계산
	    Map<Integer, Double> scoreDistribution = new LinkedHashMap<>();
	    for (int i = 5; i >= 1; i--) { 
	        double percentage = ((double) scoreCounts.get(i) / totalCount) * 100;
	        scoreDistribution.put(i, percentage);
	    }
	    
	    // 최종 결과를 DTO에 담아 반환
	    ReviewStatsDto statsDto = new ReviewStatsDto();
	    statsDto.setAverageScore(Double.parseDouble(String.format("%.1f", averageScore)));
	    statsDto.setScoreDistribution(scoreDistribution);

	    return statsDto;
	}
}
