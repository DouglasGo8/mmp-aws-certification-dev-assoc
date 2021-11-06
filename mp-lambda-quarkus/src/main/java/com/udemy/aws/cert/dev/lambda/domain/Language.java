package com.udemy.aws.cert.dev.lambda.domain;

import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * @author dougdb
 */
@Getter
@NoArgsConstructor
@AllArgsConstructor
@RegisterForReflection
public class Language {
  private String language;
}
