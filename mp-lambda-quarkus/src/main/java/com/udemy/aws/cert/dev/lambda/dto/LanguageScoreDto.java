package com.udemy.aws.cert.dev.lambda.dto;


import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author dougdb
 */
@Getter
@AllArgsConstructor
@RegisterForReflection
public class LanguageScoreDto {
  private final String score;
  private final String language;
}
