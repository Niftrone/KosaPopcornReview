package com.service.popcornreview.service;
import java.util.UUID;
import java.util.stream.Collectors;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.service.popcornreview.dao.MovieDao;
import com.service.popcornreview.dto.AudienceStatsDto;
import com.service.popcornreview.dto.ReviewStatsDto;
import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;

@Service
public class MovieService {

	@Autowired
	private MovieDao movieDao;

	public Movie getMovie(int mId) {
		System.out.println("MovieService...getMovie");
		Movie movie = movieDao.getMovie(mId);
		for(Actor a : movie.getActors()) {	
			String code = a.getaId(); 
		    if (code.endsWith("2")) {
		    	
		    	movie.setmDirector(a.getaName());
		    	break;
		    }
		}
		return movie;
	}
	
	public List<Movie> getBannerList(Movie movie){
		System.out.println("MovieService...getAllMovies");
		return movieDao.getAllMovies(movie).stream().limit(5).toList();
	}

	public List<Movie> getAllMovies(Movie movie) {
		System.out.println("MovieService...getAllMovies");
		List<Movie> movies =  movieDao.getAllMovies(movie);
		
	    Date today = java.sql.Date.valueOf(
	            java.time.LocalDate.now(java.time.ZoneId.of("Asia/Seoul"))
	        );
	    
	    movies.removeIf(m -> {
	        Date release = m.getmRelease();
	        return release == null || release.after(today);
	    });
	    
		return movies;
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
		List<Movie> list = movieDao.getUpcomingMovies();
		return list.isEmpty() ? null : list;
	}



	  @Transactional
	    public int addMovie(Movie movie) {
	        System.out.println("MovieService...addMovie");

	        // 1) 영화 저장
	        int result = movieDao.addMovie(movie);

	        // 2) 출연 배우 관계 저장 (mId:int + aId:String → Map<String,Object>로 전달)
	        List<Actor> actors = movie.getActors();
	        if (actors != null && !actors.isEmpty()) {
	            for (Actor actor : actors) {
	                if (actor != null && actor.getaId() != null && !actor.getaId().isBlank()) {
	                    Map<String, Object> params = new HashMap<>();
	                    params.put("mId", movie.getmId());   // int
	                    params.put("aId", actor.getaId());   // String
	                    movieDao.addMovieActorRelation(params); // mapper는 parameterType="map" 권장
	                }
	            }
	        }
	        return result;
	    }


	  @Transactional // 모든 작업이 성공하거나 실패하도록 보장하는 안전장치
	    public int updateMovie(Movie movie) {
	        System.out.println("MovieService...updateMovie");
	        
	        // 1. 영화 기본 정보 업데이트
	        int result = movieDao.updateMovie(movie);
	        
	        // 2. 기존 영화-배우 관계를 모두 삭제
	        //    (mId는 업데이트할 movie 객체에서 가져옵니다)
	        movieDao.deleteMovieActorRelations(movie.getmId());
	        
	     // 3. 새로운 배우 목록이 있다면
	        if (movie.getActors() != null && !movie.getActors().isEmpty()) {
	            
	            // --- 이 부분이 추가된 방어 코드입니다 ---
	            // 루프를 실행하기 전에, stream을 사용하여 리스트에서 null인 항목들을 모두 걸러냅니다.
	            List<Actor> validActors = movie.getActors().stream()
	                                         .filter(Objects::nonNull) // actor가 null이 아닌 것만 통과시킴
	                                         .collect(Collectors.toList());
	            
	            // 이제 null이 없는 '깨끗한' validActors 리스트를 가지고 루프를 실행합니다.
	            for (Actor actor : validActors) {
	                Map<String, Object> params = new HashMap<>();
	                params.put("mId", movie.getmId());
	                // 이제 actor는 절대 null일 수 없으므로 에러가 발생하지 않습니다.
	                params.put("aId", actor.getaId());
	                movieDao.addMovieActorRelation(params);
	            }
	        }
	        
	        return result;
	    }

	 @Transactional
	    public int deleteMovie(int mId) {
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
	// MovieService.java의 getAudienceStats 메서드를 아래 코드로 교체하세요.

	public AudienceStatsDto getAudienceStats(List<Review> reviews) {
	    if (reviews == null || reviews.isEmpty()) {
	        return new AudienceStatsDto(); 
	    }

	    // 리뷰를 남긴 유저가 중복될 수 있으므로, 고유한 유저 ID를 기준으로 통계를 내는 것이 더 정확합니다.
	    // 여기서는 기존 로직을 최대한 유지하여 수정합니다.
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

	        // 1. 성별 카운트 (기존 로직 유지)
	        if (user.isGender()) {
	            maleCount++;
	        }

	        // ✅ 2. 나이 계산 로직 수정
	        LocalDate birthDate = user.getBirthdate(); // 이제 바로 LocalDate 객체를 가져옵니다.
	        if (birthDate != null) { // null 체크만 하면 됩니다.
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
	        }
	    }

	    // 비율 계산 및 DTO 반환 로직은 기존과 동일
	    Map<String, Double> genderStats = new LinkedHashMap<>();
	    if (totalCount > 0) {
	        double malePercent = ((double) maleCount / totalCount) * 100;
	        genderStats.put("남성", malePercent);
	        genderStats.put("여성", 100.0 - malePercent);
	    } else {
	        genderStats.put("남성", 0.0);
	        genderStats.put("여성", 0.0);
	    }

	    Map<String, Double> ageStats = new LinkedHashMap<>();
	    if (totalCount > 0) {
	        ageStats.put("10대", ((double) ageGroupCounts.get("10대") / totalCount) * 100);
	        ageStats.put("20대", ((double) ageGroupCounts.get("20대") / totalCount) * 100);
	        ageStats.put("30대", ((double) ageGroupCounts.get("30대") / totalCount) * 100);
	        ageStats.put("40대", ((double) ageGroupCounts.get("40대") / totalCount) * 100);
	        ageStats.put("50대 이상", ((double) ageGroupCounts.get("50대 이상") / totalCount) * 100);
	    } else {
	        ageStats.put("10대", 0.0);
	        ageStats.put("20대", 0.0);
	        ageStats.put("30대", 0.0);
	        ageStats.put("40대", 0.0);
	        ageStats.put("50대 이상", 0.0);
	    }
	    
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
	    double averageScore = (totalScoreSum / totalCount);

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
	
	public List<Movie> searchMovies(String query) {
		return movieDao.searchMovies(query);
	}
}
