terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.32.1"
    }
  }
  backend "s3" {
    bucket         	   = "tf-backend-state-0109ccc5"
    key              	 = "tfstate/core.tfstate"
    region         	   = "ap-southeast-1"
    encrypt        	   = true
  }
}

provider "aws" {
  region = "ap-southeast-1"
}