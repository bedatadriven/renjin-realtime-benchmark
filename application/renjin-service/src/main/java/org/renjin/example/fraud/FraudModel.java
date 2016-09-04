package org.renjin.example.fraud;


import com.codahale.metrics.annotation.Timed;
import org.renjin.script.RenjinScriptEngineFactory;
import org.renjin.sexp.DoubleVector;

import javax.script.Bindings;
import javax.script.ScriptEngine;
import javax.script.ScriptException;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import static javax.script.ScriptContext.ENGINE_SCOPE;

@Path("/score")
@Produces(MediaType.APPLICATION_JSON)
public class FraudModel {

  /**
   * Maintain one instance of Renjin for each request thread.
   */
  private static final ThreadLocal<ScriptEngine> ENGINE = new ThreadLocal<ScriptEngine>();
  
  @GET
  @Timed
  public double score(
      @QueryParam("balance") double balance, 
      @QueryParam("numTrans") double numTrans, 
      @QueryParam("creditLine") double creditLine) {

    ScriptEngine engine = ENGINE.get();
    if(engine == null) {
      engine = initEngine();
      ENGINE.set(engine);
    }
    
    Bindings bindings = engine.getBindings(ENGINE_SCOPE);
    bindings.put("balance", balance);
    bindings.put("numTrans", numTrans);
    bindings.put("creditLine", creditLine);

    try {
      engine.eval("score <- data.frame(balance=balance,numTrans=numTrans,creditLine=creditLine)");
      engine.eval("x <- predict(fraudModel, score)");

      DoubleVector x = (DoubleVector) bindings.get("x");
      double score = x.getElementAsDouble(0);

      return score;
      
    } catch (ScriptException e) {
      throw new RuntimeException("Prediction failed");
    }
  }
  
  private ScriptEngine initEngine() {
    try {
      // Do one-time initialization
      ScriptEngine engine;
      engine = new RenjinScriptEngineFactory().getScriptEngine();
      
      // Load the serialized model object from the classpath
      engine.eval("load('res:fraudModel.rData')");
      return engine;
    } catch (ScriptException e) {
      throw new RuntimeException("Failed to initialize ScriptEngine", e);
    }
  }
  
}
