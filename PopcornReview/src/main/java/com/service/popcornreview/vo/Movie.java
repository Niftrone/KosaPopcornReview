package com.service.popcornreview.vo;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class Movie {
	// 영화 기본 정보
	private Integer mId; // 영화 아이디 m_id (Integer로 수정)
	private String mTitle; // 영화 제목 m_title
	private String mSubtitle; // 영화 부제 m_subtitle
	private Date mRelease; // 개봉일 m_release
	private String mShowtime; // 상영 시간 m_showtime
	
	// [추가] DB의 m_director 컬럼과 매핑하기 위한 필드입니다.
	private String mDirector; // 감독 m_director
	
	private String mPlot; // 줄거리 m_plot
	private String mScreeningType; // 상영타입 예) 2D, iMax m_screening_type
	private String mMovieTheater; // 영화관 예) 일반, 프리미엄 m_movie_theater
	private String mCategory; // 영화 종류 예) 로맨스, 판타지 m_category
	private String mUrlImage; // 영화 포스터 이미지 URL m_url_image
	private String mUrlMovie; // 영화 포스터 영상 URL m_url_movie
	private Double mAverageScore; // 평균 평점 (계산된 값)
	private String id; //관리자 아이디
	
	// [추가] DB의 m_added_date 컬럼과 매핑하기 위한 필드입니다. SELECT 시 setter가 필요합니다.
	private String mAddedDate;

	private List<Actor> actors; // 출연 배우 목록

	public Movie() {

	} 


	public Movie(Integer mId, String mTitle, String mSubtitle, Date mRelease, String mShowtime, String mDirector,
			String mPlot, String mScreeningType, String mMovieTheater, String mCategory, String mUrlImage,
			String mUrlMovie, Double mAverageScore, String id, String mAddedDate, List<Actor> actors) {
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
		this.mCategory = mCategory;
		this.mUrlImage = mUrlImage;
		this.mUrlMovie = mUrlMovie;
		this.mAverageScore = mAverageScore;
		this.id = id;
		this.mAddedDate = mAddedDate;
		this.actors = actors;
	}

    // [수정] Getter의 반환 타입을 Integer로 변경합니다.
	public Integer getmId() {
		return mId;
	}

    // [수정] Setter의 파라미터 타입을 Integer로 변경합니다.
	public void setmId(Integer mId) {
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

	public Date getmRelease() {
		return mRelease;
	}

	public void setmRelease(Date mRelease) {
		this.mRelease = mRelease;
	}

	public String getmShowtime() {
		return mShowtime;
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

	public String getmCategory() {
		return mCategory;
	}

	public void setmCategory(String mCategory) {
		this.mCategory = mCategory;
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

	public Double getmAverageScore() {
		return mAverageScore;
	}

	public void setmAverageScore(Double mAverageScore) {
		this.mAverageScore = mAverageScore;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getmAddedDate() {
		return mAddedDate;
	}

	public void setmAddedDate(String mAddedDate) {
		this.mAddedDate = mAddedDate;
	}

	public List<Actor> getActors() {
		return actors;
	}

	public void setActors(List<Actor> actors) {
		this.actors = actors;
	}
	
    public String getActorNames() {
        if (this.actors == null || this.actors.isEmpty()) {
            return ""; 
        }
        return this.actors.stream()
                         .map(Actor::getaName)
                         .collect(Collectors.joining(", "));
    }

	@Override
	public String toString() {
		return "Movie [mId=" + mId + ", mTitle=" + mTitle + ", mSubtitle=" + mSubtitle + ", mRelease=" + mRelease
				+ ", mShowtime=" + mShowtime + ", mDirector=" + mDirector + ", mPlot=" + mPlot + ", mScreeningType="
				+ mScreeningType + ", mMovieTheater=" + mMovieTheater + ", mCategory=" + mCategory + ", mUrlImage="
				+ mUrlImage + ", mUrlMovie=" + mUrlMovie + ", mAverageScore=" + mAverageScore + ", id=" + id
				+ ", mAddedDate=" + mAddedDate + ", actors=" + actors + "]";
	}
}