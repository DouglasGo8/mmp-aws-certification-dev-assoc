package com.udemy.aws.cert.dev.assoc.ec2.domain;


import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@RegisterForReflection
public class Welcome {
  private final String message;
}
