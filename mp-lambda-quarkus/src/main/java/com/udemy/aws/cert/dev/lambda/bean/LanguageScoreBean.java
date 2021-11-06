package com.udemy.aws.cert.dev.lambda.bean;


import com.udemy.aws.cert.dev.lambda.dto.LanguageScoreDto;
import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.NoArgsConstructor;
import org.apache.camel.Handler;
import org.apache.camel.Header;
import org.apache.camel.component.aws2.ddb.Ddb2Constants;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Named;
import java.util.Map;

/**
 * @author dougdb
 */
@Named
@NoArgsConstructor
@ApplicationScoped
@RegisterForReflection
public class LanguageScoreBean {

  @Handler
  public LanguageScoreDto fromMyDto(final @Header(Ddb2Constants.ATTRIBUTES) Map<String, AttributeValue> header) {
    var score = header.get("Score").n();
    var language = header.get("Language").s();
    return new LanguageScoreDto(score, language);
  }
}
