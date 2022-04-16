variable "aws_profile" {
  default     = "profile1"
  description = "AWS CLI profile"
}

variable "region" {
  default = "us-east-1"
  description = "AWS region"
}

variable "project" {
  default     = "Lemonade"
  description = "Project name"
}

variable "vpc_id" {
  default = "vpc-xxxx"
}

variable "cidr_blocks" {
  default = "172.31.0.0/16"
}

variable "environment" {
  default     = "test"
  description = "Project environment"
}

variable "ami" {
  default     = "ami-xxxx"
  description = "SO AMI ID"
}

variable "instance_type" {
  default     = "t3.medium"
  description = "EC2 Type"
}

variable "availability_zone" {
  default = "us-east-1b"
}

variable "subnet_id" {
  default = "subnet-xxxx"
}

variable "key_name" {
  default = "key"
  description = "EC2 key to access instance"
}

variable "ssh_sg" {
  default = "sg-xxxx"
  description = "Security group to SSH access"
}

variable "monitoring_sg" {
  default = "sg-xxxx"
  description = "Security group for monitoring application access"
}
