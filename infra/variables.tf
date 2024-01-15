variable "region" {
  description = "default region for this project"
  type = string
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "main vpc cidr"
  type = string
  default = "192.168.0.0/16"
}

variable "subnet_cidr_public" {
  description = "cidr blocks for public subnets"
  type = list(string)
  default = ["192.168.0.0/24", "192.168.1.0/24"]
}

variable "subnet_cidr_private" {
  description = "cidr blocks for private subnets"
  type = list(string)
  default = ["192.168.2.0/24"]
}

variable "subnet_az_public" {
  description = "availability zones for public subnets"
  type = list(string)
  default = ["ap-southeast-1a", "ap-southeast-1b" ]
}

variable "subnet_az_private" {
  description = "availability zones for private subnets"
  type = list(string)
  default = ["ap-southeast-1b"]
}