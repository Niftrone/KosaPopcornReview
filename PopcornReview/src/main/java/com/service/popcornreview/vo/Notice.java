package com.service.popcornreview.vo;

public class Notice {
    
    // [수정] 필드 타입을 int에서 Integer로 변경합니다.
    private Integer noticeId;
    private String notice;
    private String noticePlot;
    private String noticeDate;

    public Notice() {

    }

    // [수정] 생성자의 파라미터 타입도 Integer로 변경합니다.
    public Notice(Integer noticeId, String notice, String noticePlot, String noticeDate) {
        super();
        this.noticeId = noticeId;
        this.notice = notice;
        this.noticePlot = noticePlot;
        this.noticeDate = noticeDate;
    }

    
    public Integer getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(Integer noticeId) {
        this.noticeId = noticeId;
    }

    public String getNotice() {
        return notice;
    }

    public void setNotice(String notice) {
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