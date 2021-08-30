package com.udemy.aws.cert.dev.assoc.ec2;


import io.quarkus.runtime.Quarkus;
import io.quarkus.runtime.annotations.QuarkusMain;
import org.apache.camel.quarkus.main.CamelMainApplication;

/**
 * @author dougdb
 */
@QuarkusMain
public class MainApp {
  public static void main(String... args) {
    Quarkus.run(CamelMainApplication.class, args);
  }
}
