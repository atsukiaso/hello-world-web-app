# Test Answers

## How long did it take to finish the test?

About 4h

## If you had more time, how could you improve your solution?

I would change the setup from an EC2 instance to Kubernetes/ECS, but I wanted to keep it as simple as I could, and add support for an ssl endpoint.

## What changes would you do to your solution to be deployed in a production environment?

First of all, I would extract all the harcoded configurations into variables that can be parametrized. Then I would move the generation of the code artifact to a pipeline in the code repository / CI system (Github actions, Gitlab CI , Azure Devops, Jenkins...).

I think that for this specific workload I would move the deployment into a Kubernetes cluster as an instance is a bit overkill for a simple api like the proposed on the challenge, but in the case that we want to keep the instance, I would generate an AMI with all the required software to reduce the bootrstap time for the instance. 

Also moving the image to an ECR would be a better option that uploading it to an S3 bucket.

## Why did you choose this language over others?

Python is the language that I feel more comfortable with and it's easy to be understood by people that never used it. Also the community is huge and there are plenty of framewokrs and libraries to be used. And if you have a problem with it is easy to find documentation about what you are trying to do. 

## What was the most challenging part and why?

Deploying all the solution in a single command. It add a lot of restrictions on what you can do and how.