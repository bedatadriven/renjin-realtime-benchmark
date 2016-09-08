#!/bin/sh

# This script builds the application under test for both 
# Renjin and OpenCPU

# Package the fraudscore package as tar.gz
(cd application; R CMD build fraudscore)

# Invoke Apache Maven to build a .deb package for the service
# that we can deploy directly.
(cd application/renjin-service; mvn clean package)
