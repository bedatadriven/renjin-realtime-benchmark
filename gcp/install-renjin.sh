#!/bin/sh

sudo apt-get update
supo apt-get install -yq openjdk-9-jre-headless

dpkg -i /tmp/fraud-scorer-1.2.deb

sudo service fraud-scorer start

# Redirect port 80 -> 8080
sudo /sbin/iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080

