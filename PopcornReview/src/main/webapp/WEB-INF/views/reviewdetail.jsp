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
	
	<c:set var="me" value="${sessionScope.loginUser.id}" />

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
				<c:if test="${reviewDetail.user.id ne me}">
					<button class="review-report-button" type="button">신고하기</button>
				</c:if>
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

			

			<section id="comment-list-section" class="comment-list">
				<c:choose>
					<c:when test="${not empty commentList}">
						<c:forEach var="comment" items="${commentList}">
							<div class="comment-item ${comment.user.id == me ? 'mine' : ''}"
								data-cid="${comment.cId}">
								<p class="comment-text">${comment.cPlot}</p>

								<div class="comment-info">
									<span class="comment-author">${comment.user.name}</span> <span
										class="comment-date"> <fmt:formatDate value="${comment.cDate}" pattern="yyyy/MM/dd HH:mm:ss" />
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
<%-- 신고하기 모달                                                    --%>
<%-- =============================================================== --%>
<div id="reportModal" class="report-modal-overlay">
  <div class="report-modal-content">
    <form id="reportForm">
      <h2>신고하기</h2>
      <input type="hidden" id="rId" value="${reviewDetail.rId}"/>
      <%-- 신고 대상 리뷰 정보 (JS로 내용 채움) --%>
      <div class="report-target-info">
        <p><strong>작성자:</strong> <span id="reportAuthor">${reviewDetail.user.name}</span></p>
        <p><strong>내용:</strong> "<span id="reportContent">${reviewDetail.rPlot}</span>"</p>
      </div>

      <%-- 신고 사유 선택 --%>
      <fieldset class="report-reason-list">
        <legend class="sr-only">신고 사유 선택</legend>
        <div class="report-reason-item">
          <input type="radio" id="reason1" name="reportReason" value="스팸홍보/도배">
          <label for="reason1">스팸홍보/도배입니다.</label>
        </div>
        <div class="report-reason-item">
          <input type="radio" id="reason2" name="reportReason" value="음란물">
          <label for="reason2">음란물입니다.</label>
        </div>
        <div class="report-reason-item">
          <input type="radio" id="reason3" name="reportReason" value="불법정보">
          <label for="reason3">불법정보를 포함하고 있습니다.</label>
        </div>
        <div class="report-reason-item">
          <input type="radio" id="reason4" name="reportReason" value="청소년에게 유해함">
          <label for="reason4">청소년에게 유해한 내용입니다.</label>
        </div>
        <div class="report-reason-item">
          <input type="radio" id="reason5" name="reportReason" value="욕설/혐오/차별">
          <label for="reason5">욕설/생명경시/혐오/차별적 표현입니다.</label>
        </div>
        <div class="report-reason-item">
          <input type="radio" id="reason6" name="reportReason" value="개인정보 노출">
          <label for="reason6">개인정보가 노출되었습니다.</label>
        </div>
        <div class="report-reason-item">
          <input type="radio" id="reason7" name="reportReason" value="불쾌한 표현">
          <label for="reason7">불쾌한 표현이 있습니다.</label>
        </div>
      </fieldset>

      <%-- 액션 버튼 --%>
      <div class="report-modal-actions">
        <button type="button" class="report-cancel-btn">취소</button>
        <button type="submit" class="report-submit-btn">신고</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>
