package com.service.popcornreview.dto;

import java.util.Map;

/**
 * 리뷰 통계(평균 평점, 점수별 분포) 데이터를 전달하기 위한 DTO
 */
public class ReviewStatsDto {

    // 평균 평점 (예: 7.8)
    private double averageScore;

    // 점수별 분포도 (Key: 5, Value: 70.0) -> 5점 리뷰가 70%
    private Map<Integer, Double> scoreDistribution;

    // Getters & Setters
    public double getAverageScore() {
        return averageScore;
    }

    public void setAverageScore(double averageScore) {
        this.averageScore = averageScore;
    }

    public Map<Integer, Double> getScoreDistribution() {
        return scoreDistribution;
    }

    public void setScoreDistribution(Map<Integer, Double> scoreDistribution) {
        this.scoreDistribution = scoreDistribution;
    }
}
