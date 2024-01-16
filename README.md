## ASSIGNMENT WALKTHROUGH
This github repository contains a sample DevOps assignment.
The purpose of this assignment is to demonstrate a working deployment of a load balanced nginx servers hosted on AWS

### Step 1
First, the launchpad is used to create a s3 bucket to store the remote backend terraform state files. It follows best practices where the objects in the bucket should be encrypted, block all public access, enable versioning and only `bucketOwner` can access. For generation of ssh key pair, it is suggested to creats a ssh key pair locally, and use the `keypair.tf` file to upload the key pair to aws.

### Step 2
Next, the infra contains the setup of the cloud infrastructure resources used to create a load balanced nginx server. It will not be a complicated setup, hence I have decided not to use modules to keep things simple. We have an internet gateway in the vpc, connected to an application load balancer in a public subnet that will serve HTTP/HTTPS request. To keep things simple, I have not installed a self-signed certificate on the load balancer, hence it will server HTTP request only. This ALB is then connected to the backend target group, containing an auto-scaling group of ec2 servers hosting a simple nginx web server (desired capacity at two). The pre-generated key pair can be referenced in the launch template to be used to ssh into the instances. The ASG contains private ec2 instances in private subnet, so you can ssh into them in other ways.

### Step 3
The Github Actions pipeline contains a workflow to deploy cloud infrastructure on AWS created using the Terraform. The best practice is to create a OpenID Connect federated identity to give the workflow time limited access to AWS environment. That was created manually beforehand. Typically, developers will not push into the main branch without any branch protection or raising any PR.

---
