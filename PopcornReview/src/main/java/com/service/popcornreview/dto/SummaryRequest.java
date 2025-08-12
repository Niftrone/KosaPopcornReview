package com.service.popcornreview.dto;

import com.service.popcornreview.vo.Movie;
import java.util.List;

// import lombok.Getter; // Lombok import 구문 삭제

/**
 * 요약을 요청할 때 보낼 DTO (Lombok 없이 직접 작성)
 */
public class SummaryRequest {

    private final List<String> reviewTexts;
    private final MovieInfo movieInfo;

    // 생성자에서 Movie 객체와 리뷰 텍스트를 받아 DTO를 만듭니다.
    public SummaryRequest(Movie movie, List<String> reviewTexts) {
        this.reviewTexts = reviewTexts;
        this.movieInfo = new MovieInfo(movie);
    }

    // --- Getter 메소드 직접 작성 ---
    public List<String> getReviewTexts() {
        return this.reviewTexts;
    }

    public MovieInfo getMovieInfo() {
        return this.movieInfo;
    }
    // --- Getter 메소드 끝 ---

    // 디버깅을 위한 toString() 메소드 추가
    @Override
    public String toString() {
        return "SummaryRequest{" +
               "reviewTexts=" + reviewTexts +
               ", movieInfo=" + movieInfo +
               '}';
    }

    /**
     * 요청에 포함될 영화의 핵심 정보만 담는 내부 클래스
     */
    private static class MovieInfo {
        private final String title;
        private final String plot;
        private final String genre;

        // Movie VO 객체에서 필요한 정보만 뽑아서 초기화합니다.
        public MovieInfo(Movie movie) {
            this.title = movie.getmTitle();
            this.plot = movie.getmPlot();
            this.genre = movie.getmCategory();
        }

        // --- Getter 메소드 직접 작성 ---
        public String getTitle() {
            return this.title;
        }

        public String getPlot() {
            return this.plot;
        }

        public String getGenre() {
            return this.genre;
        }
        // --- Getter 메소드 끝 ---
        
        // 디버깅을 위한 toString() 메소드 추가
        @Override
        public String toString() {
            return "MovieInfo{" +
                   "title='" + title + '\'' +
                   ", plot='" + plot + '\'' +
                   ", genre='" + genre + '\'' +
                   '}';
        }
    }
}