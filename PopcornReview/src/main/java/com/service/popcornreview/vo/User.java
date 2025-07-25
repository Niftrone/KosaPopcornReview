package com.service.popcornreview.vo;

public class User {
	// DB 컬럼명 동일
	private String id; // 사용자 아이디
	private String pwd; // 비밀번호
	private String email; // 이메일
	private String name; // 이름
	private String birthdate; // 생년월일
	private String phone; // 전화번호
	private boolean gender; // 성별

	public User() {

	}

	public User(String id, String pwd, String email, String name, String birthdate, String phone, boolean gender) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.email = email;
		this.name = name;
		this.birthdate = birthdate;
		this.phone = phone;
		this.gender = gender;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public boolean isGender() {
		return gender;
	}

	public void setGender(boolean gender) {
		this.gender = gender;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", pwd=" + pwd + ", email=" + email + ", name=" + name + ", birthdate=" + birthdate
				+ ", phone=" + phone + ", gender=" + gender + "]";
	}
}