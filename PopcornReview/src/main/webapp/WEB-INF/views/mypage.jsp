<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>마이페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/mypage.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
</head>

<body class="mypage-body">
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
	<%-- 컨트롤러에서 Model로 전달한 user 또는 세션의 loginUser를 사용합니다. --%>
	<c:set var="loginUser" value="${sessionScope.loginUser}" />

	<jsp:include page="include/header.jsp" />

	<div class="container">
		<section class="profile-wrap">
			<div class="profile-card profile-card--compact">
				<div class="profile-left">
					<div class="ph-meta">
						<h1 class="ph-name">
							<c:out value="${loginUser.id}" />
						</h1>
						<div class="ph-joined">
							생년월일 :
							<c:out value="${fn:substring(loginUser.birthdate, 0, 10)}" />
						</div>
						<button class="ph-edit" id="btnEditProfile" type="button">프로필
							수정</button>
					</div>
				</div>
			</div>
		</section>

		<section class="section">
			<h2 class="section-title">내가 쓴 리뷰</h2>
			<div class="review-card-list">
				<%-- 표시할 칸의 개수를 계산 (최소 3개, 실제 개수가 3개보다 많으면 그 개수만큼) --%>
				<c:set var="reviewCount" value="${fn:length(reviewList)}" />
				<c:set var="loopCount" value="${reviewCount < 3 ? 3 : reviewCount}" />

				<c:forEach var="i" begin="0" end="${loopCount - 1}">
					<c:choose>
						<%-- 실제 리뷰 데이터가 있는 경우 --%>
						<c:when test="${i < reviewCount}">
							<c:set var="r" value="${reviewList[i]}" />
							<a class="review-card" href="${ctx}/review/${r.rId}">
								<div class="rating-badge">
									<img class="rating-icon" src="${ctx}/image/popcorn.png" alt="" />
									<span class="rating-num">${r.rRating}</span>
								</div>
								<div class="review-title">
									<c:out value="${r.movie.mTitle}" />
								</div>
								<div class="review-snippet">
									<c:out value="${r.rPlot}" />
								</div>
							</a>
						</c:when>
						<%-- 리뷰 데이터가 없어 빈 칸을 표시해야 하는 경우 --%>
						<c:otherwise>
							<div class="review-card review-card--placeholder">
								새로운 리뷰를<br>작성해 보세요
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</section>

		<section class="section" id="my-comments">
			<h2 class="section-title">내가 쓴 댓글</h2>
			<div class="mypage-comment-list">
				<%-- 표시할 칸의 개수를 계산 (최소 3개, 실제 개수가 3개보다 많으면 그 개수만큼) --%>
				<c:set var="commentCount" value="${fn:length(commentList)}" />
				<c:set var="loopCount"
					value="${commentCount < 3 ? 3 : commentCount}" />

				<c:forEach var="i" begin="0" end="${loopCount - 1}">
					<c:choose>
						<%-- 실제 댓글 데이터가 있는 경우 --%>
						<c:when test="${i < commentCount}">
							<c:set var="cmt" value="${commentList[i]}" />
							<div class="comment-item clickable"
								data-href="${ctx}/review/${cmt.review.rId}">
								<div class="comment-body">
									<div class="comment-title">
										<a href="${ctx}/review/${cmt.review.rId}"> <c:out
												value="${fn:substring(cmt.review.rPlot, 0, 20)}" /> <c:if
												test="${fn:length(cmt.review.rPlot) > 20}">...</c:if>
										</a>
									</div>
									<div class="comment-text">
										<c:out value="${cmt.cPlot}" />
									</div>
								</div>
							</div>
						</c:when>
						<%-- 댓글 데이터가 없어 빈 칸을 표시해야 하는 경우 --%>
						<c:otherwise>
							<div class="review-card review-card--placeholder">
								새로운 댓글을<br>작성해 보세요

							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</section>
	</div>

	<div class="mp-modal" id="editProfileModal" aria-hidden="true">
		<div class="mp-modal-dialog profile-edit">
			<div class="mp-modal-header">
				<h3>프로필 수정</h3>
				<button class="mp-modal-close" id="btnCloseModal" type="button">×</button>
			</div>

			<form id="profileEditForm" method="post" action="${ctx}/user/update"
				class="mp-modal-body">
				<%-- User VO 필드명에 맞게 name과 value를 모두 수정 --%>
				<label class="form-row"><span>아이디</span> <input type="text"
					name="id" value="<c:out value='${user.id}'/>" readonly /></label> <label
					class="form-row"><span>이메일</span> <input type="email"
					name="email" value="<c:out value='${user.email}'/>"
					placeholder="이메일" /></label> <label class="form-row"><span>닉네임</span>
					<input type="text" name="name"
					value="<c:out value='${user.name}'/>" placeholder="이름을 입력해주세요." /></label>
				<label class="form-row"><span>생년월일</span> <input type="date"
					name="birthdate"
					value="<c:out value='${fn:substring(user.birthdate, 0, 10)}'/>" /></label>
				<label class="form-row"><span>핸드폰 번호</span> <input
					type="tel" name="phone" value="<c:out value='${user.phone}'/>"
					placeholder="핸드폰 번호를 입력하세요" /></label>

				<div class="mp-modal-footer">
					<button type="button" class="ph-edit" id="btnDeleteAccount">회원탈퇴</button>
					<button type="submit" class="ph-edit">저장</button>
				</div>
			</form>
		</div>
	</div>

	<form id="deleteForm" method="post" action="${ctx}/user/delete"
		style="display: none;">
		<input type="hidden" name="id" value="<c:out value='${user.id}'/>" />
	</form>

	<script
		src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"
		defer></script>
	<script>
		window.addEventListener('DOMContentLoaded', function() {
			// 프로필 수정 모달
			(function() {
				var modal = document.getElementById('editProfileModal');
				var btnEdit = document.getElementById('btnEditProfile');
				var btnClose = document.getElementById('btnCloseModal');

				function openModal() {
					modal.setAttribute('aria-hidden', 'false');
					document.body.classList.add('noscroll');
				}
				function closeModal() {
					modal.setAttribute('aria-hidden', 'true');
					document.body.classList.remove('noscroll');
				}

				if (btnEdit)
					btnEdit.addEventListener('click', openModal);
				if (btnClose)
					btnClose.addEventListener('click', closeModal);
				modal.addEventListener('click', function(e) {
					if (e.target === modal)
						closeModal();
				});

				// 회원탈퇴 버튼
				var btnDelete = document.getElementById('btnDeleteAccount');
				if (btnDelete) {
					btnDelete.addEventListener('click', function() {
						if (confirm('정말로 회원 탈퇴를 하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) {
							document.getElementById('deleteForm').submit();
						}
					});
				}
			})();

			// 댓글 카드 전체 클릭
			(function() {
				document.querySelectorAll('.comment-item.clickable').forEach(
						function(el) {
							el.addEventListener('click', function(e) {
								if (e.target.closest('a, button'))
									return;
								var url = el.getAttribute('data-href')
										|| (el.querySelector('a') && el
												.querySelector('a')
												.getAttribute('href'));
								if (url)
									location.href = url;
							});
						});
			})();
		});

		// jQuery / Slick 의존: load 이후 보장
		window.addEventListener('load', function() {
			var $reviewSlider = jQuery('.review-card-list');
			var $commentSlider = jQuery('.mypage-comment-list');

			if ($reviewSlider.length && $reviewSlider.children.length > 0
					&& !$reviewSlider.hasClass('slick-initialized')) {
				$reviewSlider.slick({
					slidesToShow : 3,
					slidesToScroll : 1,
					arrows : true,
					dots : false,
					infinite : false,
					responsive : [ {
						breakpoint : 1024,
						settings : {
							slidesToShow : 2
						}
					}, {
						breakpoint : 768,
						settings : {
							slidesToShow : 1
						}
					} ]
				});
			}
			if ($commentSlider.length && $commentSlider.children.length > 0
					&& !$commentSlider.hasClass('slick-initialized')) {
				$commentSlider.slick({
					slidesToShow : 3,
					slidesToScroll : 1,
					arrows : true,
					dots : false,
					infinite : false,
					responsive : [ {
						breakpoint : 1024,
						settings : {
							slidesToShow : 2
						}
					}, {
						breakpoint : 768,
						settings : {
							slidesToShow : 1
						}
					} ]
				});
			}
		});
	</script>
	<script src="${pageContext.request.contextPath}/JS/common.js"></script>
</body>
</html>