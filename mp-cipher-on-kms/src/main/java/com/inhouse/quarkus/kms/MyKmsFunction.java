package com.inhouse.quarkus.kms;


import javax.inject.Inject;
import javax.inject.Named;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.kms.KmsClient;
import software.amazon.awssdk.services.kms.model.DecryptRequest;

import java.util.Base64;
import java.util.Map;

@Named("MyKmsHandler")
public class MyKmsFunction implements RequestHandler<MyPojo, String> {

  @Inject
  KmsClient kms;

  @Override
  public String handleRequest(MyPojo myPojo, Context context) {

    var encryptedData = Base64.getDecoder().decode(System.getenv("DB_PWD").getBytes());
    var encryptionContext = Map.of("LambdaFunctionName", System.getenv("AWS_LAMBDA_FUNCTION_NAME"));
    var request = DecryptRequest.builder().ciphertextBlob(SdkBytes.fromByteArray(encryptedData))
            .encryptionContext(encryptionContext)
            .build();

    var plainText = kms.decrypt(request).plaintext().asUtf8String();

    //System.out.println(plainText);

    return "Hello " + myPojo.getInput() + " - " + plainText;
  }
}
