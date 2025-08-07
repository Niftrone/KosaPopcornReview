$(document).ready(function(){
    
    // 1. 배너 슬라이더 설정
    $('.banner-slider').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: true,       // 화살표 표시
        dots: false,        // 점 네비게이션 숨김
        autoplay: true,     // 자동 재생
        autoplaySpeed: 2000,// 5초마다 슬라이드
        fade: true,         // 부드럽게 사라지고 나타나는 효과
        infinite: true,
        cssEase: 'linear'
    });

    // 2. 영화 카드 리스트 슬라이더 설정
    $('.movie-card-list').slick({
        slidesToShow: 5,     // 한 번에 5개 표시
        slidesToScroll: 5,   // 한 번에 5개씩 이동
        arrows: true,
        dots: false,
        infinite: false,     // 무한 반복 안함 (목록 끝에 도달하면 멈춤)
        responsive: [ // 반응형 설정
            {
                breakpoint: 1320,
                settings: {
                    slidesToShow: 4,
                    slidesToScroll: 4
                }
            },
            {
                breakpoint: 1024,
                settings: {
                    slidesToShow: 3,
                    slidesToScroll: 3
                }
            },
            {
                breakpoint: 600, 
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 2
                }
            }
        ]
    });

    // 3. 리뷰 카드 리스트 슬라이더 설정
    $('.review-card-list').slick({
        slidesToShow: 3,
        slidesToScroll: 3,
        arrows: true,
        dots: false,
        infinite: false,
        responsive: [
            {
                breakpoint: 1024,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 2
                }
            },
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 1,
                    slidesToScroll: 1
                }
            }
        ]
    });

    // 4. 공지사항 슬라이더
    $('.notice-list').slick({
        vertical: true, 
        slidesToShow: 1,        
        autoplay: true,         
        autoplaySpeed: 3000,  
        arrows: false,    
    });

    $('.notice-item').on('click', function(e) {
        e.preventDefault(); // a 태그의 기본 동작(페이지 이동) 방지

        // 클릭한 공지사항의 data-* 속성에서 정보 가져오기
        const title = $(this).data('title');
        const date = $(this).data('date');
        const content = $(this).data('content');

        // 가져온 정보로 모달 내용 채우기
        $('#noticeModalTitle').text(title);
        $('#noticeModalDate').text('작성일: ' + date);
        $('#noticeModalContent').text(content);

        // 모달창 보이기
        $('#noticeDetailModal').addClass('active');
    });

    // 모달 닫기 버튼 클릭 시
    $('#closeNoticeModal').on('click', function() {
        $('#noticeDetailModal').removeClass('active');
    });

    // 모달 배경 클릭 시 닫기
    $('#noticeDetailModal').on('click', function(e) {
        // 클릭된 요소가 모달 배경 자체일 때만 닫기
        if ($(e.target).is('.modal-overlay')) {
            $(this).removeClass('active');
        }
    });

});