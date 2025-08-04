package com.service.popcornreview.vo;

import java.util.List;

public class Movie {
	// 영화 기본 정보
	private String mId; // 영화 아이디 m_id
	private String mTitle; // 영화 제목 m_title
	private String mSubtitle; // 영화 부제 m_subtitle
	private String mRelease; // 개봉일 m_release
	private String mShowtime; // 상영 시간 m_showtime
	private String mDirector; // 감독 m_director
	private String mPlot; // 줄거리 m_plot
	private String mScreeningType; // 상영타입 예) 2D, iMax m_screening_type
	private String mMovieTheater; // 영화관 예) 일반, 프리미엄 m_movie_theater
	private String mCategories; // 영화 종류 예) 로맨스, 판타지 m_category
	private String mUrlImage; // 영화 포스터 이미지 URL m_url_image
	private String mUrlMovie; // 영화 포스터 영상 URL m_url_movie
	private Double mAvarageScore; // 평균 평점 (계산된 값)

	private List<Actor> actors; // 출연 배우 목록

	public Movie() {

	}

	public Movie(String mId, String mTitle, String mSubtitle, String mRelease, String mShowtime, String mDirector,
			String mPlot, String mScreeningType, String mMovieTheater, String mCategories, String mUrlImage,
			String mUrlMovie, Double mAvarageScore, List<Actor> actors) {
		super();
		this.mId = mId;
		this.mTitle = mTitle;
		this.mSubtitle = mSubtitle;
		this.mRelease = mRelease;
		this.mShowtime = mShowtime;
		this.mDirector = mDirector;
		this.mPlot = mPlot;
		this.mScreeningType = mScreeningType;
		this.mMovieTheater = mMovieTheater;
		this.mCategories = mCategories;
		this.mUrlImage = mUrlImage;
		this.mUrlMovie = mUrlMovie;
		this.mAvarageScore = mAvarageScore;
		this.actors = actors;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getmTitle() {
		return mTitle;
	}

	public void setmTitle(String mTitle) {
		this.mTitle = mTitle;
	}

	public String getmSubtitle() {
		return mSubtitle;
	}

	public void setmSubtitle(String mSubtitle) {
		this.mSubtitle = mSubtitle;
	}

	public String getmRelease() {
		return mRelease;
	}

	public void setmRelease(String mRelease) {
		this.mRelease = mRelease;
	}

	public String getmShowtime() {
		return mShowtime;
	}

	public void setmAvarageScore() {
		this.mAvarageScore = mAvarageScore;

	}

	public Double getmAvarageScore() {
		return mAvarageScore;

	}

	public void setmShowtime(String mShowtime) {
		this.mShowtime = mShowtime;
	}

	public String getmDirector() {
		return mDirector;
	}

	public void setmDirector(String mDirector) {
		this.mDirector = mDirector;
	}

	public String getmPlot() {
		return mPlot;
	}

	public void setmPlot(String mPlot) {
		this.mPlot = mPlot;
	}

	public String getmScreeningType() {
		return mScreeningType;
	}

	public void setmScreeningType(String mScreeningType) {
		this.mScreeningType = mScreeningType;
	}

	public String getmMovieTheater() {
		return mMovieTheater;
	}

	public void setmMovieTheater(String mMovieTheater) {
		this.mMovieTheater = mMovieTheater;
	}

	public String getmCategories() {
		return mCategories;
	}

	public void setmCategories(String mCategories) {
		this.mCategories = mCategories;
	}

	public String getmUrlImage() {
		return mUrlImage;
	}

	public void setmUrlImage(String mUrlImage) {
		this.mUrlImage = mUrlImage;
	}

	public String getmUrlMovie() {
		return mUrlMovie;
	}

	public void setmUrlMovie(String mUrlMovie) {
		this.mUrlMovie = mUrlMovie;
	}

	public List<Actor> getActors() {
		return actors;
	}

	public void setActors(List<Actor> actors) {
		this.actors = actors;
	}

	@Override
	public String toString() {
		return "Movie [mId=" + mId + ", mTitle=" + mTitle + ", mSubtitle=" + mSubtitle + ", mRelease=" + mRelease
				+ ", mShowtime=" + mShowtime + ", mDirector=" + mDirector + ", mPlot=" + mPlot + ", mScreeningType="
				+ mScreeningType + ", mMovieTheater=" + mMovieTheater + ", mCategories=" + mCategories + ", mUrlImage="
				+ mUrlImage + ", mUrlMovie=" + mUrlMovie + ", actors=" + actors + "]";
	}

}
