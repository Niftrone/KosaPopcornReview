package com.service.popcornreview.dto;
import java.util.Map;

/**
 * 관람객 통계(성별, 연령대) 데이터를 전달하기 위한 DTO
 */
public class AudienceStatsDto {
	// 성별 통계 (Key: "남성", Value: 45.8)
    private Map<String, Double> genderDistribution;

    // 연령대별 통계 (Key: "20대", Value: 55.0)
    private Map<String, Double> ageDistribution;

    
    // Getter: genderDistribution 맵 데이터를 가져오는 메서드
    public Map<String, Double> getGenderDistribution() {
        return genderDistribution;
    }

    // Setter: genderDistribution 맵 데이터를 저장하는 메서드
    public void setGenderDistribution(Map<String, Double> genderDistribution) {
        this.genderDistribution = genderDistribution;
    }

    // Getter: ageDistribution 맵 데이터를 가져오는 메서드
    public Map<String, Double> getAgeDistribution() {
        return ageDistribution;
    }

    // Setter: ageDistribution 맵 데이터를 저장하는 메서드
    public void setAgeDistribution(Map<String, Double> ageDistribution) {
        this.ageDistribution = ageDistribution;
    }
}
