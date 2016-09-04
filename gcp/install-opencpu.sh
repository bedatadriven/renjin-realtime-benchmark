#!/bin/sh
# Requires Ubuntu 14.04 (Trusty) or 16.04 (Xenial)
sudo add-apt-repository -y ppa:opencpu/opencpu-1.6
sudo apt-get update 

# Installs OpenCPU server
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq opencpu

# Install the Fraudscore package
sudo R -q -e 'install.packages("/tmp/fraudscore_1.2.tar.gz", repos = NULL, type = "source")'
