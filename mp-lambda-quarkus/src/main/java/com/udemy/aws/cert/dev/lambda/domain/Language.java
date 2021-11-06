package com.udemy.aws.cert.dev.lambda.domain;

import lombok.Getter;

/**
 * @author dougdb
 */
@Getter
public class Language {
  private String language;

  public Language setLanguage(String language) {
    this.language = language;
    return this;
  }
}
