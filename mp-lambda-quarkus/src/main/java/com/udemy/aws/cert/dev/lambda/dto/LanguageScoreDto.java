package com.udemy.aws.cert.dev.lambda.dto;


import lombok.Getter;

/**
 * @author dougdb
 */
@Getter
public class LanguageScoreDto {
  private final String score;
  private final String language;

  public LanguageScoreDto(String score, String language) {
    this.score = score;
    this.language = language;
  }
  
}
