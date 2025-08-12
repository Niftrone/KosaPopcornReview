<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- JSTL 사용을 위한 선언 --%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <!-- Bootstrap CSS -->
<!--     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
 -->

    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/common.css" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

 	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
 
    <link rel="stylesheet" href="../CSS/common.css" />
    
</head>

<body>
	<c:if test="${not empty sessionScope.loginUser}">
	    <script>
	        const loginUser = {
	            id: "${sessionScope.loginUser.id}",
	            name: "${sessionScope.loginUser.name}"
	        };
	        localStorage.setItem("loginUser", JSON.stringify(loginUser));
	        console.log("✅ 로그인 유저 localStorage 저장됨:", loginUser);
	    </script>
	</c:if>

    <header>
        <div class="inner">
            <a href="/" class="logo-area">
                <div class="logo">
                    <img src="../image/popcorn.png" alt="logo"/>
                </div>
                <div class="title">
                    <h1>Popcorn</h1> 
                    <h1>Review</h1>
                </div>
            </a>
            <div class="search">
			    <input type="text" placeholder="영화를 검색해주세요" id="searchInput" autocomplete="off" />
			    	<div class="recent-searches" id="recentSearchesContainer">
			        	<div class="recent-header">
			            	<span class="recent-title">최근 검색어</span>
			            	<button type="button" class="clear-all">전체삭제</button>
			        	</div>
			        	<ul class="recent-list">
			            </ul>
			    	</div>
			</div>
            
            <div class="header-buttons">
    <c:choose>
        <%-- 1. 로그인하지 않았을 때 --%>
        <c:when test="${empty sessionScope.loginUser}">
            <button class="btn-login">로그인</button>
        </c:when>

        <%-- 2. 로그인했을 때 --%>
        <c:otherwise>
            <%-- 사용자 이름이 표시되는 버튼 --%>
            <button type="button" class="btn-user" id="userMenuButton">
                ${sessionScope.loginUser.name} 님
                <span>▼</span>
            </button>
            
            <%-- 드롭다운 메뉴 --%>
            <div class="dropdown-menu" id="userDropdownMenu">
                <%-- 2-1. 드롭다운 메뉴 안에서 관리자인지 일반 사용자인지 다시 확인 --%>
                <c:choose>
                    <c:when test="${sessionScope.loginUser.id == 'admin'}">
                        <a href="/admin">관리자 페이지</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/user/mypage">마이페이지</a>
                    </c:otherwise>
                </c:choose>
                <%-- 로그아웃 링크는 공통으로 표시 --%>
                <a href="/user/logout">로그아웃</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
        </div>
    </header>

    <%-- 로그인 모달 --%>
    <div id="loginModal" class="modal-overlay">
        <div class="modal-content">
            <header class="modal-header">
                <h5 class="modal-title">로그인</h5>
                <a class="link signup-link">회원가입</a>
            </header>
            <div class="modal-body">
                <p class="subtitle">PopcornReview에서 여러분의 리뷰를 남겨주세요!</p>
                <%-- [수정] action, method를 지정하고 input에 name 속성을 추가합니다. --%>
                <form action="/user/login" method="post" class="modal-form login-form">
                    <input type="text" name="id" placeholder="아이디" required>
                    <input type="password" name="pwd" placeholder="비밀번호" required>
                    <button type="submit" class="btn-submit">로그인</button>
                </form>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn-find-account">아이디/비밀번호 찾기</button>
            </footer>
        </div>
    </div>

    <%-- 회원가입 모달 --%>
    <div id="signupModal" class="modal-overlay">
        <div class="modal-content">
            <header class="modal-header">
                <h5 class="modal-title">회원 가입</h5>
                <a class="link login-link">로그인</a>
            </header>
            <div class="modal-body">
                <form action="/user/register" method="post" class="modal-form signup-form" id="signupForm">
                    <input type="text" id="signupId" name="id" placeholder="아이디를 입력하세요." required>
                    <div class="message" id="id-message"></div>

                    <input type="password" id="signupPwd" name="pwd" placeholder="비밀번호를 입력하세요." required>
                    <div class="message" id="pwd-message"></div>

                    <input type="password" id="signupPwdConfirm" name="pwd_confirm" placeholder="비밀번호를 다시 입력하세요." required>
                    <div class="message" id="pwd-confirm-message"></div>

                    <input type="email" name="email" placeholder="이메일" required>
                    <input type="text" name="name" placeholder="닉네임을 입력해주세요." required>
                    <input type="tel" name="birthdate" placeholder="생년월일 (예: 2000-01-01)" required>
                    <input type="tel" name="phone" placeholder="핸드폰 번호를 입력하세요" required>
                    <div class="gender-selection">
                        <span>성별:</span>
                        <input type="radio" id="male" name="gender" value="true" checked>
                        <label for="male">남성(M)</label>
                        <input type="radio" id="female" name="gender" value="false">
                        <label for="female">여성(W)</label>
                    </div>
                    <button type="submit" class="btn-submit">회원 가입</button>
                </form>
            </div>
        </div>
    </div>

    <div id="findAccountModal" class="modal-overlay">
        <div class="modal-content">
            <header class="modal-header">
                <h5 class="modal-title">아이디/비밀번호 찾기</h5>
                <a class="link login-link">로그인</a>
            </header>
            <div class="modal-body">
                <nav class="find-tabs">
                    <a class="tab-link active" data-tab="find-id">아이디 찾기</a>
                    <a class="tab-link" data-tab="find-pw">비밀번호 찾기</a>
                </nav>

                <div id="find-id" class="tab-pane active">
                    <p class="description">회원 정보에 등록된 정보로 아이디를 찾을 수 있습니다.</p>
                    <form action="/user/find" class="modal-form" method="post">
                        <input type="text" name="name" placeholder="닉네임을 입력해주세요." required>
                        <input type="tel" name="phone" placeholder="핸드폰 번호를 입력하세요" required>
                        <input name="test" value="true" hidden=""/>
                        <button type="submit" class="btn-submit">아이디 찾기</button>
                    </form>
                </div>

                <div id="find-pw" class="tab-pane">
                    <p class="description">가입 시 등록한 아이디와 이메일 주소를 입력해주세요.</p>
                     <form action="/user/find" class="modal-form" method = "post">
                        <input type="text" name="id" placeholder="아이디를 입력해주세요." required>
                        <input type="email" name="email" placeholder="이메일 주소를 입력하세요" required>
                        <input name="test" value="false" hidden=""/>
                        <button type="submit" class="btn-submit">비밀번호 찾기</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/JS/common.js"></script>
</body>

</html>