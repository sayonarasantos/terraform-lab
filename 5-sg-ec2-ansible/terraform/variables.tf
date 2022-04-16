#
# Access configutations
#

variable "region" {
  default = "us-east-1"
  description = "AWS region"
}

# Replace this variable with your aws cli profile name, you find them inside of the file (~/.aws/config)
variable "profile" {
   default     = "profile1"
   description = "AWS CLI profile"
}

variable "ssh_user" {
  default = "admin"
}

variable "private_key_path" {
  default = "/home/amy/key.pem"
}


#
# Project configurations
#

variable "project" {
  default = "born-this-way"
  description = "Project name"
}

variable "environment" {
  default     = "test"
  description = "Project environment"
}


#
# VM configurations
#

variable "key_name" {
  default = "key"
  description = "EC2 key to access instance"
}

variable "ami" {
  default = "ami-xxxx"
  description = "SO AMI ID"
}

variable "instance_type" {
  default     = "t3.medium"
  description = "EC2 Type"
}


#
# Network
#

variable "availability_zone" {
  default = "us-east-1a"
}

variable "vpc_id" {
  default = "vpc-xxxx"
}

variable "subnet_id" {
  default = "subnet-xxxx"
}

variable "cidr_blocks" {
  default = "172.31.0.0/16"
}

variable "ssh_sg" {
  default = "sg-xxxx"
  description = "Security group to SSH access"
}

variable "monitoring_sg" {
  default = "sg-xxxx"
  description = "Security group for monitoring application access"
}