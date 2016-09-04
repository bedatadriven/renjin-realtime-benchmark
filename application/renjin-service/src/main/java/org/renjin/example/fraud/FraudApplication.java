package org.renjin.example.fraud;

import io.dropwizard.Application;
import io.dropwizard.setup.Environment;

public class FraudApplication extends Application<FraudConfiguration> {

  public static void main(String[] args) throws Exception {
    new FraudApplication().run(args);
  }
  
  @Override
  public void run(FraudConfiguration fraudConfiguration, Environment environment) throws Exception {
    final FraudModel resource = new FraudModel();
    environment.jersey().register(resource);
  }
}
