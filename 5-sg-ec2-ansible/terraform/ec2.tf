resource "aws_instance" "new_vm_ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.ssh_sg, var.monitoring_sg, aws_security_group.new_vm_sg.id]

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    delete_on_termination = true
    volume_type           = "gp3"
    volume_size           = 20
    tags = {
      "Name"        = format("%s-%s-so", var.project, var.environment),
      "Project"     = var.project,
      "Environment" = var.environment
    }
  }

  tags = {
    "Name"        = format("%s-server", var.project),
    "Project"     = var.project,
    "Environment" = var.environment
  }

  depends_on = [
    aws_security_group.new_vm_sg
  ]
}