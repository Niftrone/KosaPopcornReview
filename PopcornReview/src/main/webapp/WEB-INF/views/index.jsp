<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>PopcornReview</title>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
		<%-- ================== 1. 배너 섹션 ================== --%>
		<section class="banner-section">
			<div class="banner-slider">
				<c:choose>
					<c:when test="${not empty bannerMovies}" >
						<c:forEach var="movie" items="${bannerMovies}">
							<div class="banner-slide">
								<a class="banner-slide-content" href="/movie/detail?mId=${movie.mId}">
									<div class="banner-poster">
										<img src="${movie.mUrlImage}" alt="${movie.mTitle} 포스터">
									</div>
									<div class="banner-info">
										<h2>${movie.mTitle}</h2>
										<p>${movie.mPlot}</p>
										<p class="category">${movie.mCategory}</p>
										<div class="rating">
											<img src="./image/popcorn.png" class="icon-popcorn" alt="팝콘">
											<span class="rating-value">${movie.mAverageScore}</span>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="empty-message-box">
							<h3>배너를 준비 중입니다.</h3>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</section>

		<%-- ================== 2. 오늘의 추천 섹션 ================== --%>
		<section class="movie-list-section">
			<h3 class="section-title">오늘의 추천</h3>
			<div class="movie-card-list">
				<c:choose>
					<c:when test="${not empty recommendedMovies}">
						<c:forEach var="movie" items="${recommendedMovies}">
							<a class="movie-card" href="/movie/detail?mId=${movie.mId}"> <img
								src="${movie.mUrlImage}" alt="${movie.mTitle} 포스터">
								<div class="card-info">
									<span class="movie-title">${movie.mTitle}</span>
									<div class="rating">
										<img src="./image/popcorn.png" class="icon-star" alt="팝콘">
										<span class="rating-value">${movie.mAverageScore}</span>
									</div>
								</div>
							</a>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="empty-message-box">
							<h3>추천 영화를 준비 중입니다.</h3>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</section>

		<%-- ================== 3. 최신 리뷰 섹션 ================== --%>
		<section class="review-section">
			<h3 class="section-title">최신 리뷰</h3>
			<div class="review-card-list">
				<c:choose>
					<c:when test="${not empty latestReviews}">
						<c:forEach var="review" items="${latestReviews}">
							<a href="/review/${review.rId}" class="review-card">
								<div class="review-header">
									<div class="rating">
										<img src="./image/popcorn.png" class="icon-popcorn" alt="팝콘">
										<span class="rating-value">${review.rRating}</span>
									</div>
									<span class="reviewer-id">${review.user.id}***</span>
								</div>
								<p class="review-text">${review.rPlot}</p>
							</a>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="empty-message-box">
							<h3>최신 리뷰를 준비 중입니다.</h3>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</section>

		<%-- ================== 4. 이번주 TOP 10 섹션 ================== --%>
		<section class="top-movie-list-section">
			<h3 class="section-title">이번주 TOP 10</h3>
			<div class="movie-card-list">
				<c:choose>
					<c:when test="${not empty top10Movies}">
						<c:forEach var="movie" items="${top10Movies}">
							<a class="movie-card" href="/movie/detail?mId=${movie.mId}"> <img
								src="${movie.mUrlImage}" alt="${movie.mTitle} 포스터">
								<div class="card-info">
									<span class="movie-title">${movie.mTitle}</span>
									<div class="rating">
										<img src="./image/popcorn.png" class="icon-star" alt="팝콘">
										<span class="rating-value">${movie.mAverageScore}</span>
									</div>
								</div>
							</a>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="empty-message-box">
							<h3>TOP 10을 집계 중입니다.</h3>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</section>

		<%-- ================== 5. 출시 예정작 섹션 ================== --%>
		<section class="latest-movie-list-section">
			<h3 class="section-title">출시 예정작</h3>
			<div class="movie-card-list">
				<c:choose>
					<c:when test="${not empty upcomingMovies}">
						<c:forEach var="movie" items="${upcomingMovies}">
							<a class="movie-card" href="/movie/detail?mId=${movie.mId}"> <img
								src="${movie.mUrlImage}" alt="${movie.mTitle} 포스터">
								<div class="card-info">
									<span class="movie-title">${movie.mTitle}</span>
								</div>
							</a>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="empty-message-box">
							<h3>출시 예정작을 준비 중입니다.</h3>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</section>

		<%-- ================== 6. 공지사항 섹션 ================== --%>
		<section class="notice-section">
			<h3 class="section-title">공지 사항</h3>
			<div class="notice-list">
				<c:choose>
					<c:when test="${not empty notices}">
						<c:forEach var="notice" items="${notices}">
							<div class="notice-box">
								<a href="#" class="notice-item" data-title="${notice.notice}"
									data-date="${notice.noticeDate}"
									data-content="${notice.noticePlot}">
									<h4>${notice.notice}</h4>
									<p>${notice.noticePlot}</p>
								</a>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="empty-message-box notice-empty">
							<h3>등록된 공지사항이 없습니다.</h3>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</section>
	</main>

	<footer class="footer">
		<div class="footer-inner">

			<div class="footer-top">
				<div class="footer-logo">PopcornReview</div>
				<p class="footer-description">세상의 모든 영화, 팝콘리뷰에서 솔직한 평가를 만나보세요.</p>
			</div>

			<div class="footer-contact">
				<p>
					<span class="contact-label">관리자 이메일:</span> <span
						class="contact-info">admin@popcornreview.com</span>
				</p>
				<p>
					<span class="contact-label">사무실 전화번호:</span> <span
						class="contact-info">02-1234-5678</span>
				</p>
			</div>

			<div class="footer-bottom">
				<p class="copyright">&copy; 2025 PopcornReview. All rights
					reserved.</p>
				<div class="social-links">
					<span class="social-icon" aria-label="Instagram"><svg
							xmlns="http://www.w3.org/2000/svg" width="24" height="24"
							viewBox="0 0 24 24" fill="currentColor">
							<path
								d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.85s-.011 3.584-.069 4.85c-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07s-3.584-.012-4.85-.07c-3.252-.148-4.771-1.691-4.919-4.919-.058-1.265-.069-1.645-.069-4.85s.011-3.584.069-4.85c.149-3.225 1.664-4.771 4.919-4.919C8.416 2.175 8.796 2.163 12 2.163zm0 1.441c-3.171 0-3.543.011-4.79.069-2.734.124-3.886 1.273-4.01 4.01-.058 1.247-.069 1.622-.069 4.79s.011 3.543.069 4.79c.124 2.734 1.276 3.886 4.01 4.01 1.247.058 1.619.069 4.79.069s3.543-.011 4.79-.069c2.734-.124 3.886-1.276 4.01-4.01.058-1.247.069-1.622.069-4.79s-.011-3.543-.069-4.79c-.124-2.734-1.276-3.886-4.01-4.01-1.247-.058-1.62-.069-4.79-.069z"></path>
							<path
								d="M12 6.848c-2.835 0-5.152 2.316-5.152 5.152s2.317 5.152 5.152 5.152 5.152-2.316 5.152-5.152S14.835 6.848 12 6.848zm0 8.865c-2.041 0-3.713-1.672-3.713-3.713s1.672-3.713 3.713-3.713 3.713 1.672 3.713 3.713-1.672 3.713-3.713 3.713z"></path>
							<circle cx="16.948" cy="7.052" r="1.298"></circle></svg></span> <span
						class="social-icon" aria-label="YouTube"><svg
							xmlns="http://www.w3.org/2000/svg" width="24" height="24"
							viewBox="0 0 24 24" fill="currentColor">
							<path
								d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"></path></svg></span>
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
				<div id="noticeModalContent" class="notice-content"></div>
			</div>
		</div>
	</div>

	<script src="JS/index.js"></script>
</body>

</html>