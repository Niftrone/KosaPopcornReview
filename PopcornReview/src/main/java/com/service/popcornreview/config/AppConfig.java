package com.service.popcornreview.config;

// import org.springframework.beans.factory.annotation.Value; // 1. 이 import 문을 삭제합니다.
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestTemplate;

@Configuration
public class AppConfig {

	 // RestTemplate은 URL을 직접 호출하는 방식이 더 일반적이므로
    // @Value 설정은 잠시 사용하지 않겠습니다.

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}