package com.udemy.aws.cert.dev.assoc.ec2.port.beans;

import com.udemy.aws.cert.dev.assoc.ec2.domain.Welcome;
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
public class MediationBean {

  @Handler
  @SneakyThrows
  public Welcome sayHello(final @Body String body) {
    return new Welcome(String.format("Hi %s, welcome to AWS EC2 HostName %s - IP %s",
            body, InetAddress.getLocalHost().getHostName(),
            InetAddress.getLocalHost()));
  }
}
