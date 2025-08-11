$(document).ready(function() {
    // --- 모달 열기 ---
    $('.btn-login').on('click', function() {
        $('#loginModal').addClass('active');
    });

    // --- 모달 닫기 ---
    // 모달 외부(배경) 클릭 시 해당 모달 닫기
    $('.modal-overlay').on('click', function(e) {
        if ($(e.target).hasClass('modal-overlay')) {
            $(this).removeClass('active');
        }
    });

    // --- 모달 간 전환 ---
    // 로그인 -> 회원가입
    $('#loginModal .signup-link').on('click', function(e) {
        e.preventDefault();
        $('#loginModal').removeClass('active');
        $('#signupModal').addClass('active');
    });

    // 회원가입 -> 로그인
    $('#signupModal .login-link').on('click', function(e) {
        e.preventDefault();
        $('#signupModal').removeClass('active');
        $('#loginModal').addClass('active');
    });
    
    // 로그인 -> 아이디/비번 찾기
    $('#loginModal .btn-find-account').on('click', function(e) {
        e.preventDefault();
        $('#loginModal').removeClass('active');
        $('#findAccountModal').addClass('active');
    });
    
    // 아이디/비번 찾기 -> 로그인
    $('#findAccountModal .login-link').on('click', function(e) {
        e.preventDefault();
        $('#findAccountModal').removeClass('active');
        $('#loginModal').addClass('active');
    });

    // --- 아이디/비번 찾기 모달 내 탭 전환 ---
    $('.find-tabs .tab-link').on('click', function(e) {
        e.preventDefault();
        var tabId = $(this).data('tab');

        // 모든 탭 링크와 탭 내용에서 active 클래스 제거
        $('.find-tabs .tab-link').removeClass('active');
        $('.tab-pane').removeClass('active');

        // 클릭된 탭과 그에 맞는 내용에 active 클래스 추가
        $(this).addClass('active');
        $("#" + tabId).addClass('active');
    });

    // --- 유저 드롭다운 메뉴 ---
    const userMenuButton = $('#userMenuButton');
    const userDropdownMenu = $('#userDropdownMenu');

    // 닉네임 버튼을 클릭했을 때 드롭다운 메뉴를 토글
    userMenuButton.on('click', function(event) {
        event.stopPropagation(); // 이벤트 버블링 방지
        userDropdownMenu.toggleClass('show');
    });

    // 문서의 다른 곳을 클릭했을 때 드롭다운 메뉴 닫기
    $(document).on('click', function() {
        if (userDropdownMenu.hasClass('show')) {
            userDropdownMenu.removeClass('show');
        }
    });


	// 1. 로그아웃 버튼을 변수에 저장
	const logoutButton = document.querySelector('a[href="/user/logout"]');

	// 2. 버튼이 실제로 존재하는지 확인한 후, 이벤트 리스너 추가
	if (logoutButton) {
	    logoutButton.addEventListener('click', () => {
	        localStorage.removeItem("loginUser");
	    });
	}
	
	// ======================================================
	    //               ⭐ 검색 기능 수정 부분 ⭐
	    // ======================================================
	    
	    // 실제 검색을 실행하는 함수
	    function executeSearch() {
	        // 입력된 검색어의 양쪽 공백 제거
	        const query = $('#searchInput').val().trim();

	        // 검색어가 비어있지 않으면 검색 실행
	        if (query) {
	            // query 파라미터를 포함하여 검색 결과 페이지로 이동
	            window.location.href = `/movie/search?query=${query}`;
	        } else {
	            alert('검색할 영화 제목을 입력해주세요.');
	            $('#searchInput').focus(); // 검색창에 다시 포커스
	        }
	    }

	    // 1. 검색창에서 엔터 키를 눌렀을 때
	    $('#searchInput').on('keydown', function(event) {
	        if (event.key === 'Enter') {
	            executeSearch(); // 검색 함수 호출
	        }
	    });
	
	
});