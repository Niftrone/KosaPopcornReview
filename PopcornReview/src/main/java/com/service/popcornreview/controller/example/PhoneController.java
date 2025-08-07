package com.service.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.service.spring.domain.Phone;
import com.service.spring.domain.UserInfo;
import com.service.spring.service.PhoneService;

import jakarta.servlet.http.HttpSession;

//Presentation Layer...
//결과페이지를 응답하는 컨트롤러..SSR..jsp사용....검색이용이...SEO

@Controller
public class PhoneController {
	
	@Autowired
	private PhoneService phoneService;
	
	//인트로 페이지부터 요청
	@GetMapping("/") //http://localhost:9000/
	public String home() {
		return "redirect:/index.jsp";
	}
	
	@GetMapping("/regPhone") //핸드폰 등록폼
	public String getRegPhone(Model model) {
		model.addAttribute("title", "핸드폰 관리 - 핸드폰 등록 폼");
		return "PhoneReg";
	}
	
	@PostMapping("/savePhone") //핸드폰 등록 로직
	public String doRegPhone(Phone phone, Model model) {
		try {
			phoneService.insert(phone);
			model.addAttribute("title", "핸드폰 관리 - 핸드폰 저장 성공");
			return "Result";
		}catch(Exception e) {
			model.addAttribute("title", "핸드폰 관리 - 핸드폰 저장 에러");
			return "Error";
		}
	}
	
	@GetMapping("/searchPhone")
	public String doList(Model model) {
		try {
			List<Phone> phones=phoneService.select();
			model.addAttribute("phones", phones);
			model.addAttribute("title", "핸드폰 관리 - 핸드폰 목록리스트");
			return "PhoneList";
		}catch(Exception e) {
			model.addAttribute("title", "핸드폰 관리 - 에러");
			model.addAttribute("message", "문제 내용 - 핸드폰 목록 조회중 에러 발생..");
			return "Error";
		}
	}
	
	@GetMapping("/detail")
	public String doDetail(Phone phone, Model model) {
		try {
			Phone selected=phoneService.select(phone);
			model.addAttribute("phone", selected);
			model.addAttribute("title", "핸드폰 관리 - 핸드폰 상세 조회");
			return "PhoneView";
			
		}catch(Exception e) {
			model.addAttribute("title", "핸드폰 관리 - 에러");
			model.addAttribute("message", "문제 내용 - 핸드폰 상세 조회중 에러 발생..");
			return "Error";
		}
	}
	
	@GetMapping("/login")
	public String getLogin() {
		return "Login"; //Login.jsp 로그인 폼 페이지		
	}
	
	@PostMapping("/login")
	public String doLogin(UserInfo user, Model model, HttpSession session) {
		try {
			UserInfo selected=phoneService.select(user);
			if(selected !=null) { //로그인 성공했다면
				session.setAttribute("loginUser", selected);
				return "redirect:/searchPhone";
			}else {//로그인 성공못했다면
				return "Login";
			}
		}catch(Exception e) { //로그인시 에러발생
			model.addAttribute("title", "핸드폰 관리 - 에러");
			model.addAttribute("message", "문제 내용 - 회원 로그인 중 에러 발생..");
			return "Error";
		}
	}
	@PostMapping("deleteAjax")
	@ResponseBody //비동길때는 잊지마셈
	public String doajaxDelete(@RequestParam List<String> num, Model model) {
	 try {
		phoneService.delete(num);
		return "";
	} catch (Exception e) {
		model.addAttribute("title", "핸드폰 관리 - 에러");
		model.addAttribute("message", "문제 내용 - 핸드폰 삭제중  에러 발생..");
		return "Error";
	}
	}
}















