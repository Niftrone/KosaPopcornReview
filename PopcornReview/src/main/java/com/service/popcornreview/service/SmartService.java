package com.service.popcornreview.service;

import java.util.List;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.service.popcornreview.dto.SummaryRequest;
import com.service.popcornreview.dto.SummaryResponse;
import com.service.popcornreview.vo.Movie;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate; 

@Service
public class SmartService {

    private final RestTemplate restTemplate; // 2. RestClient 필드를 RestTemplate 필드로 변경합니다.

    // FastAPI 서버의 기본 URL을 설정합니다.
    // 실제 운영 환경에서는 application.properties나 yml 파일에서 관리하는 것이 좋습니다.
    private final String fastApiUrl = "http://127.0.0.1:8000"; // 예: FastAPI 서버 주소

    // 3. 생성자에서 RestTemplate Bean을 주입받도록 수정합니다.
    public SmartService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    /**
     * 영화 정보와 리뷰 목록을 FastAPI 서버로 보내 요약 결과를 받아옵니다.
     * @param movie 영화 정보 객체
     * @param reviews 리뷰 문자열 리스트
     * @return 요약 결과 응답 객체
     */
    public SummaryResponse getSummary(Movie movie, List<String> reviews) {

        // 1. FastAPI 서버로 보낼 요청 DTO(Request DTO)를 생성합니다.
        SummaryRequest requestDto = new SummaryRequest(movie, reviews);

        // (디버깅용) 요청 본문을 JSON으로 변환하여 출력
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonBody = objectMapper.writeValueAsString(requestDto);
            System.out.println(">>> FastAPI로 보내는 JSON 요청 본문: " + jsonBody);
        } catch (JsonProcessingException e) {
            System.out.println(">>> DTO를 JSON으로 변환 중 에러 발생: " + e.getMessage());
        }

        // 2. RestTemplate을 사용하여 POST 요청을 보냅니다.
        try {
            // ✅ RestTemplate의 postForObject 메서드를 사용합니다.
            // 첫 번째 파라미터: 요청을 보낼 전체 URL
            // 두 번째 파라미터: 요청 본문에 포함될 객체 (자동으로 JSON으로 변환됩니다)
            // 세 번째 파라미터: 응답을 변환할 클래스 타입
            SummaryResponse response = restTemplate.postForObject(
                    fastApiUrl + "/summarize", // 전체 호출 URL
                    requestDto,                // 요청 Body
                    SummaryResponse.class      // 응답 객체 타입
            );

            return response;

        } catch (RestClientException e) {
            // 통신 오류 처리
            System.err.println("FastAPI 통신 오류: " + e.getMessage());
            return new SummaryResponse("요약 서버와의 통신에 실패했습니다.");
        }
    }
}