package com.service.popcornreview.vo;

class Notice {
	private int noticeId; // 공지사항 아이디 notice_id
	private String noticeTitle; // 공지사항 제목 notice_title
	private String noticePlot; // 공지사항 내용 notice_plot
	private String noticeDate; // 작성일 notice_date

	// 연관 객체 정보
	private User user; // 공지사항을 작성한 사용자(관리자) 정보

	public Notice() {

	}

	public Notice(int noticeId, String noticeTitle, String noticePlot, String noticeDate, User user) {
		super();
		this.noticeId = noticeId;
		this.noticeTitle = noticeTitle;
		this.noticePlot = noticePlot;
		this.noticeDate = noticeDate;
		this.user = user;
	}

	public int getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticePlot() {
		return noticePlot;
	}

	public void setNoticePlot(String noticePlot) {
		this.noticePlot = noticePlot;
	}

	public String getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Notice [noticeId=" + noticeId + ", noticeTitle=" + noticeTitle + ", noticePlot=" + noticePlot
				+ ", noticeDate=" + noticeDate + ", user=" + user + "]";
	}

}