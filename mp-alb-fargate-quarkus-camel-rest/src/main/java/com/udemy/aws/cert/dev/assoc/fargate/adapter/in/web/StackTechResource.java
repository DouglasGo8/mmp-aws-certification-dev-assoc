package com.udemy.aws.cert.dev.assoc.fargate.adapter.in.web;

import lombok.NoArgsConstructor;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.model.rest.RestBindingMode;

import javax.enterprise.context.ApplicationScoped;

/**
 * @author dougdb
 */
@NoArgsConstructor
@ApplicationScoped
public class WelcomeResource extends RouteBuilder {
  @Override
  public void configure() {

    final String portNumber = "8080";

    restConfiguration()
            // ----------------------------------------------
            .port(portNumber)
            .host("0.0.0.0")
            .component("netty-http")
            .bindingMode(RestBindingMode.json)
            .dataFormatProperty("prettyPrint", "true")
            // ----------------------------------------------
            .apiVendorExtension(true)
            .apiProperty("cors", "true")
            .apiProperty("api.title", "User API")
            .apiProperty("api.version", "1.0.0");


    rest("/api/aws/greeting").id("WelcomeResourceRouteId").get("/{name}")
            .to("{{direct.welcome.mediation.endpoint}}");
  }
}
