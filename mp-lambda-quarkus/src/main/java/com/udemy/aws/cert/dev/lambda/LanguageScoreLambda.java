package com.udemy.aws.cert.dev.lambda;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.udemy.aws.cert.dev.lambda.domain.Language;
import com.udemy.aws.cert.dev.lambda.dto.LanguageScoreDto;
import org.apache.camel.ProducerTemplate;

import javax.inject.Inject;
import javax.inject.Named;

/**
 * @author dougdb
 */
@Named("languageScoreLambda")
public class LanguageScoreLambda implements RequestHandler<Language, LanguageScoreDto> {


  @Inject
  ProducerTemplate producerTemplate;

  @Override
  public LanguageScoreDto handleRequest(Language input, Context context) {

    var logger = context.getLogger();

    logger.log("handleRequest the Main Function");
    logger.log(context.toString());

    return this.producerTemplate.requestBody("{{language.score.direct.endpoint}}",
            input, LanguageScoreDto.class);
  }
}