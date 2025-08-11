package com.service.popcornreview.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.service.popcornreview.service.*;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.Notice;
import com.service.popcornreview.vo.User;
import ch.qos.logback.core.net.SyslogOutputStream;
import com.service.popcornreview.service.ReviewService;



import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    private final ActorService actorService;

    private final CommentService commentService;

    private final ReviewService reviewService;
	
	@Autowired
	private UserService userService;


    UserController(ReviewService reviewService, CommentService commentService, ActorService actorService) {
        this.reviewService = reviewService;
        this.commentService = commentService;
        this.actorService = actorService;
    }


	/**
	 * 로그인 처리
	 * @param user JSP의 form에서 name(id, password)에 맞춰 User 객체로 데이터를 받습니다.
	 * @param session 로그인 성공 시 사용자 정보를 저장할 세션 객체입니다.
	 * @param redirectAttributes 로그인 실패 시 메시지를 전달하기 위한 객체입니다.
	 */
	@PostMapping("/login")
	public String doLogin(User user, HttpSession session) {
		User foundUser = userService.getUser(user); // DB에서 사용자 정보 조회
		
		if (foundUser != null) {
			// 로그인 성공
			session.setAttribute("loginUser", foundUser); // 세션에 "loginUser"라는 이름으로 사용자 정보 저장
			System.out.println(foundUser.getName() + "님 로그인 성공");
		} else {
			// 로그인 실패
			System.out.println("로그인 실패");
			session.setAttribute("errorTitle", "로그인 실패");
			session.setAttribute("errorMessage", "아이디나 비밀번호를 확인해 주세요");
			return "/error";
		}
		return "redirect:/"; // 메인 페이지로 리다이렉트
	}

	/**
	 * 회원가입 처리
	 * @param user JSP의 form에서 각 input의 name에 맞춰 User 객체로 데이터를 받습니다.
	 */
	@PostMapping("/register")
	public String addUser(User user, HttpSession session) {
		session.setAttribute("errorTitle", "회원가입 실패");
		session.setAttribute("errorMessage", "(예시 : 날짜 2000-05-08 전화번호 : 01011114444)");
		
		if(userService.addUser(user) == 0) {
			return "/error";
		}
		System.out.println("회원가입 성공: " + user.getId());
		
		return "redirect:/"; // 회원가입 성공 후 메인 페이지로
	}

	
	/**
	 * 아이디/비밀번호 찾기
	 */
	@PostMapping("/find")
	public String doFindUser(User user, boolean test, HttpSession session) {
		User foundUser = userService.getUser(user);
		
		session.setAttribute("errorTitle", "아이디/비번 찾기 실패");
		session.setAttribute("errorMessage", "입력한 값을 확인해주세요.");

		if (foundUser == null) {
		    return "/error";
		}

		if(test) {
			session.setAttribute("findIdOrPw", "아이디 찾기 성공");
			session.setAttribute("findText", foundUser.getId());
		} else {
			session.setAttribute("findIdOrPw", "비밀번호 찾기 성공");
			session.setAttribute("findText", foundUser.getPwd());
		}

		
		return "find";
	}
	
	/**
	 * 마이페이지
	 */
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		// 세션에 로그인 확인
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {

			model.addAttribute("errorTitle", "로그인 필요");
			model.addAttribute("errorMessage", "마이페이지를 이용하려면 로그인이 필요합니다.");
			return "error";
		}
		try {
			// 사용자가 작성한 리뷰/댓글 목록 조회
			Review reviewCondition = new Review();
			reviewCondition.setUser(loginUser);
			List<Review> reviewList = reviewService.getAllReviews(reviewCondition);

			// 댓글
			Comment commentCondition = new Comment();
			commentCondition.setUser(loginUser);
			List<Comment> commentList = commentService.getComments(commentCondition);

			model.addAttribute("reviewList", reviewList);
			model.addAttribute("commentList", commentList);
			model.addAttribute("user", loginUser); // 프로필에 채워야 해서 넘겨야함

			return "mypage";

		} catch (Exception e) {
			model.addAttribute("errorTitle", "페이지 로딩 실패");
			model.addAttribute("errorMessage", "마이페이지 이용이 제한됩니다.");
			return "error";

		}

	}
	
	@PostMapping("update")
	public String updateUser(User user, HttpSession session) {
		System.out.println("유저정보 업데이트 진입?");
		try {
			userService.updateUser(user);
			
			//업데이트user정보 session에 저장
			User updateUser = userService.getUser(user);
			session.setAttribute("loginUser", updateUser);
			
			return "redirect:/user/mypage";
			
		} catch (Exception e) {
			session.setAttribute("errorTitle", "정보 수정 실패");
	        session.setAttribute("errorMessage", "사용자 정보를 수정하는 중 오류가 발생했습니다.");
	        return "error";
		}
	}
	/**
	 * 회원 탈퇴 처리
	 */
	@PostMapping("/delete")
	public String deleteUser(String id, HttpSession session) {
	    try {
	      
	        userService.deleteUser(id);
	        
	        session.invalidate();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        session.setAttribute("errorTitle", "회원 탈퇴 실패");
	        session.setAttribute("errorMessage", "회원 탈퇴 처리 중 오류가 발생했습니다.");
	        return "error";
	    }
	    
	    // 3. 탈퇴 후 메인 페이지로 이동
	    return "redirect:/";
	}
	
	
	
	
	@GetMapping("/logout")
	public String doLogout(HttpSession session) {
		session.invalidate(); // 현재 세션을 무효화시킴
		System.out.println("로그아웃 되었습니다.");
		return "redirect:/"; // 메인 페이지로 리다이렉트
	}

}

