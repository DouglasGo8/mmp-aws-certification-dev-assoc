package com.udemy.aws.cert.dev.lambda;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import com.udemy.aws.cert.dev.lambda.domain.Language;
import com.udemy.aws.cert.dev.lambda.dto.LanguageScoreDto;

import javax.inject.Named;
import java.util.HashMap;

/**
 * @author dougdb
 */
@Named("languageScoreLambda")
public class LanguageScoreLambda implements RequestHandler<Language, APIGatewayProxyResponseEvent> {


  //@Inject
  //ProducerTemplate producerTemplate;

  @Override
  public APIGatewayProxyResponseEvent handleRequest(Language input, Context context) {

    var logger = context.getLogger();

    logger.log("handleRequest the Main Function");
    logger.log(context.toString());


    var dto = new LanguageScoreDto("5", input.getLanguage()).toString();

    //this.producerTemplate.requestBody("{{language.score.direct.endpoint}}",
    //input, String.class);

    return new APIGatewayProxyResponseEvent()
            .withStatusCode(200)
            .withHeaders(new HashMap<>() {{
              put("Content-Type", "application/json");
            }})
            .withBody(dto)
            .withIsBase64Encoded(false);


  }
}
