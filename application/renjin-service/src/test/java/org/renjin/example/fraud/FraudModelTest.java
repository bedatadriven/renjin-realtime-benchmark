package org.renjin.example.fraud;

import org.junit.Test;


public class FraudModelTest {

  @Test
  public void testScore() {

    FraudModel fraudModel = new FraudModel();
    double score = fraudModel.score(60000, 40, 30);
    
    System.out.println(score);
  }
  
}