# Backend

resource "aws_lb_target_group" "backend_tg" {
  name        = "backend"
  target_type = "instance"
  protocol    = "HTTP"
  port        = 9030
  vpc_id      = var.vpc_id

  health_check {
    protocol = "HTTP"
    path     = "/health"
  }

  tags = {
    "Name"        = "Backend",
    "Project"     = var.project,
    "Environment" = var.environment
  }

  depends_on = [
    aws_spot_instance_request.new_vm_ec2
  ]
}

resource "aws_lb_target_group_attachment" "backend_tga" {
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = aws_spot_instance_request.new_vm_ec2.spot_instance_id
  port             = 9030

  depends_on = [
    aws_spot_instance_request.new_vm_ec2,
    aws_lb_target_group.backend_tg
  ]
}

# Frontend

resource "aws_lb_target_group" "frontend_tg" {
  name        = "frontend"
  target_type = "instance"
  protocol    = "HTTP"
  port        = 9031
  vpc_id      = var.vpc_id

  health_check {
    matcher = "200"
    path    = "/"
  }

  tags = {
    "Name"        = "Frontend",
    "Project"     = var.project,
    "Environment" = var.environment
  }

  depends_on = [
    aws_spot_instance_request.new_vm_ec2
  ]
}

resource "aws_lb_target_group_attachment" "frontend_tga" {
  target_group_arn = aws_lb_target_group.frontend_tg.arn
  target_id        = aws_spot_instance_request.new_vm_ec2.spot_instance_id
  port             = 9031

  depends_on = [
    aws_spot_instance_request.new_vm_ec2,
    aws_lb_target_group.frontend_tga
  ]
}
