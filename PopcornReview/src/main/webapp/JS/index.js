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
        vertical: true,         // 세로 방향으로 슬라이드
        slidesToShow: 1,        
        autoplay: true,         
        autoplaySpeed: 3000,  
        arrows: false,    
        verticalSwiping: true   // 모바일에서 세로 스와이프 기능 활성화
    });

});