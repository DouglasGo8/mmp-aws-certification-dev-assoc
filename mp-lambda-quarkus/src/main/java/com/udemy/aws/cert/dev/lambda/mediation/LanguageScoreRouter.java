package com.udemy.aws.cert.dev.lambda.mediation;


import com.udemy.aws.cert.dev.lambda.domain.Language;
import lombok.NoArgsConstructor;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.aws2.ddb.Ddb2Constants;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.HashMap;

/**
 * @author dougdb
 */
@NoArgsConstructor
@ApplicationScoped
public class LanguageScoreRouter extends RouteBuilder {

  @Inject
  DynamoDbClient dbClient;

  @Override
  public void configure() throws Exception {

    from("{{language.score.direct.endpoint}}")
            .process(e -> {
              var body = e.getIn().getBody(Language.class);
              var key = new HashMap<String, AttributeValue>();
              key.put("Language", AttributeValue.builder().s(body.getLanguage()).build());
              e.getIn().setHeader(Ddb2Constants.KEY, key);
            })
            .to("{{language.score.dynamodb.endpoint}}")
            .to("bean:languageScoreBean")
            .end();
  }
}
