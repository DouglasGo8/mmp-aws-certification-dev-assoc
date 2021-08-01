package com.udemy.aws.cert.dev.assoc.ec2.adapter.in.mediation;

import org.apache.camel.builder.RouteBuilder;

/**
 * @author dougdb
 */
public class WelcomeMediation extends RouteBuilder {

  @Override
  public void configure() throws Exception {

    from("{{direct.welcome.mediation.endpoint}}").id("WelcomeMediaRouteId")
            .to("bean:mediationBean")
            //.log("${body}")
            .end();
  }
}
