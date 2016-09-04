#!/bin/sh

# This script builds the application under test for both 
# Renjin and OpenCPU

# Package the fraudscore package as tar.gz
(cd application; R CMD build fraudscore)


