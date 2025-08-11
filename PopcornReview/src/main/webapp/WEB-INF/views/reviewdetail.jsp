<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 부트스트랩 및 Jquery 링크 연결 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<link rel="stylesheet" href="../../CSS/common.css" />
<link rel="stylesheet" href="../../CSS/reviewdetail.css" />

</head>

<body>
	<script>
	    const isLoggedIn = ${not empty sessionScope.loginUser};
	</script>

	<jsp:include page="include/header.jsp" />

	<%-- 컨트롤러에서 전달된 데이터가 있을 경우에만 화면을 표시합니다. --%>
	<c:if test="${not empty movieDetail and not empty reviewDetail}">
		<div class="movie-banner"
			style="background-image: url('${movieDetail.mUrlImage}');">
			<div class="banner-inner">
				<button class="back-button" onclick="history.back()">&lt;
					Back</button>
				<div class="banner-content">
					<div class="poster-section">
						<img src="${movieDetail.mUrlImage}"
							alt="${movieDetail.mTitle} 포스터" class="poster-image">
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
				<button class="review-report-button">신고하기</button>
			</section>

			<section class="comment-form">
			    <form id="commentForm" action="/comment/add" method="post">
			        <input type="hidden" name="review.rId" value="${reviewDetail.rId}">
			
			        <input type="hidden" name="user.id" value="${loginUser.id}" />
			
			        <textarea name="cPlot" class="comment-input" placeholder="댓글을 남겨주세요" required></textarea>
			        <button type="submit" class="comment-submit-button">등록</button>
			    </form>
			</section>

			<section id="comment-list-section" class="comment-list">
				<c:choose>
					<c:when test="${not empty commentList}">
						<c:forEach var="comment" items="${commentList}">
							<div class="comment-item">
								<p class="comment-text">${comment.cPlot}</p>
								<div class="comment-info">
									<span class="comment-author">${comment.user.name}</span> <span
										class="comment-date">${comment.cDate}</span>
								</div>
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

	<%-- 데이터가 없을 경우 메시지를 표시합니다. --%>
	<c:if test="${empty reviewDetail}">
		<div style="text-align: center; color: white; padding: 5rem;">
			<h2>해당 리뷰를 찾을 수 없습니다.</h2>
		</div>
	</c:if>

	<script src="../../JS/common.js"></script>
	<script src="../../JS/reviewdetail.js"></script>
</body>

</html>