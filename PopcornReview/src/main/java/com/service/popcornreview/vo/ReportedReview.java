package com.service.popcornreview.vo;

public class ReportedReview {
    // 멤버 변수 (테이블의 컬럼)
    private int rrId;      // 신고 ID (Primary Key) rr_id
    private String rrPlot; // 신고 내용 rr_plot
    private String rrDate;
    
    public ReportedReview(int rrId, String rrPlot, String rrDate, Review review, User user) {
		super();
		this.rrId = rrId;
		this.rrPlot = rrPlot;
		this.rrDate = rrDate;
		this.review = review;
		this.user = user;
	}

	public String getRrDate() {
		return rrDate;
	}

	public void setRrDate(String rrDate) {
		this.rrDate = rrDate;
	}

	//연관객체 정보
    private Review review;
    private User user;
    
    public ReportedReview() {
    	
    }
    
	public ReportedReview(int rrId, String rrPlot, Review review, User user) {
		super();
		this.rrId = rrId;
		this.rrPlot = rrPlot;
		this.review = review;
		this.user = user;
	}
	
	public ReportedReview(String rrPlot, Review review, User user) {
		
		this.rrPlot = rrPlot;
		this.review = review;
		this.user = user;
	}

	public int getRrId() {
		return rrId;
	}

	public void setRrId(int rrId) {
		this.rrId = rrId;
	}

	public String getRrPlot() {
		return rrPlot;
	}

	public void setRrPlot(String rrPlot) {
		this.rrPlot = rrPlot;
	}

	public Review getReview() {
		return review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "ReportedReview [rrId=" + rrId + ", rrPlot=" + rrPlot + ", rrDate=" + rrDate + ", review=" + review
				+ ", user=" + user + "]";
	}
    
}
