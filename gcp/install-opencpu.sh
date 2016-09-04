#!/bin/sh
# Requires Ubuntu 14.04 (Trusty) or 16.04 (Xenial)
sudo add-apt-repository -y ppa:opencpu/opencpu-1.6
sudo apt-get update 

# Installs OpenCPU server
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq opencpu

# Copy the extra configuration to /etc/
sudo cp /tmp/opencpu.conf /etc/opencpu/server.conf.d/fraud.conf

# Install the Fraudscore package
sudo R -q -e 'install.packages("/tmp/fraudscore_1.2.tar.gz", repos = NULL, type = "source")'

# Increase the number of open files allowed
sudo sh -c "echo * soft nofile 65535 >> /etc/security/limits.d/opencpu.conf"
sudo sh -c "echo * hard nofile 65535 >> /etc/security/limits.d/opencpu.conf"

# Restart after configuration changes
sudo service opencpu restart


