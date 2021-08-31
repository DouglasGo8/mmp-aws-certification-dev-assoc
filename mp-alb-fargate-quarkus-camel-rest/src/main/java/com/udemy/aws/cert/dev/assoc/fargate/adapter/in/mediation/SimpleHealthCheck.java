package com.udemy.aws.cert.dev.assoc.fargate.adapter.in.mediation;

import org.eclipse.microprofile.health.HealthCheck;
import org.eclipse.microprofile.health.HealthCheckResponse;
import org.eclipse.microprofile.health.Liveness;

import javax.enterprise.context.ApplicationScoped;

/**
 * @author dougdb
 */
@Liveness
@ApplicationScoped
public class SimpleHealthCheck implements HealthCheck {
  @Override
  public HealthCheckResponse call() {
    return HealthCheckResponse.up("Simple health check");
  }
}
