# Hello World Web API

## Software Requirements

* An AWS account with an API Key generated
* Terraform, docker and git installed on the system

## How to deploy it? 

1) Configure the AWS Credentials in the main.tf file
    * Change the provider access_key and secret_key with the credentials from your account

2) Configure the bucket name
    * As bucket names are unique, you shoud set up a bucket name for this deployment, this can be done by changing the variable "bucket_name" at the `variables.tf` file located in infrastructure folder.

3) Make sure that the requirements are met
    * Check that docker is installed by running `docker --version`
    * Check that terraform is installed by running `terraform --version`

4) Deploy the infrastructure
    * Move to `./infrastructure` and run `./build_deploy.sh`

5) Wait until terraform and the instace setup finish

6) Check the public ip of the instance
    * Run `terraform show` and look for `resource "aws_instance" "instance"`
    * Find the public ip address parameter named `public_ip`

7) Connect to the API with Curl
    * Run `curl {public_ip}/hello`

## Why this solution is better than others?

It's a simple solution using resources from AWS that are simple to understand and debug. Takes advantage of docker and docker compose and should be easily portable to a more "productive-like" infrastructure in the future if needed.