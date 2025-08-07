package com.service.popcornreview.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.service.popcornreview.service.UserService;
import com.service.popcornreview.vo.User;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;

	/**
	 * 로그인 처리
	 * @param user JSP의 form에서 name(id, password)에 맞춰 User 객체로 데이터를 받습니다.
	 * @param session 로그인 성공 시 사용자 정보를 저장할 세션 객체입니다.
	 * @param redirectAttributes 로그인 실패 시 메시지를 전달하기 위한 객체입니다.
	 */
	@PostMapping("/login")
	public String doLogin(User user, HttpSession session, RedirectAttributes redirectAttributes) {
		User foundUser = userService.getUser(user); // DB에서 사용자 정보 조회
		
		if (foundUser != null) {
			// 로그인 성공
			session.setAttribute("loginUser", foundUser); // 세션에 "loginUser"라는 이름으로 사용자 정보 저장
			System.out.println(foundUser.getName() + "님 로그인 성공");
		} else {
			// 로그인 실패
			// addFlashAttribute: 리다이렉트 후에도 데이터가 한번 유지되도록 함
			redirectAttributes.addFlashAttribute("loginError", "아이디 또는 비밀번호가 일치하지 않습니다.");
			System.out.println("로그인 실패");
			return "/loginfail";
		}
		return "redirect:/"; // 메인 페이지로 리다이렉트
	}

	/**
	 * 회원가입 처리
	 * @param user JSP의 form에서 각 input의 name에 맞춰 User 객체로 데이터를 받습니다.
	 */
	@PostMapping("/register")
	public String addUser(User user) {
		userService.addUser(user);
		System.out.println("회원가입 성공: " + user.getId());
		return "redirect:/"; // 회원가입 성공 후 메인 페이지로
	}
	
	/**
	 * 아이디/비밀번호 찾기
	 */
	@PostMapping("/find")
	public String doFindUser(User user) {
		User foundUser = userService.getUser(user);
		// 여기에 찾은 정보를 보여주는 로직이 필요합니다.
		// 지금은 임시로 findResult.jsp로 이동합니다.
		return "findResult";
	}
	
	/**
	 * 마이페이지
	 */
	@GetMapping("/mypage")
	public String mypage() {
		// 세션 인터셉터 등을 통해 로그인 여부를 확인하는 로직이 추가되면 좋습니다.
		return "mypage"; // mypage.jsp로 이동
	}
	
	@GetMapping("/logout")
	public String doLogout(HttpSession session) {
		session.invalidate(); // 현재 세션을 무효화시킴
		System.out.println("로그아웃 되었습니다.");
		return "redirect:/"; // 메인 페이지로 리다이렉트
	}

}