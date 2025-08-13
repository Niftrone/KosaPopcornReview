<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setTimeZone value="Asia/Seoul" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>

<!-- Bootstrap & jQuery (필요 시 유지) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../../CSS/common.css" />
<link rel="stylesheet" href="../../CSS/reviewdetail.css" />

<!-- 페이지 전역 상태 (로그인 여부) -->
<script>
    // JSTL -> JS 불리언으로 안전하게 변환
    window.isLoggedIn = ${ not empty sessionScope.loginUser ? 'true' : 'false' };
    window.loginUserId = "${sessionScope.loginUser.id}";
  </script>

<!-- 페이지 전용 모듈 스크립트 -->
<script src="../../JS/reviewdetail.js" defer></script>
</head>

<body>
	<jsp:include page="include/header.jsp" />

	<c:if test="${not empty movieDetail and not empty reviewDetail}">
	<div class="movie-banner" style="background-image: url('${movieDetail.mUrlImage}');">
    <%-- 위 태그에 style을 다시 추가하고, 잘못된 a, img 태그는 삭제합니다. --%>
    <div class="banner-inner">
        <button class="back-button" type="button">&lt; Back</button>
        <div class="banner-content">
            <div class="poster-section">
                <%-- ▼▼▼ 바로 이 위치의 <img> 태그를 <a>로 감싸야 합니다. ▼▼▼ --%>
                <a href="/movie/detail?mId=${movieDetail.mId}">
                    <img src="${movieDetail.mUrlImage}"
                         alt="${movieDetail.mTitle} 포스터" class="poster-image" />
                </a>
            </div>
            <div class="info-section">
                <h1 class="movie-title">${movieDetail.mTitle}</h1>
                <h1 class="info-page">User Reviews</h1>
            </div>
        </div>
    </div>
</div>

		<main class="review-container">
			<section class="review-content-box">
				<p class="review-text">${reviewDetail.rPlot}</p>
				<button class="review-report-button" type="button">신고하기</button>
			</section>

			<section class="comment-form">
				<form id="commentForm">
					<input type="hidden" id="rId" value="${reviewDetail.rId}" /> <input
						type="hidden" id="userId" value="${sessionScope.loginUser.id}" />
					<textarea id="cPlotInput" class="comment-input"
						placeholder="댓글을 남겨주세요" required></textarea>
					<button type="submit" id="commentSubmitBtn"
						class="comment-submit-button">등록</button>
				</form>
			</section>

			<c:set var="me" value="${sessionScope.loginUser.id}" />

			<section id="comment-list-section" class="comment-list">
				<c:choose>
					<c:when test="${not empty commentList}">
						<c:forEach var="comment" items="${commentList}">
							<div class="comment-item ${comment.user.id == me ? 'mine' : ''}"
								data-cid="${comment.cId}">
								<p class="comment-text">${comment.cPlot}</p>

								<div class="comment-info">
									<span class="comment-author">${comment.user.name}</span> <span
										class="comment-date"> <fmt:formatDate
											value="${comment.cDate}" pattern="yyyy/MM/dd HH:mm:ss" />
									</span>
								</div>

								<!-- 본인 댓글일 때만 햄버거 메뉴 -->
								<c:if test="${comment.user.id == me}">
									<div class="comment-menu">
										<!-- 인라인 onclick 제거 -->
										<button type="button" class="menu-button" aria-haspopup="true"
											aria-expanded="false" aria-controls="menu-${comment.cId}"
											aria-label="댓글 메뉴 열기">
											<svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
						                        <circle cx="12" cy="5" r="1.6" />
						                        <circle cx="12" cy="12" r="1.6" />
						                        <circle cx="12" cy="19" r="1.6" />
						                      </svg>
										</button>

										<div id="menu-${comment.cId}" class="menu-dropdown"
											role="menu">
											<button type="button" class="menu-item-btn menu-item-edit"
												role="menuitem">수정</button>
											<button type="button" class="menu-item-btn menu-item-delete"
												role="menuitem">삭제</button>
										</div>
									</div>
								</c:if>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<p style="text-align: center; color: #888;">첫 번째 댓글을 남겨주세요.</p>
					</c:otherwise>
				</c:choose>
			</section>
		</main>
	</c:if>

	<c:if test="${empty reviewDetail}">
		<div style="text-align: center; color: white; padding: 5rem;">
			<h2>해당 리뷰를 찾을 수 없습니다.</h2>
		</div>
	</c:if>
</body>
</html>
