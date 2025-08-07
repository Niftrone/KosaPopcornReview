$(document).ready(function() {
    // --- 예시 데이터 (DB 대신 사용) ---
    const mainReviewText = `"고스트 라이더"는 그냥 그저 그런 히어로가 질리는 분들께 아주 잘 맞는 영화일겁니다. 잔인한 장면은 별로 없지만 분위기만으로 사람을 압도하는 매력이 있습니다.\n\n니콜라스 케이지가 연기한 '쟈니 블레이즈'는 캐릭터의 고뇌와 분노를 잘 표현했습니다. 특히 바이크를 타고 질주하는 장면들은 정말 멋졌습니다.\n\n다만, 스토리가 조금 단순하고 예측 가능하다는 점은 아쉽습니다. 하지만 킬링타임용으로는 충분히 재미있게 볼 수 있는 영화라고 생각합니다.`;

    // 가짜 댓글 데이터를 생성하는 함수
    let commentCounter = 0;
    function generateMockComments(count) {
        const comments = [];
        const users = ['영화매니아98', '고스트팬', 'popcornfan', '이글아이', '시네필'];
        for (let i = 0; i < count; i++) {
            commentCounter++;
            const userIndex = commentCounter % users.length;
            comments.push({
                id: commentCounter,
                author: users[userIndex],
                date: `2025-07-25 09:${String(20 + commentCounter).padStart(2, '0')}`,
                text: `댓글 예시 데이터 ${commentCounter}번 입니다. 이 댓글은 자동으로 생성되었습니다.ddddddddddd dddddddddddddddd ddddddddddddddddddd dddddddddddddddddddddd d`
            });
        }
        return comments;
    }

    // --- textarea 자동 높이 조절 ---
    $('.comment-input').on('input', function () {
        $(this).css('height', 'auto');
        const scrollHeight = this.scrollHeight;
        $(this).css('height', scrollHeight + 2 + 'px');
    });

    // --- 초기 화면 구성 및 무한 스크롤 설정 ---
    
    // 1. 리뷰 본문 채우기
    $('#review-main-text').text(mainReviewText);

    // 2. 변수 설정
    let allCommentsLoaded = false;
    let isLoading = false; // 중복 로딩 방지를 위한 플래그
    const commentListSection = $('#comment-list-section');
    const loader = $('#loader');
    let observer;

    // 3. 댓글 로드 함수
    function loadComments() {
        if (allCommentsLoaded || isLoading) return;

        isLoading = true;
        loader.show(); 

        // DB 통신을 흉내 내는 1초 딜레이
        setTimeout(() => {
            const newComments = generateMockComments(10);
            
            if (newComments.length > 0) {
                newComments.forEach(comment => {
                    const commentHtml = `
                        <div class="comment-item">
                            <p class="comment-text">${comment.text}</p>
                            <div class="comment-info">
                                <span class="comment-author">${comment.author}</span>
                                <span class="comment-date">${comment.date}</span>
                            </div>
                        </div>
                    `;
                    commentListSection.append(commentHtml);
                });
            }

            if (commentCounter >= 50) {
                allCommentsLoaded = true;
                observer.disconnect(); 
            }

            loader.hide();
            isLoading = false; 

            setupObserver();

        }, 1000);
    }

    // 4. IntersectionObserver 설정 함수
    function setupObserver() {
        if (observer) {
            observer.disconnect();
        }

        const commentItems = commentListSection.find('.comment-item');
        
        if (commentItems.length > 1) {
            const target = commentItems[commentItems.length - 2]; // 마지막에서 두 번째 요소 (9번째)
            
            observer = new IntersectionObserver((entries) => {
                if (entries[0].isIntersecting) {
                    loadComments(); // 다음 댓글 로드
                    observer.unobserve(target); // 한 번 로드 후 감시 중지 (중복 방지)
                }
            }, {
                threshold: 0.5
            });

            observer.observe(target); 
        }
    }

    loadComments(); // 첫 댓글 10개 로드
});