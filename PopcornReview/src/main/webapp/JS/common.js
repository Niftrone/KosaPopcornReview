$(document).ready(function() {
    // 헤더의 '로그인' 버튼 클릭 시 모달 열기
    $('.btn-login').on('click', function(e) {
        e.preventDefault(); // a 태그의 기본 동작 방지
        $('#loginModal').addClass('active');
    });

    // 모달의 닫기 버튼 클릭 시 모달 닫기
    $('#loginModal .close-modal').on('click', function() {
        $('#loginModal').removeClass('active');
    });

    // 모달 배경 클릭 시 모달 닫기
    $('#loginModal').on('click', function(e) {
        if (e.target === this) { // e.target이 모달 배경 자신일 때만
            $(this).removeClass('active');
        }
    });
});

$(document).ready(function() {
    // '로그인' 버튼 클릭 시 로그인 모달 표시
    $('.btn-login').on('click', function() {
        $('#loginModal').css('display', 'flex');
    });

    // 로그인 모달의 '회원가입' 링크 클릭
    $('.signup-link').on('click', function(e) {
        e.preventDefault(); // a 태그 기본 동작 방지
        $('#loginModal').hide();
        $('#signupModal').css('display', 'flex');
    });

    // 회원가입 모달의 '로그인' 링크 클릭
    $('.login-link').on('click', function(e) {
        e.preventDefault(); // a 태그 기본 동작 방지
        $('#signupModal').hide();
        $('#loginModal').css('display', 'flex');
    });

    // 모달 외부 클릭 시 모달 닫기
    $('.modal-overlay').on('click', function(e) {
        // 실제 모달 컨텐츠 영역이 아닌 오버레이 부분을 클릭했을 때만 닫힘
        if (e.target === this) {
            $(this).hide();
        }
    });
});