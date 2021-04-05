#!/bin/bash

# Install requirements 

apt-get update
apt-get -y install python-pip
apt-get -y install awscli

apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get -y install docker-ce
apt-get -y install docker-compose

# Copy files from s3 bucket 

mkdir -p /root/hello-api
aws s3 cp s3://test-atsuky-bucket/hello_image.tar /root/hello-api/hello_image.tar --region eu-west-1
aws s3 cp s3://test-atsuky-bucket/docker-compose.yml /root/hello-api/docker-compose.yml --region eu-west-1
aws s3 cp s3://test-atsuky-bucket/default.conf /root/hello-api/default.conf --region eu-west-1

# Load docker images

docker load < /root/hello-api/hello_image.tar

# Start Docker Compose

cd /root/hello-api && docker-compose up -d