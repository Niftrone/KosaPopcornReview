package com.service.popcornreview.vo;

public class Actor {
	private String aId;       // 배우 아이디 a_id
	private String aName;     // 배우 이름 a_name
	private String aPlot;     // 배우 설명 a_plot
	private String aUrlImage; // 대표 이미지 URL a_url_image

	public Actor() { }

	public Actor(String aId, String aName, String aPlot, String aUrlImage) {
		this.aId = aId;
		this.aName = aName;
		this.aPlot = aPlot;
		this.aUrlImage = aUrlImage;
	}

	public String getaId() {
		return aId;
	}

	public void setaId(String aId) {
		this.aId = aId;
	}

	public String getaName() {
		return aName;
	}

	public void setaName(String aName) {
		this.aName = aName;
	}

	public String getaPlot() {
		return aPlot;
	}

	public void setaPlot(String aPlot) {
		this.aPlot = aPlot;
	}

	public String getaUrlImage() {
		return aUrlImage;
	}

	public void setaUrlImage(String aUrlImage) {
		this.aUrlImage = aUrlImage;
	}

	@Override
	public String toString() {
		return "Actor [aId=" + aId + ", aName=" + aName + ", aPlot=" + aPlot + ", aUrlImage=" + aUrlImage + "]";
	}
}
