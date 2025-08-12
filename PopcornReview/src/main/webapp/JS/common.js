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

	userMenuButton
	  .off('click.userMenu')                // 기존 중복 핸들러 제거
	  .on('click.userMenu', function (e) {
	    e.stopPropagation();
	    // alert('clicked');  // 테스트용
	    userDropdownMenu.toggleClass('show');
	  });

	$(document)
	  .off('click.userMenuClose')
	  .on('click.userMenuClose', function () {
	    userDropdownMenu.removeClass('show');
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
	//               ⭐ 최근 검색어 기능 수정 (UI/UX 개선) ⭐
	// ======================================================

	const searchInput = $('#searchInput');
	const recentSearchesContainer = $('#recentSearchesContainer');
	const recentList = $('.recent-list');
	const clearAllButton = $('.clear-all');

	function getFormattedDate(dateObject) {
	    const year = dateObject.getFullYear();
	    const month = String(dateObject.getMonth() + 1).padStart(2, '0');
	    const day = String(dateObject.getDate()).padStart(2, '0');
	    return `${year}-${month}-${day.padStart(2, '0')}`; // 일(day)도 padStart 적용
	}

	function executeSearch(query) {
	    if (query) {
	        let recentSearches = JSON.parse(localStorage.getItem('recentSearches')) || [];
	        const today = getFormattedDate(new Date());
	        recentSearches = recentSearches.filter(item => item.query !== query);
	        recentSearches.unshift({ query: query, date: today });
	        if (recentSearches.length > 10) {
	            recentSearches.pop();
	        }
	        localStorage.setItem('recentSearches', JSON.stringify(recentSearches));
	        window.location.href = `/movie/search?query=${query}`;
	    } else {
	        alert('검색할 영화 제목을 입력해주세요.');
	        searchInput.focus();
	    }
	}

	function displayRecentSearches() {
	    recentList.empty();
	    const recentSearches = JSON.parse(localStorage.getItem('recentSearches')) || [];

	    if (recentSearches.length > 0) {
	        recentSearches.forEach((item, index) => {
	            const listItem = $('<li>').addClass('recent-item');
	            const icon = $('<span>').addClass('material-icons').text('history');
	            const querySpan = $('<span>').addClass('query-text').text(item.query);
	            const dateSpan = $('<span>').addClass('query-date').text(formatDateShort(item.date)); // 날짜 형식 변경
	            const deleteButton = $('<button>').addClass('delete-btn').html('&times;');

	            deleteButton.on('click', function(event) {
	                event.stopPropagation(); // 클릭 이벤트가 li로 전파되는 것을 막음
	                removeRecentSearch(index);
	            });

	            listItem.append(icon).append(querySpan).append(dateSpan).append(deleteButton);
	            listItem.on('click', function() {
	                searchInput.val(item.query);
	                executeSearch(item.query);
	            });
	            recentList.append(listItem);
	        });
	        recentSearchesContainer.show();
	    } else {
	        recentSearchesContainer.hide();
	    }
	}

	function formatDateShort(dateString) {
	    const dateParts = dateString.split('-');
	    if (dateParts.length === 3) {
	        return `${dateParts [1]}.${dateParts [2]}.`;
	    }
	    return dateString;
	}

	function removeRecentSearch(indexToRemove) {
	    let recentSearches = JSON.parse(localStorage.getItem('recentSearches')) || [];
	    recentSearches = recentSearches.filter((_, index) => index !== indexToRemove);
	    localStorage.setItem('recentSearches', JSON.stringify(recentSearches));
	    displayRecentSearches();
	}

	function clearAllRecentSearches() {
	    localStorage.removeItem('recentSearches');
	    displayRecentSearches();
	}

	searchInput.on('keydown', function(event) {
	    if (event.key === 'Enter') {
	        executeSearch($(this).val().trim());
	    }
	});

	searchInput.on('focus', function() {
	    displayRecentSearches();
	});

	$(document).on('click', function(event) {
	    if (!$(event.target).closest('.search').length) {
	        recentSearchesContainer.hide();
	    }
	});

	clearAllButton.on('click', clearAllRecentSearches);

	displayRecentSearches(); // 페이지 로드 시에도 표시 (localStorage에 있으면)

	const idInput = $('#signupId');
	const pwdInput = $('#signupPwd');
	const pwdConfirmInput = $('#signupPwdConfirm');

	const idMessage = $('#id-message');
	const pwdMessage = $('#pwd-message');
	const pwdConfirmMessage = $('#pwd-confirm-message');

	// 1. 아이디 유효성 검사 (6글자 이상 + 중복 확인)
	idInput.on('keyup', function() {
	    const id = $(this).val();

	    if (id.length === 0) {
	        idMessage.text('').removeClass('success error');
	        return;
	    }

	    if (id.length < 6) {
	        idMessage.text('아이디는 6글자 이상이어야 합니다.').removeClass('success').addClass('error');
	        return;
	    }

	    // AJAX를 통해 서버에 아이디 중복 확인 요청
	    $.ajax({
	        url: '/user/checkId', // UserController에 만든 API 경로
	        type: 'POST',
	        data: { id: id },
	        success: function(response) {
	            if (response.available) {
	                idMessage.text('사용 가능한 아이디입니다.').removeClass('error').addClass('success');
	            } else {
	                idMessage.text('이미 사용 중인 아이디입니다.').removeClass('success').addClass('error');
	            }
	        },
	        error: function() {
	            idMessage.text('ID 중복 확인 중 오류 발생').removeClass('success').addClass('error');
	        }
	    });
	});

	// 2. 비밀번호 유효성 검사 (6글자 이상)
	pwdInput.on('keyup', function() {
	    const pwd = $(this).val();

	    if (pwd.length === 0) {
	        pwdMessage.text('').removeClass('success error');
	    } else if (pwd.length < 6) {
	        pwdMessage.text('비밀번호는 6글자 이상이어야 합니다.').removeClass('success').addClass('error');
	    } else {
	        pwdMessage.text('사용 가능한 비밀번호입니다.').removeClass('error').addClass('success');
	    }
	    // 비밀번호 확인 필드의 값도 실시간으로 다시 검사하기 위해 keyup 이벤트를 발생시킴
	    pwdConfirmInput.trigger('keyup');
	});

	// 3. 비밀번호 확인 유효성 검사 (일치 여부)
	pwdConfirmInput.on('keyup', function() {
	    const pwd = pwdInput.val();
	    const pwdConfirm = $(this).val();

	    if (pwdConfirm.length === 0) {
	        pwdConfirmMessage.text('').removeClass('success error');
	        return;
	    }

	    if (pwd === pwdConfirm) {
	        pwdConfirmMessage.text('비밀번호가 일치합니다.').removeClass('error').addClass('success');
	    } else {
	        pwdConfirmMessage.text('비밀번호가 일치하지 않습니다.').removeClass('success').addClass('error');
	    }
	});
	
});