resource "aws_spot_instance_request" "new_vm_ec2" {
  ami                            = var.ami_id
  instance_type                  = var.instance_type
  spot_price                     = var.spot_price
  wait_for_fulfillment           = true
  instance_interruption_behavior = "stop"
  subnet_id                      = var.subnet_id
  vpc_security_group_ids         = [var.ssh_sg, var.monitoring_sg, aws_security_group.new_vm_sg.id]
  key_name                       = var.key_name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    delete_on_termination = true
    tags = {
      "Name"        = format("%s-%s-so", var.project, var.environment),
      "Project"     = var.project,
      "Environment" = var.environment
    }
  }

  ebs_block_device {
    volume_type           = "gp3"
    delete_on_termination = true
    volume_size           = 30
    device_name           = "/dev/sdb"
    tags = {
      "Name"        = format("%s-%s-data", var.project, var.environment),
      "Project"     = var.project,
      "Environment" = var.environment
    }
  }

  credit_specification {
    cpu_credits = "default"
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
