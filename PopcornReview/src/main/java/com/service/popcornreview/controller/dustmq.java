package com.service.popcornreview.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.service.popcornreview.service.ActorService;
import com.service.popcornreview.service.MovieService;
import com.service.popcornreview.service.NoticeService;
import com.service.popcornreview.service.ReportService;
import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Notice;
import com.service.popcornreview.vo.ReportedReview;

/**
 * Admin 전용 컨트롤러. 영화·공지·신고 리뷰에 대한 CRUD 및 대시보드 기능을 제공한다.
 * 모든 POST 작업은 성공 시 "success.jsp", 실패 시 "error.jsp" 로 view 를 포워드한다.
 */
@Controller
public class AdminController {

    /* ========================= 주입 서비스 ========================= */
    @Autowired private MovieService   movieService;
    @Autowired private NoticeService  noticeService;
    @Autowired private ReportService  reportService;
    @Autowired private ActorService   actorService;

    /* ====================== 커스텀 바인더 설정 ====================== */
    @InitBinder
    public void bindActors(WebDataBinder binder) {
        binder.registerCustomEditor(List.class, "actors", new CustomCollectionEditor(List.class) {
            @Override
            protected Object convertElement(Object element) {
                if (element == null) return null;
                String name = element.toString().trim();
                if (name.isBlank()) return null;
                return actorService.getActor(name);  // 존재하면 반환, 없으면 생성 후 반환
            }
        });
    }

    /* ======================== 대시보드 진입 ======================== */
    @GetMapping("/admin")
    public String adminPage() {
        return "admin"; // /WEB-INF/views/admin.jsp
    }

    @GetMapping("/admin/list")
    public String adminHome(Model model) {
        List<Movie>          movieList  = movieService.getAllMovies(new Movie());
        List<Notice>         noticeList = noticeService.getNotices(new Notice());
        List<ReportedReview> reportList = reportService.getReported();

        model.addAttribute("movieList",  movieList);
        model.addAttribute("noticeList", noticeList);
        model.addAttribute("reportList", reportList);
        return "admin";
    }

    /* ============================ 영화 ============================ */
    // 영화 등록
    @PostMapping("/admin/movie/add")
    public String addMovie(@ModelAttribute Movie movie, Model model) {
        try {
            movieService.addMovie(movie);
            model.addAttribute("message", "영화 등록 완료.");
            return "success"; // /WEB-INF/views/success.jsp
        } catch (Exception e) {
            model.addAttribute("error", "영화 등록 실패: " + e.getMessage());
            return "error";   // /WEB-INF/views/error.jsp
        }
    }

    // 영화 수정
    @PostMapping("/movie/update")
    public String doUpdateMovie(@ModelAttribute Movie movie, Model model) {
        try {
            movieService.updateMovie(movie);
            model.addAttribute("message", "영화 정보가 수정되었습니다.");
            return "success";
        } catch (Exception e) {
            model.addAttribute("error", "영화 수정 실패: " + e.getMessage());
            return "error";
        }
    }

    // 영화 삭제
    @PostMapping("/movie/delete")
    public String doDeleteMovie(@RequestParam("id") String movieId, Model model) {
        try {
            movieService.deleteMovie(movieId);
            model.addAttribute("message", "영화가 삭제되었습니다.");
            return "success";
        } catch (Exception e) {
            model.addAttribute("error", "영화 삭제 실패: " + e.getMessage());
            return "error";
        }
    }

    /* ========================= 신고 리뷰 ========================= */
    // 신고 리뷰 목록
    @GetMapping("/review/list")
    public String getReviewListAdmin(Model model) {
        List<ReportedReview> reportList = reportService.getReported();
        model.addAttribute("reportList", reportList);
        return "admin";
    }

    // 리뷰 삭제
    @PostMapping("/admin/review/delete")
    public String doDeleteReviewAdmin(@RequestParam("id") String reviewId, Model model) {
        try {
            reportService.deleteReview(reviewId);
            model.addAttribute("message", "리뷰가 삭제되었습니다.");
            return "success";
        } catch (Exception e) {
            model.addAttribute("error", "리뷰 삭제 실패: " + e.getMessage());
            return "error";
        }
    }

    /* ============================ 공지 ============================ */
    // 공지사항 목록
    @GetMapping("/notice/list")
    public String getNoticeListAdmin(Model model) {
        List<Notice> noticeList = noticeService.getNotices(new Notice());
        model.addAttribute("noticeList", noticeList);
        return "admin";
    }

    // 공지사항 등록
    @PostMapping("/notice/add")
    public String doAddNotice(@ModelAttribute Notice notice, Model model) {
        try {
            noticeService.addNotice(notice);
            model.addAttribute("message", "공지사항이 등록되었습니다.");
            return "success";
        } catch (Exception e) {
            model.addAttribute("error", "공지 등록 실패: " + e.getMessage());
            return "error";
        }
    }

    // 공지사항 수정
    @PostMapping("/notice/update")
    public String doUpdateNotice(@ModelAttribute Notice notice, Model model) {
        try {
            noticeService.updateNotice(notice);
            model.addAttribute("message", "공지사항이 수정되었습니다.");
            return "success";
        } catch (Exception e) {
            model.addAttribute("error", "공지 수정 실패: " + e.getMessage());
            return "error";
        }
    }

    // 공지사항 삭제
    @PostMapping("/notice/delete")
    public String doDeleteNotice(@RequestParam("id") Long noticeId, Model model) {
        try {
            noticeService.deleteNotice(noticeId);
            model.addAttribute("message", "공지사항이 삭제되었습니다.");
            return "success";
        } catch (Exception e) {
            model.addAttribute("error", "공지 삭제 실패: " + e.getMessage());
            return "error";
        }
    }
}
