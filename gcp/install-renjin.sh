#!/bin/sh

sudo apt-get update
sudo apt-get -yq install jetty9

# Download the fraud-score example to Jetty's web app directory
curl https://nexus.bedatadriven.com/content/groups/public/org/renjin/examples/renjin-fraud-score-server/1.0-SNAPSHOT/renjin-fraud-score-server-1.0-20160903.100028-2.war > /tmp/root.war
sudo cp /tmp/root.war /usr/share/jetty9/webapps
sudo service jetty9 restart

# Redirect port 80 -> 8080
sudo /sbin/iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080

