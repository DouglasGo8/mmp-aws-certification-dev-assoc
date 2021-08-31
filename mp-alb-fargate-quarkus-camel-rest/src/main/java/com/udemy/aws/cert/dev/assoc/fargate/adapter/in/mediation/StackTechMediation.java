package com.udemy.aws.cert.dev.assoc.fargate.adapter.in.mediation;

import org.apache.camel.builder.RouteBuilder;

/**
 * @author dougdb
 */
public class StackTechMediation extends RouteBuilder {

  @Override
  public void configure() {

    from("{{direct.stacktech.mediation.endpoint}}").id("StackTechMediationRouteId")
            .to("bean:stackGreeting")
            .end();
  }
}
