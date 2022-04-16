terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.65.0"
    }
  }
}

provider "aws" {
  region                  = var.region
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = var.aws_profile
}


# Security gruop (SG)

resource "aws_security_group" "new_vm_sg" {
  name        = format("%s-%s-server", var.project, var.environment)
  description = format("%s project security group", var.project)
  vpc_id      = var.vpc_id

  ingress {
    description = "Backend"
    from_port   = 9030
    to_port     = 9030
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
  }

  ingress {
    description = "Frontend"
    from_port   = 9031
    to_port     = 9031
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
  }

  tags = {
    "Name"        = format("%s-server", var.project),
    "Project"     = var.project,
    "Environment" = var.environment
  }
}


# EC2 instance

resource "aws_instance" "new_vm_ec2" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  subnet_id         = var.subnet_id
  key_name          = var.key_name
  security_groups   = [var.ssh_sg, var.monitoring_sg, aws_security_group.new_vm_sg.id]

  depends_on = [
    aws_security_group.new_vm_sg
  ]

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    delete_on_termination = true
    volume_type           = "gp3"
    tags = {
      "Name"        = format("%s-%s-so", var.project, var.environment),
      "Project"     = var.project,
      "Environment" = var.environment
    }
  }

  ebs_block_device {
    delete_on_termination = true
    volume_type           = "gp3"
    volume_size           = 30
    device_name           = "/dev/sdf"
    tags = {
      "Name"        = format("%s-%s-data", var.project, var.environment),
      "Project"     = var.project,
      "Environment" = var.environment
    }
  }

  tags = {
    "Name"        = format("%s-server", var.project),
    "Project"     = var.project,
    "Environment" = var.environment
  }
}
