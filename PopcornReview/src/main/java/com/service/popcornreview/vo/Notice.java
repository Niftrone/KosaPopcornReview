package com.service.popcornreview.vo;

class Notice {
	private int noticeId; // 공지사항 아이디 notice_id
	private String notice; // 공지사항 제목 notice
	private String noticePlot; // 공지사항 내용 notice_plot
	private String noticeDate; // 작성일 notice_date


	public Notice() {

	}

	public Notice(int noticeId, String notice, String noticePlot, String noticeDate) {
		super();
		this.noticeId = noticeId;
		this.notice = notice;
		this.noticePlot = noticePlot;
		this.noticeDate = noticeDate;
	}

	public int getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}

	public String getnotice() {
		return notice;
	}

	public void setnotice(String notice) {
		this.notice = notice;
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

	@Override
	public String toString() {
		return "Notice [noticeId=" + noticeId + ", notice=" + notice + ", noticePlot=" + noticePlot
				+ ", noticeDate=" + noticeDate + "]";
	}

}