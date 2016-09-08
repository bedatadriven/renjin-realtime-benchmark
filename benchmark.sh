#!/bin/sh

# Stop if there are any errors
set -e

# Create a directory to hold the results
mkdir -p results

# Benchmark the performance as we scale the machine
# size vertically from 4 cores to 16

# n1-standard-4
cores=4
terraform apply -var machine_type=n1-standard-$cores gcp
    
for users in 10 50 75 100 125 150; do
   rm -f results/renjin-${cores}-${users}.csv
   jmeter -Jhost=`terraform output renjin_ip` -Jusers=$users -Joutput="results/renjin-${cores}-${users}.csv" -n -t jmeter/Renjin-Fraud.jmx 
done

for users in 10 50 75 100 125 150; do
   rm -f results/opencpu-${cores}-${users}.csv
   jmeter -Jhost=`terraform output opencpu_ip` -Jusers=$users -Joutput="results/opencpu-${cores}-${users}.csv" -n -t jmeter/OpenCPU-Fraud.jmx 
#done

# n1-standard-8
cores=8
terraform apply -var machine_type=n1-standard-$cores gcp
    
for users in 10 50 100 200 300 400 500; do
  rm -f results/renjin-${cores}-${users}.csv
  jmeter -Jhost=`terraform output renjin_ip` -Jusers=$users -Joutput="results/renjin-${cores}-${users}.csv" -n -t jmeter/Renjin-Fraud.jmx 
done

for users in 10 50 100 200 300 400 500; do
  rm -f results/opencpu-${cores}-${users}.csv
  jmeter -Jhost=`terraform output opencpu_ip` -Jusers=$users -Joutput="results/opencpu-${cores}-${users}.csv" -n -t jmeter/OpenCPU-Fraud.jmx 
done

# n1-standard-16
cores=16
terraform apply -var machine_type=n1-standard-$cores gcp
    
for users in 10 50 100 200 300 400 500 800 1000; do
  rm -f results/renjin-${cores}-${users}.csv
  jmeter -Jhost=`terraform output renjin_ip` -Jusers=$users -Joutput="results/renjin-${cores}-${users}.csv" -n -t jmeter/Renjin-Fraud.jmx 
done

for users in 10 50 100 200 300 400 500; do
  rm -f results/opencpu-${cores}-${users}.csv
  jmeter -Jhost=`terraform output opencpu_ip` -Jusers=$users -Joutput="results/opencpu-${cores}-${users}.csv" -n -t jmeter/OpenCPU-Fraud.jmx 
done


