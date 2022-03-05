package com.udemy.aws.cert.dev.assoc.bucket.mediation;


import lombok.NoArgsConstructor;
import org.apache.camel.builder.RouteBuilder;

import javax.enterprise.context.ApplicationScoped;

@NoArgsConstructor
@ApplicationScoped
public class S3ManagementRoute extends RouteBuilder {
  @Override
  public void configure() {

    onException(Exception.class)
            .log("${body}");

    final var accessKey = "accessKeyHere";
    final var secretAccess = "secretAccessHere";

    final var s3endPoint = String.format("aws2-s3://mycamelpawbucket?accessKey=%s&secretKey=%s&operation=%s",
            accessKey, secretAccess, "listObjects");


    from("timer://myS3BucketTimer?period=10s&fixedRate=true")
            .to(s3endPoint)
            .log("${body}") // list of items
            .end();
  }
}
