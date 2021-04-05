#!/bin/bash

# Build docker image

docker build -t hello_api:latest ../src/

# Save docker image 

docker save -o docker-images/hello_image.tar hello_api:latest

# Terraform deploy

terraform init
terraform apply