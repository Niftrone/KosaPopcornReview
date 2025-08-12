package com.service.popcornreview.dto;

// Lombok import 구문은 모두 삭제합니다.

/**
 * 요약 결과를 받을 DTO (Lombok 없이 직접 작성)
 */
public class SummaryResponse {

    private String summary; // 1. private 필드 선언

    // 2. 기본 생성자 (프레임워크에서 객체를 생성할 때 필요할 수 있습니다)
    public SummaryResponse() {
    }
    
    public SummaryResponse(String summary) {
        this.summary = summary;
    }

    // 3. Getter 메소드: 'summary' 필드의 값을 반환합니다.
    public String getSummary() {
        return this.summary;
    }

    // 4. Setter 메소드: 'summary' 필드의 값을 설정합니다.
    public void setSummary(String summary) {
        this.summary = summary;
    }

    // 5. toString() 메소드 (디버깅 시 객체 내용을 쉽게 확인하기 위해 추가하면 좋습니다)
    @Override
    public String toString() {
        return "SummaryResponse{" +
               "summary='" + summary + '\'' +
               '}';
    }
}