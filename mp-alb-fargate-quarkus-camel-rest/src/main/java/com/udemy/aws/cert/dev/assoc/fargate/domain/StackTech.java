package com.udemy.aws.cert.dev.assoc.fargate.domain;


import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author dougdb
 */
@Getter
@AllArgsConstructor
@RegisterForReflection
public class StackTech {
  private final String message;
}
