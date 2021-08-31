package com.udemy.aws.cert.dev.assoc.fargate.adapter.in.bean;

import com.udemy.aws.cert.dev.assoc.fargate.domain.StackTech;
import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.SneakyThrows;
import org.apache.camel.Body;
import org.apache.camel.Handler;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Named;
import java.net.InetAddress;

/**
 * @author dougdb
 */
@Named
@ApplicationScoped
@RegisterForReflection
public class StackGreeting {
  @Handler
  @SneakyThrows
  public StackTech sayHello(@Body final String name) {
    final var hostName = InetAddress.getLocalHost().getHostName();
    final var hostAddress = InetAddress.getLocalHost().getHostAddress();
    final var message = String.format("Hi %s from %s-%s, Quarkus/Camel Rocks!!!", name, hostName, hostAddress);
    return new StackTech(message);
  }

}
