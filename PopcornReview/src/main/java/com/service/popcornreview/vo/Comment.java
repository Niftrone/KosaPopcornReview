package com.service.popcornreview.vo;

public class Comment {
	private int cId; // 댓글 아이디 c_id
	private String cPlot; // 댓글 내용 c_plot
	private String cDate; // 작성일 c_date

	// 연관 객체 정보
	private User user; // 댓글을 작성한 사용자 정보
	private Review review; // 댓글이 달린 리뷰 정보

	public Comment() {

	}

	public Comment(int cId, String cPlot, String cDate, User user, Review review) {
		super();
		this.cId = cId;
		this.cPlot = cPlot;
		this.cDate = cDate;
		this.user = user;
		this.review = review;
	}

	public int getcId() {
		return cId;
	}

	public void setcId(int cId) {
		this.cId = cId;
	}

	public String getcPlot() {
		return cPlot;
	}

	public void setcPlot(String cPlot) {
		this.cPlot = cPlot;
	}

	public String getcDate() {
		return cDate;
	}

	public void setcDate(String cDate) {
		this.cDate = cDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Review getReview() {
		return review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

	@Override
	public String toString() {
		return "Comment [cId=" + cId + ", cPlot=" + cPlot + ", cDate=" + cDate + ", user=" + user + ", review=" + review
				+ "]";
	}

}