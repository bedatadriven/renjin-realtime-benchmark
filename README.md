# Renjin Throughput Benchmarks

## Applications under Test

We use a simple example of a credit card scoring model written in R, borrowed from the DeployR 
[Microsoft/java-example-fraud-score](https://github.com/Microsoft/java-example-fraud-score) repository:

* [application/fraudscore] contains the R code reformatted as package that can be used with OpenCPU
* [application/renjin-service] contains the same code embedded in a Java microservice using Jetty as an embedded server

Ensure that [GNU R](http://www.r-project.org) and [Apache Maven 3+](https://maven.apache.org/download.cgi) are installed
and then run `./build.sh` to build both projects. 

## Deployment

This repository contains the [Terraform](https://www.terraform.io/) 
configuration files to automatically setup and deploy configuration for the Google Cloud Platform (GCP).

To start, [download](https://www.terraform.io/downloads.html) and configure
the `terraform` binary. 

Once you have [setup(gcp/README.md) your GCP project and your local environment, run

    terraform apply gcp
  
Which will create a 4-core VM for each solution. 

The Renjin solution is accessible by querying:

    curl http://$RENJIN_IP/score?balance=40&numTrans=300&creditLine=40

The OpenCPU solution requires a POST request:

    curl http://$OPENCPU_IP/ocpu/library/fraudscore/R/score/json --data "balance=40&numTrans=300&creditLine=40" 


## Load Testing

The [jmeter](jmeter) directory contains parametrized test plans for [Apache JMeter](http://jmeter.apache.org/). 
The [run.sh](run.sh) shell script runs a series of JMeter load tests with increasing permutations of virtual machine
profiles and number of concurrent users. Requests logs are written to the [results/](results/) folder.

## Analysis

The [analysis](analysis/) folder contains a R Markdown document that analyses the results output by JMeter.




