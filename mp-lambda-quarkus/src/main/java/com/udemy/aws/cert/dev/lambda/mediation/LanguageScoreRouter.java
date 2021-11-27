package com.udemy.aws.cert.dev.lambda.mediation;


import lombok.NoArgsConstructor;
import org.apache.camel.builder.RouteBuilder;

import javax.enterprise.context.ApplicationScoped;

/**
 * @author dougdb
 */
@NoArgsConstructor
@ApplicationScoped
public class LanguageScoreRouter extends RouteBuilder {

  // @Inject
  // DynamoDbClient dbClient;

  @Override
  public void configure() throws Exception {

    from("{{language.score.direct.endpoint}}")
            /*.process(e -> {
              //
              var body = e.getIn().getBody(Language.class);
              var key = new HashMap<String, AttributeValue>();
              //
              key.put("Language", AttributeValue.builder().s(body.getLanguage()).build());
              e.getIn().setHeader(Ddb2Constants.KEY, key);
            })*/
            //.to("{{language.score.dynamodb.endpoint}}")
            .to("bean:languageScoreBean")
            .end();
  }
}
