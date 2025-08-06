<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <link rel="stylesheet" href="../CSS/common.css" />
    <link rel="stylesheet" href="../CSS/header.css" />
</head>

<body>
    <header>
        <div class="inner">
            <a href="../index.jsp" class="logo-area">
                <div class="logo">
                    <img src="../image/popcorn.png" alt="logo"/>
                </div>
                <div class="title">
                    <h1>Popcorn</h1> 
                    <h1>Review</h1>
                </div>
            </a>
            <div class="search">
                <input type="text" placeholder="영화를 검색해주세요" id="searchInput" />
            </div>
            <button class="btn-login">로그인</button>
        </div>
    </header>

    <div id="loginModal" class="modal-overlay">
        <div class="modal-content">
            <header class="modal-header">
                <h5 class="modal-title">로그인</h5>
                <a class="link signup-link">회원가입</a>
            </header>
            <div class="modal-body">
                <p class="subtitle">PopcornReview에서 여러분의 리뷰를 남겨주세요!</p>
                <form action="#" class="modal-form login-form">
                    <input type="text" placeholder="아이디" required>
                    <input type="password" placeholder="비밀번호" required>
                    <button type="submit" class="btn-submit">로그인</button>
                </form>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn-find-account">아이디/비밀번호 찾기</button>
            </footer>
        </div>
    </div>

    <div id="signupModal" class="modal-overlay">
        <div class="modal-content">
            <header class="modal-header">
                <h5 class="modal-title">회원 가입</h5>
                <a class="link login-link">로그인</a>
            </header>
            <div class="modal-body">
                <form action="#" class="modal-form signup-form">
                    <input type="text" placeholder="아이디를 입력하세요." required>
                    <input type="password" placeholder="비밀번호를 입력하세요." required>
                    <input type="password" placeholder="비밀번호를 다시 입력하세요." required>
                    <input type="email" placeholder="이메일" required>
                    <input type="text" placeholder="이름을 입력해주세요." required>
                    <input type="tel" placeholder="생년월일 (예: 2000-01-01)" required>
                    <input type="tel" placeholder="핸드폰 번호를 입력하세요" required>
                    <div class="gender-selection">
                        <span>성별:</span>
                        <input type="radio" id="male" name="gender" value="M" checked>
                        <label for="male">남성(M)</label>
                        <input type="radio" id="female" name="gender" value="W">
                        <label for="female">여성(W)</label>
                    </div>
                    <button type="submit" class="btn-submit">회원 가입</button>
                </form>
            </div>
        </div>
    </div>
    <script src="../JS/common.js"></script>
</body>

</html>