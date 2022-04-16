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

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name"        = format("%s-server", var.project),
    "Project"     = var.project,
    "Environment" = var.environment
  }
}
