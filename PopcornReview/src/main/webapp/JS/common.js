$(document).ready(function() {
	
    // --- 모달 열기 ---
    $('.btn-login').on('click', function() {
        $('#loginModal').addClass('active');
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
	
	const userMenuButton = $('#userMenuButton');
	const userDropdownMenu = $('#userDropdownMenu');

	// 닉네임 버튼을 클릭했을 때 드롭다운 메뉴를 토글(열고/닫고)
	userMenuButton.on('click', function(event) {
	    event.stopPropagation(); // 이벤트 버블링 방지
	    userDropdownMenu.toggleClass('show');
	});

	// 문서(document)의 다른 곳을 클릭했을 때 드롭다운 메뉴 닫기
	$(document).on('click', function() {
	    if (userDropdownMenu.hasClass('show')) {
	        userDropdownMenu.removeClass('show');
	    }
	});

    // 로그인 -> 아이디/비번 찾기 (신규)
    $('#loginModal .btn-find-account').on('click', function() {
        $('#loginModal').removeClass('active');
        $('#findAccountModal').addClass('active');
    });
    
    // 아이디/비번 찾기 -> 로그인 (신규)
    $('#findAccountModal .login-link').on('click', function(e) {
        e.preventDefault();
        $('#findAccountModal').removeClass('active');
        $('#loginModal').addClass('active');
    });

    // --- 아이디/비번 찾기 모달 내 탭 전환 (신규) ---
    $('.find-tabs .tab-link').on('click', function(e) {
        e.preventDefault();
        var tab_id = $(this).data('tab');

        // 모든 탭 링크와 탭 내용에서 active 클래스 제거
        $('.find-tabs .tab-link').removeClass('active');
        $('.tab-pane').removeClass('active');

        // 클릭된 탭과 그에 맞는 내용에 active 클래스 추가
        $(this).addClass('active');
        $("#"+tab_id).addClass('active');
    });


    // --- 모달 닫기 ---
    // 모달 외부(배경) 클릭 시 해당 모달 닫기
    $('.modal-overlay').on('click', function(e) {
        if (e.target === this) {
            $(this).removeClass('active');
        }
    });
});