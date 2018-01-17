#!/bin/bash

##############################################################################################
## Install ELK Stack (Elasticsearch , Logstash, and Kibana) on Ubuntu 16.04 LTS
##
## Author: Sultony Akbar
## Date: 2018/01/17
## Version: 0.1
##
## LIST VERSI ELASTICSEARCH, LOGSTASH, and KIBANA:
## 
## ELASTICSEARCH                    : https://www.elastic.co/downloads/elasticsearch
## LOGSTASH                         : https://www.elastic.co/downloads/logstash
## KIBANA                           : https://www.elastic.co/downloads/kibana
##
##############################################################################################

# Versions of elasticsearch, logstash, and kibana you want to install
ELK_VERSION=6.x

# Install dependencies
add-apt-repository -y ppa:webupd8team/java
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/${ELK_VERSION}/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-${ELK_VERSION}.list
apt-get update
apt-get install -y openjdk-8-jre-headless

##############################################################################################
########## INSTALL ELASTICSEARCH
##############################################################################################
apt-get -y install elasticsearch
wget https://raw.githubusercontent.com/sultonyakbar/elk/elasticsearch/elasticsearch.yml -O /etc/elasticsearch/elasticsearch.yml
systemctl restart elasticsearch
systemctl daemon-reload
systemctl enable elasticsearch

##############################################################################################
########## INSTALL LOGSTASH
##############################################################################################
apt-get -y install logstash
wget https://raw.githubusercontent.com/sultonyakbar/elk/elasticsearch/elasticsearch.yml -O /etc/elasticsearch/elasticsearch.yml

#Generate SSL Certificates
mkdir -p /etc/pki/tls/certs
mkdir /etc/pki/tls/private
#nano /etc/ssl/openssl.cnf
cd /etc/pki/tls
openssl req -config /etc/ssl/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt

#Configure Logstash
touch /etc/logstash/conf.d/{input,filter,output}.conf
wget https://raw.githubusercontent.com/sultonyakbar/elk/logstash/input.conf -O /etc/logstash/conf.d/input.conf
wget https://raw.githubusercontent.com/sultonyakbar/elk/logstash/input.conf -O /etc/logstash/conf.d/filter.conf
wget https://raw.githubusercontent.com/sultonyakbar/elk/logstash/input.conf -O /etc/logstash/conf.d/output.conf
systemctl restart logstash
systemctl enable logstash
##############################################################################################
########## INSTALL KIBANA
##############################################################################################
apt-get -y install kibana
wget https://raw.githubusercontent.com/sultonyakbar/elk/kibana/kibana.yml -O /etc/kibana/kibana/kibana.yml
