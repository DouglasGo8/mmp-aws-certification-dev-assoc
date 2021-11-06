package com.udemy.aws.cert.dev.lambda.dto;


import lombok.Getter;

/**
 * @author dougdb
 */
@Getter
public class LanguageScoreDto {
  private  String score;
  private  String language;

  public LanguageScoreDto(String score, String language)
  {
    this.score = score;
    this.language = language;
  }


}
