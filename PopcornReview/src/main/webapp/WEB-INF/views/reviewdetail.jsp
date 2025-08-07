<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    <!-- 부트스트랩 및 Jquery 링크 연결 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <link rel="stylesheet" href="../../CSS/common.css" />
    <link rel="stylesheet" href="../../CSS/reviewdetail.css" />

</head>

<body>
    <jsp:include page="include/header.jsp" />
    <div class="movie-banner">
        <div class="banner-inner">
            <button class="back-button" onclick="history.back()">&lt; Back</button>

            <div class="banner-content">
                <div class="poster-section">
                    <img src="https://i.namu.wiki/i/ofz_WZUSZXWWoYI4Q-GZKYXOLHQJVpaXcsw-yac2DL96J2ION3oVidDvgj1JMJ8cmOI5tisurnUi4eOpCLYTQA.webp"
                        alt="고스트 라이더: 복수의 정신 포스터" class="poster-image">
                </div>

                <div class="info-section">
                    <h1 class="movie-title">고스트 라이더: 복수의 정신</h1>
                    <h1 class="info-page">User Reviews</h1>
                </div>
            </div>

        </div>
    </div>        

    <main class="review-container">
        <section class="review-content-box">
            <p id="review-main-text" class="review-text"></p>
            <button class="review-report-button">신고하기</button>
        </section>

        <section class="comment-form">
            <textarea class="comment-input" placeholder="댓글을 남겨주세요"></textarea>
            <button class="comment-submit-button">추가</button>
        </section>

        <section id="comment-list-section" class="comment-list">
        </section>

        <div id="loader">
            <div class="spinner"></div>
        </div>
    </main>

    <script src="./JS/common.js"></script>
    <script src="JS/reviewdetail.js"></script>
</body>

</html>