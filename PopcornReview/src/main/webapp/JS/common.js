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

	
	
});