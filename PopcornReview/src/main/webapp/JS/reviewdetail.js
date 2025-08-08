$(document).ready(function() {
	$('#commentForm').on('submit', function (event) {
	    if (!isLoggedIn) {
	        event.preventDefault();
	        alert('로그인이 필요한 기능입니다.');
	        $('#loginModal').addClass('active');
	    }
	});

	$('.review-report-button').on('click', function () {
	    if (!isLoggedIn) {
	        alert('로그인이 필요한 기능입니다.');
	        $('#loginModal').addClass('active');
	    } else {
	        alert('신고 기능은 준비 중입니다.');
	    }
	});

	$('.comment-input').on('input', function () {
	    this.style.height = 'auto';
	    this.style.height = (this.scrollHeight) + 'px';
	});

	const urlParams = new URLSearchParams(window.location.search);
	if (urlParams.get('error') === 'auth_required') {
	    alert('로그인이 필요한 기능입니다.');
	    $('#loginModal').addClass('active');
	}

    // Textarea 자동 높이 조절
    $('.comment-input').on('input', function () {
        this.style.height = 'auto';
        this.style.height = (this.scrollHeight) + 'px';
    });
	
	const loginUser = JSON.parse(localStorage.getItem("loginUser"));
	if (loginUser && loginUser.id) {
	    $('#userIdField').val(loginUser.id);
	}
});
