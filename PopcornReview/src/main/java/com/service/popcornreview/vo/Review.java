package com.service.popcornreview.vo;

public class Review {
	private int rId; // 리뷰 아이디 r_id
	private int rRating; // 평점 r_rating
	private String rPlot; // 리뷰 내용 r_plot
	private String rDate; // 작성일 r_date

	private User user; // 리뷰를 작성한 사용자 정보
	private Movie movie; // 리뷰가 달린 영화 정보

	public Review() {

	}

	public Review(int rId, int rRating, String rPlot, String rDate, User user, Movie movie) {
		super();
		this.rId = rId;
		this.rRating = rRating;
		this.rPlot = rPlot;
		this.rDate = rDate;
		this.user = user;
		this.movie = movie;
	}

	public int getrId() {
		return rId;
	}

	public void setrId(int rId) {
		this.rId = rId;
	}

	public int getrRating() {
		return rRating;
	}

	public void setrRating(int rRating) {
		this.rRating = rRating;
	}

	public String getrPlot() {
		return rPlot;
	}

	public void setrPlot(String rPlot) {
		this.rPlot = rPlot;
	}

	public String getrDate() {
		return rDate;
	}

	public void setrDate(String rDate) {
		this.rDate = rDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Movie getMovie() {
		return movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	@Override
	public String toString() {
		return "Review [rId=" + rId + ", rRating=" + rRating + ", rPlot=" + rPlot + ", rDate=" + rDate + ", user="
				+ user + ", movie=" + movie + "]";
	}

}
