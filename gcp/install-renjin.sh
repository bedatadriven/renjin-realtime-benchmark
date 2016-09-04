#!/bin/sh

sudo apt-get update
sudo apt-get install -yq openjdk-8-jdk-headless

sudo dpkg -i /tmp/fraud-scorer-1.2.deb

sudo service fraud-scorer start

# Redirect port 80 -> 8080
sudo /sbin/iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080

sudo sh -c "echo * soft nofile 65535 >> /etc/security/limits.d/renjin.conf"
sudo sh -c "echo * hard nofile 65535 >> /etc/security/limits.d/renjin.conf"

sudo service fraud-scorer restart

