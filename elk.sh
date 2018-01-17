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
apt-get install openjdk-8-jre-headless

##############################################################################################
########## INSTALL ELASTICSEARCH
##############################################################################################
wget https://raw.githubusercontent.com/sultonyakbar/elk/elasticsearch/elasticsearch.yml -O /etc/elasticsearch/elasticsearch.yml
systemctl restart elasticsearch
systemctl daemon-reload
systemctl enable elasticsearch

##############################################################################################
########## INSTALL LOGSTASH
##############################################################################################
apt-get install logstash
wget https://raw.githubusercontent.com/sultonyakbar/elk/elasticsearch/elasticsearch.yml -O /etc/elasticsearch/elasticsearch.yml
#Generate SSL Certificates
mkdir -p /etc/pki/tls/certs
mkdir /etc/pki/tls/private



