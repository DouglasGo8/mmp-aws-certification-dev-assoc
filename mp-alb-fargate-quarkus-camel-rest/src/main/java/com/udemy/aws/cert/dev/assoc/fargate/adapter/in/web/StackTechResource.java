package com.udemy.aws.cert.dev.assoc.fargate.adapter.in.web;

import com.udemy.aws.cert.dev.assoc.fargate.domain.StackTech;
import org.apache.camel.ProducerTemplate;
import org.jboss.resteasy.annotations.jaxrs.PathParam;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * @author dougdb
 */

@Path("/api/aws/")
public class StackTechResource {

  @Inject
  ProducerTemplate template;

  @GET
  @Path("/stack/{name}")
  @Produces(MediaType.APPLICATION_JSON)
  public Response sayHello(@PathParam final String name) {
    return Response.ok(template.requestBody("{{direct.stacktech.mediation.endpoint}}", name, StackTech.class)).build();
  }
}
