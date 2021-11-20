package com.udemy.aws.cert.dev.lambda.bean;


import com.udemy.aws.cert.dev.lambda.domain.Language;
import com.udemy.aws.cert.dev.lambda.dto.LanguageScoreDto;
import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.NoArgsConstructor;
import org.apache.camel.Body;
import org.apache.camel.Handler;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Named;
import java.util.Locale;

/**
 * @author dougdb
 */
@Named
@NoArgsConstructor
@ApplicationScoped
@RegisterForReflection
public class LanguageScoreBean {

  /*@Handler
  public LanguageScoreDto fromMyDto(final @Header(Ddb2Constants.ATTRIBUTES) Map<String, AttributeValue> header) {
    var score = header.get("Score").n();
    var language = header.get("Language").s();
    return new LanguageScoreDto(score, language);
  }*/


  @Handler
  public LanguageScoreDto fromMyDto(final @Body Language language) {
    // var score = header.get("Score").n();
    // var language = header.get("Language").s();

    switch (language.getLanguage().toLowerCase(Locale.ROOT)) {
      case "java":
        return new LanguageScoreDto("5", language.getLanguage());
      case "python":
        return new LanguageScoreDto("3", language.getLanguage());
      case "javascript":
        return new LanguageScoreDto("4", language.getLanguage());
      default:
        return new LanguageScoreDto("-1", language.getLanguage());
    }
  }
}
