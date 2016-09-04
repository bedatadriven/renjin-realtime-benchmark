#!/bin/sh

# Stop if there are any errors
set -e

# Create a directory to hold the results
mkdir -p results

# Benchmark the performance as we scale the machine
# size vertically from 4 cores to 16

for cores in 4 8 16; do

    # Ensure our environment is up and running with
    # the right machine type 
    terraform apply -var machine_type=n1-standard-$cores gcp

    # Benchmark OpenCPU and Renjin against successive number of concurrent users

    for users in 10 50 100 200 500; do
       jmeter -Jhost=`terraform output renjin_ip` -Jusers=$users -Joutput="results/renjin-${cores}-${users}.csv" -n -t jmeter/Renjin-Fraud.jmx 
       jmeter -Jhost=`terraform output opencpu_ip` -Jusers=$users -Joutput="results/opencpu-${cores}-${users}.csv" -n -t jmeter/OpenCPU-Fraud.jmx 
    done
done

# Cleanup the environment

terraform destroy gcp
