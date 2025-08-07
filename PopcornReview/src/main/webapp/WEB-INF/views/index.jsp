<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>PopcornReview</title>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" type="text/css"
        href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
    <link rel="stylesheet" type="text/css"
        href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
    <script type="text/javascript"
        src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

    <link rel="stylesheet" href="CSS/common.css" />
    <link rel="stylesheet" href="CSS/index.css" />
  

</head>

<body>
    <jsp:include page="include/header.jsp" />

    <main class="main-content">
        <section class="banner-section">
            <div class="banner-slider">
                <c:if test="${not empty bannerMovies}">
                    <c:forEach var="movie" items="${bannerMovies}">
                        <div class="banner-slide">
                            <div class="banner-slide-content">
                                <div class="banner-poster">
                                    <img src="${movie.mUrlImage}" alt="${movie.mTitle} 포스터">
                                </div>
                                <div class="banner-info">
                                    <h2>${movie.mTitle}</h2>
                                    <p>${movie.mPlot}</p>
                                    <p class="category">${movie.mCategories}</p>
                                    <div class="rating">
                                        <img src="./image/popcorn.png" class="icon-popcorn" alt="팝콘">
                                        <span class="rating-value">${movie.mAverageScore}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty bannerMovies}">
                    <div class="banner-slide">
                        <div class="banner-slide-content">
                            <p>현재 표시할 영화가 없습니다.</p>
                        </div>
                    </div>
                </c:if>
            </div>
        </section>

        <section class="movie-list-section">
            <h3 class="section-title">오늘의 추천</h3>
            <div class="movie-card-list">
                <a class="movie-card">
                    <img src="https://image.tmdb.org/t/p/original/vhOOdzVSsMO60E8rfX91APOslSh.jpg"
                        alt="영화 포스터">
                    <div class="card-info">
                        <span class="movie-title">부산행</span>
                        <div class="rating">
                            <img src="./image/popcorn.png" class="icon-star" alt="팝콘">
                            <span class="rating-value">4.2</span>
                        </div>
                    </div>
                </a>
                <a class="movie-card">
                    <img src="https://image.tmdb.org/t/p/original/vhOOdzVSsMO60E8rfX91APOslSh.jpg"
                        alt="영화 포스터">
                    <div class="card-info">
                        <span class="movie-title">부산행</span>
                        <div class="rating">
                            <img src="./image/popcorn.png" class="icon-star" alt="팝콘">
                            <span class="rating-value">4.2</span>
                        </div>
                    </div>
                </a>
                <a class="movie-card">
                    <img src="https://image.tmdb.org/t/p/original/vhOOdzVSsMO60E8rfX91APOslSh.jpg"
                        alt="영화 포스터">
                    <div class="card-info">
                        <span class="movie-title">부산행</span>
                        <div class="rating">
                            <img src="./image/popcorn.png" class="icon-star" alt="팝콘">
                            <span class="rating-value">4.2</span>
                        </div>
                    </div>
                </a>
                <a class="movie-card">
                    <img src="https://image.tmdb.org/t/p/original/vhOOdzVSsMO60E8rfX91APOslSh.jpg"
                        alt="영화 포스터">
                    <div class="card-info">
                        <span class="movie-title">부산행</span>
                        <div class="rating">
                            <img src="./image/popcorn.png" class="icon-star" alt="팝콘">
                            <span class="rating-value">4.2</span>
                        </div>
                    </div>
                </a>
                <a class="movie-card">
                    <img src="https://image.tmdb.org/t/p/original/vhOOdzVSsMO60E8rfX91APOslSh.jpg"
                        alt="영화 포스터">
                    <div class="card-info">
                        <span class="movie-title">부산행</span>
                        <div class="rating">
                            <img src="./image/popcorn.png" class="icon-star" alt="팝콘">
                            <span class="rating-value">4.2</span>
                        </div>
                    </div>
                </a>
                <a class="movie-card">
                    <img src="https://image.tmdb.org/t/p/original/vhOOdzVSsMO60E8rfX91APOslSh.jpg"
                        alt="영화 포스터">
                    <div class="card-info">
                        <span class="movie-title">부산행</span>
                        <div class="rating">
                            <img src="./image/popcorn.png" class="icon-star" alt="팝콘">
                            <span class="rating-value">4.2</span>
                        </div>
                    </div>
                </a>
            </div>
        </section>

        <section class="review-section">
            <h3 class="section-title">최신 리뷰</h3>
            <div class="review-card-list">
                <a href="#" class="review-card">
                    <div class="review-header">
                        <div class="rating">
                            <img src="../image/popcorn.png" class="icon-popcorn" alt="팝콘"> <span
                                class="rating-value">4.3</span>
                        </div>
                        <span class="reviewer-id">movieLover***</span>
                    </div>
                    <p class="review-text">몰입해서 봤네요 배우들의 연기력이 대단합니다. 12.12 그날 밤의 분노가 다시 느껴지네요. 꼭 한번 보시길 바랍니다...</p>
                </a>
                <a href="#" class="review-card">
                    <div class="review-header">
                        <div class="rating">
                            <img src="../image/popcorn.png" class="icon-popcorn" alt="팝콘"> <span
                                class="rating-value">4.3</span>
                        </div>
                        <span class="reviewer-id">movieLover***</span>
                    </div>
                    <p class="review-text">몰입해서 봤네요 배우들의 연기력이 대단합니다. 12.12 그날 밤의 분노가 다시 느껴지네요. 꼭 한번 보시길 바랍니다...</p>
                </a>
                <a href="#" class="review-card">
                    <div class="review-header">
                        <div class="rating">
                            <img src="../image/popcorn.png" class="icon-popcorn" alt="팝콘"> <span
                                class="rating-value">4.3</span>
                        </div>
                        <span class="reviewer-id">movieLover***</span>
                    </div>
                    <p class="review-text">asdasdasdadaasdaasdasdsdasdaadsasasa</p>
                </a>
                <a href="#" class="review-card">
                    <div class="review-header">
                        <div class="rating">
                            <img src="../image/popcorn.png" class="icon-popcorn" alt="팝콘"> <span
                                class="rating-value">4.3</span>
                        </div>
                        <span class="reviewer-id">movieLover***</span>
                    </div>
                    <p class="review-text">몰입해서 봤네요 배우들의 연기력이 대단합니다. 12.12 그날 밤의 분노가 다시 느껴지네요. 꼭 한번 보시길 바랍니다...</p>
                </a>
            </div>
        </section>

        <section class="top-movie-list-section">
            <h3 class="section-title">이번주 TOP 10</h3>
            <div class="movie-card-list">
                <a class="movie-card">
                    <img src="https://image.tmdb.org/t/p/original/vhOOdzVSsMO60E8rfX91APOslSh.jpg"
                        alt="영화 포스터">
                    <div class="card-info">
                        <span class="movie-title">부산행</span>
                        <div class="rating">
                            <img src="./image/popcorn.png" class="icon-star" alt="팝콘">
                            <span class="rating-value">4.2</span>
                        </div>
                    </div>
                </a>
                <a class="movie-card">
                    <img src="https://image.tmdb.org/t/p/original/vhOOdzVSsMO60E8rfX91APOslSh.jpg"
                        alt="영화 포스터">
                    <div class="card-info">
                        <span class="movie-title">부산행</span>
                        <div class="rating">
                            <img src="./image/popcorn.png" class="icon-star" alt="팝콘">
                            <span class="rating-value">4.2</span>
                        </div>
                    </div>
                </a>
                <a class="movie-card">
                    <img src="https://image.tmdb.org/t/p/original/vhOOdzVSsMO60E8rfX91APOslSh.jpg"
                        alt="영화 포스터">
                    <div class="card-info">
                        <span class="movie-title">부산행</span>
                        <div class="rating">
                            <img src="./image/popcorn.png" class="icon-star" alt="팝콘">
                            <span class="rating-value">4.2</span>
                        </div>
                    </div>
                </a>
        </section>

        <section class="latest-movie-list-section">
            <h3 class="section-title">출시 예정작</h3>
            <div class="movie-card-list">
                <a class="movie-card">
                    <img src="https://image.tmdb.org/t/p/original/vhOOdzVSsMO60E8rfX91APOslSh.jpg"
                        alt="영화 포스터">
                    <div class="card-info">
                        <span class="movie-title">부산행</span>
                    </div>
                </a>
                <a class="movie-card">
                    <img src="https://image.tmdb.org/t/p/original/vhOOdzVSsMO60E8rfX91APOslSh.jpg"
                        alt="영화 포스터">
                    <div class="card-info">
                        <span class="movie-title">부산행</span>
                    </div>
                </a>
                <a class="movie-card">
                    <img src="https://image.tmdb.org/t/p/original/vhOOdzVSsMO60E8rfX91APOslSh.jpg"
                        alt="영화 포스터">
                    <div class="card-info">
                        <span class="movie-title">부산행</span>

                    </div>
                </a>
            </div>
        </section>

        <section class="notice-section">
            <h3 class="section-title">공지 사항</h3>
            <div class="notice-list">
                <div class="notice-box">
                    <a href="#" class="notice-item" 
                    data-title="정기 점검 안내 (Ver 1.0)" 
                    data-date="2025-08-01" 
                    data-content="안녕하세요, 팝콘리뷰입니다. 보다 안정적인 서비스 제공을 위해 매주 월요일 오전 2시부터 4시까지 약 2시간 동안 정기 점검을 진행합니다. 점검 시간에는 서비스 이용이 원활하지 않을 수 있으니 양해 부탁드립니다. 불편을 드려 죄송합니다.">
                        <h4>정기 점검 안내 (Ver 1.0)</h4>
                        <p>매주 월요일 오전 2시 ~ 4시 정기점검 합니다. 불편을 드려서 죄송합니다.</p>
                    </a>
                </div>
                <div class="notice-box">
                    <a href="#" class="notice-item" 
                    data-title="새로운 기능 업데이트 안내" 
                    data-date="2025-07-28"
                    data-content="이제부터 영화 리뷰에 댓글을 작성하고 다른 사용자와 소통할 수 있는 기능이 추가되었습니다. 또한, 마이페이지에서 내가 작성한 리뷰를 모아볼 수 있습니다. 많은 이용 바랍니다. 감사합니다.">
                        <h4>새로운 기능 업데이트 안내</h4>
                        <p>이제부터 댓글 기능을 사용하실 수 있습니다. 많은 이용 바랍니다.</p>
                    </a>
                </div>
                <div class="notice-box">
                    <a href="#" class="notice-item" 
                    data-title="서버 안정화 작업 안내" 
                    data-date="2025-07-25"
                    data-content="보다 쾌적한 리뷰 환경을 제공하기 위해 8월 15일 새벽 시간에 서버 안정화 작업이 있을 예정입니다. 작업 시간 동안 간헐적인 접속 지연이 발생할 수 있습니다. 사용자 여러분의 깊은 양해를 부탁드립니다.">
                        <h4>서버 안정화 작업 안내</h4>
                        <p>보다 나은 서비스를 위해 8월 15일 새벽에 서버 안정화 작업이 있을 예정입니다.</p>
                    </a>
                </div>
            </div>
        </section>
    </main>

    <footer class="footer">
        <div class="footer-inner">

            <div class="footer-top">
                <div class="footer-logo">PopcornReview</div>
                <p class="footer-description">
                    세상의 모든 영화, 팝콘리뷰에서 솔직한 평가를 만나보세요.
                </p>
            </div>

            <div class="footer-contact">
                <p>
                    <span class="contact-label">관리자 이메일:</span>
                    <span class="contact-info">admin@popcornreview.com</span>
                </p>
                <p>
                    <span class="contact-label">사무실 전화번호:</span>
                    <span class="contact-info">02-1234-5678</span>
                </p>
            </div>

            <div class="footer-bottom">
                <p class="copyright">&copy; 2025 PopcornReview. All rights reserved.</p>
                <div class="social-links">
                    <span class="social-icon" aria-label="Instagram"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.85s-.011 3.584-.069 4.85c-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07s-3.584-.012-4.85-.07c-3.252-.148-4.771-1.691-4.919-4.919-.058-1.265-.069-1.645-.069-4.85s.011-3.584.069-4.85c.149-3.225 1.664-4.771 4.919-4.919C8.416 2.175 8.796 2.163 12 2.163zm0 1.441c-3.171 0-3.543.011-4.79.069-2.734.124-3.886 1.273-4.01 4.01-.058 1.247-.069 1.622-.069 4.79s.011 3.543.069 4.79c.124 2.734 1.276 3.886 4.01 4.01 1.247.058 1.619.069 4.79.069s3.543-.011 4.79-.069c2.734-.124 3.886-1.276 4.01-4.01.058-1.247.069-1.622.069-4.79s-.011-3.543-.069-4.79c-.124-2.734-1.276-3.886-4.01-4.01-1.247-.058-1.62-.069-4.79-.069z"></path><path d="M12 6.848c-2.835 0-5.152 2.316-5.152 5.152s2.317 5.152 5.152 5.152 5.152-2.316 5.152-5.152S14.835 6.848 12 6.848zm0 8.865c-2.041 0-3.713-1.672-3.713-3.713s1.672-3.713 3.713-3.713 3.713 1.672 3.713 3.713-1.672 3.713-3.713 3.713z"></path><circle cx="16.948" cy="7.052" r="1.298"></circle></svg></span>
                    <span class="social-icon" aria-label="YouTube"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"></path></svg></span>
                </div>
            </div>
        </div>
    </footer>

    <div id="noticeDetailModal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="noticeModalTitle" class="modal-title"></h2>
                <button id="closeNoticeModal" class="close-button">&times;</button>
            </div>
            <div class="modal-body">
                <p id="noticeModalDate" class="notice-date"></p>
                <div id="noticeModalContent" class="notice-content">
                </div>
            </div>
        </div>
    </div>

    <script src="JS/index.js"></script>
</body>

</html>